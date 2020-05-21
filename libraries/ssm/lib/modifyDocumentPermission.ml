open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyDocumentPermissionRequest =
  struct
    type t =
      {
      name: String.t
        [@ocaml.doc
          "<p>The name of the document that you want to share.</p>"];
      permission_type: DocumentPermissionType.t
        [@ocaml.doc
          "<p>The permission type for the document. The permission type can be <i>Share</i>.</p>"];
      account_ids_to_add: AccountIdList.t
        [@ocaml.doc
          "<p>The AWS user accounts that should have access to the document. The account IDs can either be a group of account IDs or <i>All</i>.</p>"];
      account_ids_to_remove: AccountIdList.t
        [@ocaml.doc
          "<p>The AWS user accounts that should no longer have access to the document. The AWS user account can either be a group of account IDs or <i>All</i>. This action has a higher priority than <i>AccountIdsToAdd</i>. If you specify an account ID to add and the same ID to remove, the system removes access to the document.</p>"];
      shared_document_version: String.t option
        [@ocaml.doc
          "<p>(Optional) The version of the document to share. If it's not specified, the system choose the <code>Default</code> version to share.</p>"]}
    let make ~name  ~permission_type  ?(account_ids_to_add= []) 
      ?(account_ids_to_remove= [])  ?shared_document_version  () =
      {
        name;
        permission_type;
        account_ids_to_add;
        account_ids_to_remove;
        shared_document_version
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.shared_document_version
              (fun f -> ("shared_document_version", (String.to_json f)));
           Some
             ("account_ids_to_remove",
               (AccountIdList.to_json v.account_ids_to_remove));
           Some
             ("account_ids_to_add",
               (AccountIdList.to_json v.account_ids_to_add));
           Some
             ("permission_type",
               (DocumentPermissionType.to_json v.permission_type));
           Some ("name", (String.to_json v.name))])
    let of_json j =
      {
        name = (String.of_json (Util.of_option_exn (Json.lookup j "name")));
        permission_type =
          (DocumentPermissionType.of_json
             (Util.of_option_exn (Json.lookup j "permission_type")));
        account_ids_to_add =
          (AccountIdList.of_json
             (Util.of_option_exn (Json.lookup j "account_ids_to_add")));
        account_ids_to_remove =
          (AccountIdList.of_json
             (Util.of_option_exn (Json.lookup j "account_ids_to_remove")));
        shared_document_version =
          (Util.option_map (Json.lookup j "shared_document_version")
             String.of_json)
      }
  end
module Output = Aws.BaseTypes.Unit
type input = ModifyDocumentPermissionRequest.t
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
            (Query.render (ModifyDocumentPermissionRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (ModifyDocumentPermissionRequest.to_headers req)), "")
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