(** "<p>Describes the associations between virtual interface groups and local gateway route tables.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeLocalGatewayRouteTableVirtualInterfaceGroupAssociationsRequest
:
sig
  type t =
    {
    local_gateway_route_table_virtual_interface_group_association_ids:
      LocalGatewayRouteTableVirtualInterfaceGroupAssociationIdSet.t ;
    filters: FilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option ;
    dry_run: Boolean.t option }
  val make :
    ?local_gateway_route_table_virtual_interface_group_association_ids:LocalGatewayRouteTableVirtualInterfaceGroupAssociationIdSet.t
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
module DescribeLocalGatewayRouteTableVirtualInterfaceGroupAssociationsResult
= DescribeLocalGatewayRouteTableVirtualInterfaceGroupAssociationsResult
type input =
  DescribeLocalGatewayRouteTableVirtualInterfaceGroupAssociationsRequest.t
type output =
  DescribeLocalGatewayRouteTableVirtualInterfaceGroupAssociationsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error