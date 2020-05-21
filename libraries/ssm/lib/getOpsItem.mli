(** "<p>Get information about an OpsItem by using the ID. You must have permission in AWS Identity and Access Management (IAM) to view information about an OpsItem. For more information, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-getting-started.html\">Getting Started with OpsCenter</a> in the <i>AWS Systems Manager User Guide</i>.</p> <p>Operations engineers and IT professionals use OpsCenter to view, investigate, and remediate operational issues impacting the performance and health of their AWS resources. For more information, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter.html\">AWS Systems Manager OpsCenter</a> in the <i>AWS Systems Manager User Guide</i>. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetOpsItemRequest :
sig
  type t = {
    ops_item_id: String.t }
  val make : ops_item_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module GetOpsItemResponse = GetOpsItemResponse
type input = GetOpsItemRequest.t
type output = GetOpsItemResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error