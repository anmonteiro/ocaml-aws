(** "<p>Describes the permissions for a Systems Manager document. If you created the document, you are the owner. If a document is shared, it can either be shared privately (by specifying a user's AWS account ID) or publicly (<i>All</i>). </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeDocumentPermissionRequest :
sig
  type t = {
    name: String.t ;
    permission_type: DocumentPermissionType.t }
  val make :
    name:String.t -> permission_type:DocumentPermissionType.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module DescribeDocumentPermissionResponse =
DescribeDocumentPermissionResponse
type input = DescribeDocumentPermissionRequest.t
type output = DescribeDocumentPermissionResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error