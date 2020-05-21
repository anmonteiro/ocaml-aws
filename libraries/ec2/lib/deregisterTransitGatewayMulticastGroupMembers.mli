(** "<p>Deregisters the specified members (network interfaces) from the transit gateway multicast group.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeregisterTransitGatewayMulticastGroupMembersRequest :
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
module DeregisterTransitGatewayMulticastGroupMembersResult =
DeregisterTransitGatewayMulticastGroupMembersResult
type input = DeregisterTransitGatewayMulticastGroupMembersRequest.t
type output = DeregisterTransitGatewayMulticastGroupMembersResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error