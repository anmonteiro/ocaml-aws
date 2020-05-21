(** "<p>Requests a VPC peering connection between two VPCs: a requester VPC that you own and an accepter VPC with which to create the connection. The accepter VPC can belong to another AWS account and can be in a different Region to the requester VPC. The requester VPC and accepter VPC cannot have overlapping CIDR blocks.</p> <note> <p>Limitations and rules apply to a VPC peering connection. For more information, see the <a href=\"https://docs.aws.amazon.com/vpc/latest/peering/vpc-peering-basics.html#vpc-peering-limitations\">limitations</a> section in the <i>VPC Peering Guide</i>.</p> </note> <p>The owner of the accepter VPC must accept the peering request to activate the peering connection. The VPC peering connection request expires after 7 days, after which it cannot be accepted or rejected.</p> <p>If you create a VPC peering connection request between VPCs with overlapping CIDR blocks, the VPC peering connection has a status of <code>failed</code>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateVpcPeeringConnectionRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    peer_owner_id: String.t option ;
    peer_vpc_id: String.t option ;
    vpc_id: String.t option ;
    peer_region: String.t option }
  val make :
    ?dry_run:Boolean.t ->
      ?peer_owner_id:String.t ->
        ?peer_vpc_id:String.t ->
          ?vpc_id:String.t -> ?peer_region:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateVpcPeeringConnectionResult = CreateVpcPeeringConnectionResult
type input = CreateVpcPeeringConnectionRequest.t
type output = CreateVpcPeeringConnectionResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error