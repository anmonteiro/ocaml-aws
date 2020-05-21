(** "<p>Associates the specified VPC with the specified local gateway route table.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateLocalGatewayRouteTableVpcAssociationRequest :
sig
  type t =
    {
    local_gateway_route_table_id: String.t ;
    vpc_id: String.t ;
    dry_run: Boolean.t option }
  val make :
    local_gateway_route_table_id:String.t ->
      vpc_id:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateLocalGatewayRouteTableVpcAssociationResult =
CreateLocalGatewayRouteTableVpcAssociationResult
type input = CreateLocalGatewayRouteTableVpcAssociationRequest.t
type output = CreateLocalGatewayRouteTableVpcAssociationResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error