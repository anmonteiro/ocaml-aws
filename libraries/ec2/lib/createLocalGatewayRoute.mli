(** "<p>Creates a static route for the specified local gateway route table.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateLocalGatewayRouteRequest :
sig
  type t =
    {
    destination_cidr_block: String.t ;
    local_gateway_route_table_id: String.t ;
    local_gateway_virtual_interface_group_id: String.t ;
    dry_run: Boolean.t option }
  val make :
    destination_cidr_block:String.t ->
      local_gateway_route_table_id:String.t ->
        local_gateway_virtual_interface_group_id:String.t ->
          ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateLocalGatewayRouteResult = CreateLocalGatewayRouteResult
type input = CreateLocalGatewayRouteRequest.t
type output = CreateLocalGatewayRouteResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error