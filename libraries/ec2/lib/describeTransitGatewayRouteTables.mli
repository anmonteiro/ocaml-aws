(** "<p>Describes one or more transit gateway route tables. By default, all transit gateway route tables are described. Alternatively, you can filter the results.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeTransitGatewayRouteTablesRequest :
sig
  type t =
    {
    transit_gateway_route_table_ids: TransitGatewayRouteTableIdStringList.t ;
    filters: FilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option ;
    dry_run: Boolean.t option }
  val make :
    ?transit_gateway_route_table_ids:TransitGatewayRouteTableIdStringList.t
      ->
      ?filters:FilterList.t ->
        ?max_results:Integer.t ->
          ?next_token:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeTransitGatewayRouteTablesResult =
DescribeTransitGatewayRouteTablesResult
type input = DescribeTransitGatewayRouteTablesRequest.t
type output = DescribeTransitGatewayRouteTablesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error