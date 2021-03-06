(** "<p>Registers members (network interfaces) with the transit gateway multicast group. A member is a network interface associated with a supported EC2 instance that receives multicast traffic. For information about supported instances, see <a href=\"https://docs.aws.amazon.com/vpc/latest/tgw/transit-gateway-limits.html#multicast-limits\">Multicast Consideration</a> in <i>Amazon VPC Transit Gateways</i>.</p> <p>After you add the members, use <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_SearchTransitGatewayMulticastGroups.html\">SearchTransitGatewayMulticastGroups</a> to verify that the members were added to the transit gateway multicast group.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RegisterTransitGatewayMulticastGroupMembersRequest :
sig
  type t =
    {
    transit_gateway_multicast_domain_id: String.t option ;
    group_ip_address: String.t option ;
    network_interface_ids: ValueStringList.t ;
    dry_run: Boolean.t option }
  val make :
    ?transit_gateway_multicast_domain_id:String.t ->
      ?group_ip_address:String.t ->
        ?network_interface_ids:ValueStringList.t ->
          ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module RegisterTransitGatewayMulticastGroupMembersResult =
RegisterTransitGatewayMulticastGroupMembersResult
type input = RegisterTransitGatewayMulticastGroupMembersRequest.t
type output = RegisterTransitGatewayMulticastGroupMembersResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error