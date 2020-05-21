open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module StartSessionRequest =
  struct
    type t =
      {
      target: String.t
        [@ocaml.doc "<p>The instance to connect to for the session.</p>"];
      document_name: String.t option
        [@ocaml.doc
          "<p>The name of the SSM document to define the parameters and plugin settings for the session. For example, <code>SSM-SessionManagerRunShell</code>. If no document name is provided, a shell to the instance is launched by default.</p>"];
      parameters: SessionManagerParameters.t option
        [@ocaml.doc "<p>Reserved for future use.</p>"]}
    let make ~target  ?document_name  ?parameters  () =
      { target; document_name; parameters }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.parameters
              (fun f -> ("parameters", (SessionManagerParameters.to_json f)));
           Util.option_map v.document_name
             (fun f -> ("document_name", (String.to_json f)));
           Some ("target", (String.to_json v.target))])
    let of_json j =
      {
        target =
          (String.of_json (Util.of_option_exn (Json.lookup j "target")));
        document_name =
          (Util.option_map (Json.lookup j "document_name") String.of_json);
        parameters =
          (Util.option_map (Json.lookup j "parameters")
             SessionManagerParameters.of_json)
      }
  end
module StartSessionResponse = StartSessionResponse
type input = StartSessionRequest.t
type output = StartSessionResponse.t
type error = Errors_internal.t
let streaming = false
let service = "ssm"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (StartSessionRequest.to_query req)))) in
  (`POST, uri, (Headers.render (StartSessionRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (StartSessionResponse.of_json json)
  with
  | Yojson.Json_error msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing JSON: " ^ msg) })
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