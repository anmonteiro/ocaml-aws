(** "<p>Shares a Systems Manager document publicly or privately. If you share a document privately, you must specify the AWS user account IDs for those people who can use the document. If you share a document publicly, you must specify <i>All</i> as the account ID.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyDocumentPermissionRequest :
sig
  type t =
    {
    name: String.t ;
    permission_type: DocumentPermissionType.t ;
    account_ids_to_add: AccountIdList.t ;
    account_ids_to_remove: AccountIdList.t ;
    shared_document_version: String.t option }
  val make :
    name:String.t ->
      permission_type:DocumentPermissionType.t ->
        ?account_ids_to_add:AccountIdList.t ->
          ?account_ids_to_remove:AccountIdList.t ->
            ?shared_document_version:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module Output = Aws.BaseTypes.Unit
type input = ModifyDocumentPermissionRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error