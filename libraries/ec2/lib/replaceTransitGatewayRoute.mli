(** "<p>Replaces the specified route in the specified transit gateway route table.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ReplaceTransitGatewayRouteRequest :
sig
  type t =
    {
    destination_cidr_block: String.t ;
    transit_gateway_route_table_id: String.t ;
    transit_gateway_attachment_id: String.t option ;
    blackhole: Boolean.t option ;
    dry_run: Boolean.t option }
  val make :
    destination_cidr_block:String.t ->
      transit_gateway_route_table_id:String.t ->
        ?transit_gateway_attachment_id:String.t ->
          ?blackhole:Boolean.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ReplaceTransitGatewayRouteResult = ReplaceTransitGatewayRouteResult
type input = ReplaceTransitGatewayRouteRequest.t
type output = ReplaceTransitGatewayRouteResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error