open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module Input = Aws.BaseTypes.Unit
module GetCallerIdentityResponse = GetCallerIdentityResponse
type input = unit
type output = GetCallerIdentityResponse.t
type error = Errors_internal.t
let streaming = false
let service = "sts"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      [("Version", ["2011-06-15"]); ("Action", ["GetCallerIdentity"])] in
  (`POST, uri, (Headers.render (Headers.List [])), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "GetCallerIdentityResponse" (snd xml))
        (Xml.member "GetCallerIdentityResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp GetCallerIdentityResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed GetCallerIdentityResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing GetCallerIdentityResponse - missing field in body or children: "
                      ^ msg)
               })
  with
  | Failure msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing xml: " ^ msg) })
let parse_error code err =
  let errors = [] @ Errors_internal.common in
  match Errors_internal.of_string err with
  | Some v ->
      if
        (List.mem v errors) &&
          ((match Errors_internal.to_http_code v with
            | Some x -> x = code
            | None -> true))
      then Some v
      else None
  | None -> None