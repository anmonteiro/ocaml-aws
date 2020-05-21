(** "<p>Disassociates a resource attachment from a transit gateway route table.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DisassociateTransitGatewayRouteTableRequest :
sig
  type t =
    {
    transit_gateway_route_table_id: String.t ;
    transit_gateway_attachment_id: String.t ;
    dry_run: Boolean.t option }
  val make :
    transit_gateway_route_table_id:String.t ->
      transit_gateway_attachment_id:String.t ->
        ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DisassociateTransitGatewayRouteTableResult =
DisassociateTransitGatewayRouteTableResult
type input = DisassociateTransitGatewayRouteTableRequest.t
type output = DisassociateTransitGatewayRouteTableResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error