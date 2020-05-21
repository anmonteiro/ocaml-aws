(** "<p>Describes the specified associations between VPCs and local gateway route tables.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeLocalGatewayRouteTableVpcAssociationsRequest :
sig
  type t =
    {
    local_gateway_route_table_vpc_association_ids:
      LocalGatewayRouteTableVpcAssociationIdSet.t ;
    filters: FilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option ;
    dry_run: Boolean.t option }
  val make :
    ?local_gateway_route_table_vpc_association_ids:LocalGatewayRouteTableVpcAssociationIdSet.t
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
module DescribeLocalGatewayRouteTableVpcAssociationsResult =
DescribeLocalGatewayRouteTableVpcAssociationsResult
type input = DescribeLocalGatewayRouteTableVpcAssociationsRequest.t
type output = DescribeLocalGatewayRouteTableVpcAssociationsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error