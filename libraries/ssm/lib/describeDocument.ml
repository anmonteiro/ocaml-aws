open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeDocumentRequest =
  struct
    type t =
      {
      name: String.t
        [@ocaml.doc "<p>The name of the Systems Manager document.</p>"];
      document_version: String.t option
        [@ocaml.doc
          "<p>The document version for which you want information. Can be a specific version or the default version.</p>"];
      version_name: String.t option
        [@ocaml.doc
          "<p>An optional field specifying the version of the artifact associated with the document. For example, \"Release 12, Update 6\". This value is unique across all versions of a document, and cannot be changed.</p>"]}
    let make ~name  ?document_version  ?version_name  () =
      { name; document_version; version_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.version_name
              (fun f -> ("version_name", (String.to_json f)));
           Util.option_map v.document_version
             (fun f -> ("document_version", (String.to_json f)));
           Some ("name", (String.to_json v.name))])
    let of_json j =
      {
        name = (String.of_json (Util.of_option_exn (Json.lookup j "name")));
        document_version =
          (Util.option_map (Json.lookup j "document_version") String.of_json);
        version_name =
          (Util.option_map (Json.lookup j "version_name") String.of_json)
      }
  end
module DescribeDocumentResult = DescribeDocumentResult
type input = DescribeDocumentRequest.t
type output = DescribeDocumentResult.t
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
            (Query.render (DescribeDocumentRequest.to_query req)))) in
  (`POST, uri, (Headers.render (DescribeDocumentRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (DescribeDocumentResult.of_json json)
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