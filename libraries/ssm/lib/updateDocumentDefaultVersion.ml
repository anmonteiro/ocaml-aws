open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module UpdateDocumentDefaultVersionRequest =
  struct
    type t =
      {
      name: String.t
        [@ocaml.doc
          "<p>The name of a custom document that you want to set as the default version.</p>"];
      document_version: String.t
        [@ocaml.doc
          "<p>The version of a custom document that you want to set as the default version.</p>"]}
    let make ~name  ~document_version  () = { name; document_version }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("document_version", (String.to_json v.document_version));
           Some ("name", (String.to_json v.name))])
    let of_json j =
      {
        name = (String.of_json (Util.of_option_exn (Json.lookup j "name")));
        document_version =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "document_version")))
      }
  end
module UpdateDocumentDefaultVersionResult =
  UpdateDocumentDefaultVersionResult
type input = UpdateDocumentDefaultVersionRequest.t
type output = UpdateDocumentDefaultVersionResult.t
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
            (Query.render (UpdateDocumentDefaultVersionRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (UpdateDocumentDefaultVersionRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (UpdateDocumentDefaultVersionResult.of_json json)
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