(** "<p>Associates a CIDR block with your VPC. You can associate a secondary IPv4 CIDR block, or you can associate an Amazon-provided IPv6 CIDR block. The IPv6 CIDR block size is fixed at /56.</p> <p>For more information about associating CIDR blocks with your VPC and applicable restrictions, see <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html#VPC_Sizing\">VPC and Subnet Sizing</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AssociateVpcCidrBlockRequest :
sig
  type t =
    {
    amazon_provided_ipv6_cidr_block: Boolean.t option ;
    cidr_block: String.t option ;
    vpc_id: String.t ;
    ipv6_cidr_block_network_border_group: String.t option }
  val make :
    ?amazon_provided_ipv6_cidr_block:Boolean.t ->
      ?cidr_block:String.t ->
        vpc_id:String.t ->
          ?ipv6_cidr_block_network_border_group:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module AssociateVpcCidrBlockResult = AssociateVpcCidrBlockResult
type input = AssociateVpcCidrBlockRequest.t
type output = AssociateVpcCidrBlockResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error