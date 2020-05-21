(** "<p>Creates a default VPC with a size <code>/16</code> IPv4 CIDR block and a default subnet in each Availability Zone. For more information about the components of a default VPC, see <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/default-vpc.html\">Default VPC and Default Subnets</a> in the <i>Amazon Virtual Private Cloud User Guide</i>. You cannot specify the components of the default VPC yourself.</p> <p>If you deleted your previous default VPC, you can create a default VPC. You cannot have more than one default VPC per Region.</p> <p>If your account supports EC2-Classic, you cannot use this action to create a default VPC in a Region that supports EC2-Classic. If you want a default VPC in a Region that supports EC2-Classic, see \"I really want a default VPC for my existing EC2 account. Is that possible?\" in the <a href=\"http://aws.amazon.com/vpc/faqs/#Default_VPCs\">Default VPCs FAQ</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateDefaultVpcRequest :
sig
  type t = {
    dry_run: Boolean.t option }
  val make : ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateDefaultVpcResult = CreateDefaultVpcResult
type input = CreateDefaultVpcRequest.t
type output = CreateDefaultVpcResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error