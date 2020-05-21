(** "<p>Modifies the VPC peering connection options on one side of a VPC peering connection. You can do the following:</p> <ul> <li> <p>Enable/disable communication over the peering connection between an EC2-Classic instance that's linked to your VPC (using ClassicLink) and instances in the peer VPC.</p> </li> <li> <p>Enable/disable communication over the peering connection between instances in your VPC and an EC2-Classic instance that's linked to the peer VPC.</p> </li> <li> <p>Enable/disable the ability to resolve public DNS hostnames to private IP addresses when queried from instances in the peer VPC.</p> </li> </ul> <p>If the peered VPCs are in the same AWS account, you can enable DNS resolution for queries from the local VPC. This ensures that queries from the local VPC resolve to private IP addresses in the peer VPC. This option is not available if the peered VPCs are in different AWS accounts or different Regions. For peered VPCs in different AWS accounts, each AWS account owner must initiate a separate request to modify the peering connection options. For inter-region peering connections, you must use the Region for the requester VPC to modify the requester VPC peering options and the Region for the accepter VPC to modify the accepter VPC peering options. To verify which VPCs are the accepter and the requester for a VPC peering connection, use the <a>DescribeVpcPeeringConnections</a> command.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyVpcPeeringConnectionOptionsRequest :
sig
  type t =
    {
    accepter_peering_connection_options:
      PeeringConnectionOptionsRequest.t option ;
    dry_run: Boolean.t option ;
    requester_peering_connection_options:
      PeeringConnectionOptionsRequest.t option ;
    vpc_peering_connection_id: String.t }
  val make :
    ?accepter_peering_connection_options:PeeringConnectionOptionsRequest.t ->
      ?dry_run:Boolean.t ->
        ?requester_peering_connection_options:PeeringConnectionOptionsRequest.t
          -> vpc_peering_connection_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyVpcPeeringConnectionOptionsResult =
ModifyVpcPeeringConnectionOptionsResult
type input = ModifyVpcPeeringConnectionOptionsRequest.t
type output = ModifyVpcPeeringConnectionOptionsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error