(** "<p>Changes which network ACL a subnet is associated with. By default when you create a subnet, it's automatically associated with the default network ACL. For more information, see <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/VPC_ACLs.html\">Network ACLs</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p> <p>This is an idempotent operation.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ReplaceNetworkAclAssociationRequest :
sig
  type t =
    {
    association_id: String.t ;
    dry_run: Boolean.t option ;
    network_acl_id: String.t }
  val make :
    association_id:String.t ->
      ?dry_run:Boolean.t -> network_acl_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ReplaceNetworkAclAssociationResult =
ReplaceNetworkAclAssociationResult
type input = ReplaceNetworkAclAssociationRequest.t
type output = ReplaceNetworkAclAssociationResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error