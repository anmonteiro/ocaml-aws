(** "<p>Describes one or more local gateway route tables. By default, all local gateway route tables are described. Alternatively, you can filter the results.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeLocalGatewayRouteTablesRequest :
sig
  type t =
    {
    local_gateway_route_table_ids: LocalGatewayRouteTableIdSet.t ;
    filters: FilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option ;
    dry_run: Boolean.t option }
  val make :
    ?local_gateway_route_table_ids:LocalGatewayRouteTableIdSet.t ->
      ?filters:FilterList.t ->
        ?max_results:Integer.t ->
          ?next_token:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeLocalGatewayRouteTablesResult =
DescribeLocalGatewayRouteTablesResult
type input = DescribeLocalGatewayRouteTablesRequest.t
type output = DescribeLocalGatewayRouteTablesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error