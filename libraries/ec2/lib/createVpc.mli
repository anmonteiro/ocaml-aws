(** "<p>Creates a VPC with the specified IPv4 CIDR block. The smallest VPC you can create uses a /28 netmask (16 IPv4 addresses), and the largest uses a /16 netmask (65,536 IPv4 addresses). For more information about how large to make your VPC, see <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html\">Your VPC and Subnets</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p> <p>You can optionally request an Amazon-provided IPv6 CIDR block for the VPC. The IPv6 CIDR block uses a /56 prefix length, and is allocated from Amazon's pool of IPv6 addresses. You cannot choose the IPv6 range for your VPC.</p> <p>By default, each instance you launch in the VPC has the default DHCP options, which include only a default DNS server that we provide (AmazonProvidedDNS). For more information, see <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/VPC_DHCP_Options.html\">DHCP Options Sets</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p> <p>You can specify the instance tenancy value for the VPC when you create it. You can't change this value for the VPC after you create it. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/dedicated-instance.html\">Dedicated Instances</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateVpcRequest :
sig
  type t =
    {
    cidr_block: String.t ;
    amazon_provided_ipv6_cidr_block: Boolean.t option ;
    dry_run: Boolean.t option ;
    instance_tenancy: Tenancy.t option ;
    ipv6_cidr_block_network_border_group: String.t option }
  val make :
    cidr_block:String.t ->
      ?amazon_provided_ipv6_cidr_block:Boolean.t ->
        ?dry_run:Boolean.t ->
          ?instance_tenancy:Tenancy.t ->
            ?ipv6_cidr_block_network_border_group:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateVpcResult = CreateVpcResult
type input = CreateVpcRequest.t
type output = CreateVpcResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error