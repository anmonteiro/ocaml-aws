(** "<p>Deletes the specified association between a VPC and local gateway route table.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteLocalGatewayRouteTableVpcAssociationRequest :
sig
  type t =
    {
    local_gateway_route_table_vpc_association_id: String.t ;
    dry_run: Boolean.t option }
  val make :
    local_gateway_route_table_vpc_association_id:String.t ->
      ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DeleteLocalGatewayRouteTableVpcAssociationResult =
DeleteLocalGatewayRouteTableVpcAssociationResult
type input = DeleteLocalGatewayRouteTableVpcAssociationRequest.t
type output = DeleteLocalGatewayRouteTableVpcAssociationResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error