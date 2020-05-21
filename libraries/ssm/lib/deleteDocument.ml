open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteDocumentRequest =
  struct
    type t =
      {
      name: String.t [@ocaml.doc "<p>The name of the document.</p>"];
      document_version: String.t option
        [@ocaml.doc
          "<p>The version of the document that you want to delete. If not provided, all versions of the document are deleted.</p>"];
      version_name: String.t option
        [@ocaml.doc
          "<p>The version name of the document that you want to delete. If not provided, all versions of the document are deleted.</p>"];
      force: Boolean.t option
        [@ocaml.doc
          "<p>Some SSM document types require that you specify a <code>Force</code> flag before you can delete the document. For example, you must specify a <code>Force</code> flag to delete a document of type <code>ApplicationConfigurationSchema</code>. You can restrict access to the <code>Force</code> flag in an AWS Identity and Access Management (IAM) policy.</p>"]}
    let make ~name  ?document_version  ?version_name  ?force  () =
      { name; document_version; version_name; force }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.force (fun f -> ("force", (Boolean.to_json f)));
           Util.option_map v.version_name
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
          (Util.option_map (Json.lookup j "version_name") String.of_json);
        force = (Util.option_map (Json.lookup j "force") Boolean.of_json)
      }
  end
module Output = Aws.BaseTypes.Unit
type input = DeleteDocumentRequest.t
type output = unit
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
            (Query.render (DeleteDocumentRequest.to_query req)))) in
  (`POST, uri, (Headers.render (DeleteDocumentRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) = `Ok ()
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