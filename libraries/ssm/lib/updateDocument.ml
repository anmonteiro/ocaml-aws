open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module UpdateDocumentRequest =
  struct
    type t =
      {
      content: String.t [@ocaml.doc "<p>A valid JSON or YAML string.</p>"];
      attachments: AttachmentsSourceList.t
        [@ocaml.doc
          "<p>A list of key and value pairs that describe attachments to a version of a document.</p>"];
      name: String.t
        [@ocaml.doc
          "<p>The name of the document that you want to update.</p>"];
      version_name: String.t option
        [@ocaml.doc
          "<p>An optional field specifying the version of the artifact you are updating with the document. For example, \"Release 12, Update 6\". This value is unique across all versions of a document, and cannot be changed.</p>"];
      document_version: String.t option
        [@ocaml.doc
          "<p>(Required) The version of the document that you want to update. </p>"];
      document_format: DocumentFormat.t option
        [@ocaml.doc
          "<p>Specify the document format for the new document version. Systems Manager supports JSON and YAML documents. JSON is the default format.</p>"];
      target_type: String.t option
        [@ocaml.doc "<p>Specify a new target type for the document.</p>"]}
    let make ~content  ?(attachments= [])  ~name  ?version_name 
      ?document_version  ?document_format  ?target_type  () =
      {
        content;
        attachments;
        name;
        version_name;
        document_version;
        document_format;
        target_type
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.target_type
              (fun f -> ("target_type", (String.to_json f)));
           Util.option_map v.document_format
             (fun f -> ("document_format", (DocumentFormat.to_json f)));
           Util.option_map v.document_version
             (fun f -> ("document_version", (String.to_json f)));
           Util.option_map v.version_name
             (fun f -> ("version_name", (String.to_json f)));
           Some ("name", (String.to_json v.name));
           Some
             ("attachments", (AttachmentsSourceList.to_json v.attachments));
           Some ("content", (String.to_json v.content))])
    let of_json j =
      {
        content =
          (String.of_json (Util.of_option_exn (Json.lookup j "content")));
        attachments =
          (AttachmentsSourceList.of_json
             (Util.of_option_exn (Json.lookup j "attachments")));
        name = (String.of_json (Util.of_option_exn (Json.lookup j "name")));
        version_name =
          (Util.option_map (Json.lookup j "version_name") String.of_json);
        document_version =
          (Util.option_map (Json.lookup j "document_version") String.of_json);
        document_format =
          (Util.option_map (Json.lookup j "document_format")
             DocumentFormat.of_json);
        target_type =
          (Util.option_map (Json.lookup j "target_type") String.of_json)
      }
  end
module UpdateDocumentResult = UpdateDocumentResult
type input = UpdateDocumentRequest.t
type output = UpdateDocumentResult.t
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
            (Query.render (UpdateDocumentRequest.to_query req)))) in
  (`POST, uri, (Headers.render (UpdateDocumentRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (UpdateDocumentResult.of_json json)
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