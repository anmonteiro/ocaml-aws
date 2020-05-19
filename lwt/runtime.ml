(*----------------------------------------------------------------------------
    Copyright (c) 2016 Inhabited Type LLC.

    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions
    are met:

    1. Redistributions of source code must retain the above copyright
       notice, this list of conditions and the following disclaimer.

    2. Redistributions in binary form must reproduce the above copyright
       notice, this list of conditions and the following disclaimer in the
       documentation and/or other materials provided with the distribution.

    3. Neither the name of the author nor the names of his contributors
       may be used to endorse or promote products derived from this software
       without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE CONTRIBUTORS ``AS IS'' AND ANY EXPRESS
    OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED.  IN NO EVENT SHALL THE AUTHORS OR CONTRIBUTORS BE LIABLE FOR
    ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
    DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
    OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
    HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
    STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
    ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
    POSSIBILITY OF SUCH DAMAGE.
  ----------------------------------------------------------------------------*)

open Lwt.Infix

type t =
  { conn : Piaf.Client.t
  ; uri : Uri.t
  ; region : string
  ; access_key : string
  ; secret_key : string
  }

let to_meth = function
  | #Piaf.Method.t as t -> t
  | `PATCH -> `Other "PATCH"

let create_connection ?config ~region ~access_key ~secret_key service =
  let open Aws in
  let svc = Services.to_string service in
  let uri = Uri.of_string (Util.of_option_exn (Endpoints.url_of svc region)) in
  Piaf.Client.create ?config uri >|= function
    | Ok conn ->
      Ok { conn; uri; region; access_key; secret_key }
    | Error msg ->
      Error (Aws.Error.TransportError (Piaf.Error.to_string msg))

let shutdown t =
  Piaf.Client.shutdown t.conn

let run_request_generic
  (type input)
  (type output)
  (type error)
  (module M : Aws.Call with type input = input
                        and type output = output
                        and type error = error)
  req_fn ~headers ~body ~meth path =
  let open Piaf in
  Lwt.catch (fun () ->
    req_fn
      ~headers
      ~body
      ~meth:(to_meth meth)
      path
    >>= function
      | Ok { Piaf.Response.body; status; headers;_ } ->
        let code = Status.to_code status in
        if code >= 300 then begin
          let open Aws.Error in
          Body.to_string body
          >|= (function
            | Ok body ->
              let aws_error =
                match parse_aws_error body with
                | `Error message -> BadResponse { body; message }
                | `Ok ers ->
                  AwsError (List.map (fun (aws_code, message) ->
                    match M.parse_error code aws_code with
                    | None   -> (Unknown aws_code, message)
                    | Some e -> (Understood e    , message))
                    ers)
              in
              Error (HttpError (code, aws_error))
            | Error err ->
              Error (TransportError (Piaf.Error.to_string err)))
        end else begin
         let header_list = Headers.to_list headers in
         let body = if M.streaming then
           Lwt_result.return (`Streaming body)
          else
           Lwt_result.map (fun body -> `String body) (Body.to_string body)
         in
         body >|= function
           | Ok body ->
             begin match M.of_http header_list body with
             | `Ok v -> Ok v
             | `Error t -> Error (Aws.Error.HttpError (code, t))
             end
           | Error error ->
             Error (TransportError (Piaf.Error.to_string error))
        end
      | Error _ -> assert false)
  (function
    | Failure msg -> Lwt.return (Error (Aws.Error.TransportError msg))
    | exn         -> Lwt.fail exn)

let run_request
    (type input)
    (type output)
    (type error)
    t
    (module M : Aws.Call with type input = input
                          and type output = output
                          and type error = error)
    (inp : M.input)
  =
  let { conn; region; access_key; secret_key; _ } = t in
  let meth, uri, headers, body =
    Aws.Signing.sign_request
      ~access_key
      ~secret_key
      ~service:M.service
      ~region
      (M.to_http M.service region inp)
  in
  run_request_generic
    (module M)
    (fun ~headers ~body ~meth path ->
      Piaf.Client.request conn ~headers ~body ~meth path)
    ~headers ~body ~meth (Uri.path_and_query uri)

module Oneshot = struct
  let run_request
      (type input)
      (type output)
      (type error)
      ?config
      ~region
      ~access_key
      ~secret_key
      (module M : Aws.Call with type input = input
                            and type output = output
                            and type error = error)
      (inp : M.input)
    =
    let meth, uri, headers, body =
      Aws.Signing.sign_request
        ~access_key
        ~secret_key
        ~service:M.service
        ~region
        (M.to_http M.service region inp)
    in
    run_request_generic
      (module M)
      (fun ~headers ~body ~meth uri ->
        Piaf.Client.Oneshot.request ?config ~headers ~body ~meth uri)
      ~headers ~body ~meth uri
end
