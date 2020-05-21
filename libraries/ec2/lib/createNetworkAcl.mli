(** "<p>Creates a network ACL in a VPC. Network ACLs provide an optional layer of security (in addition to security groups) for the instances in your VPC.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/VPC_ACLs.html\">Network ACLs</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateNetworkAclRequest :
sig
  type t = {
    dry_run: Boolean.t option ;
    vpc_id: String.t }
  val make : ?dry_run:Boolean.t -> vpc_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateNetworkAclResult = CreateNetworkAclResult
type input = CreateNetworkAclRequest.t
type output = CreateNetworkAclResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error