(** "<p>Describes the specified local gateway virtual interfaces.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeLocalGatewayVirtualInterfacesRequest :
sig
  type t =
    {
    local_gateway_virtual_interface_ids: LocalGatewayVirtualInterfaceIdSet.t ;
    filters: FilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option ;
    dry_run: Boolean.t option }
  val make :
    ?local_gateway_virtual_interface_ids:LocalGatewayVirtualInterfaceIdSet.t
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
module DescribeLocalGatewayVirtualInterfacesResult =
DescribeLocalGatewayVirtualInterfacesResult
type input = DescribeLocalGatewayVirtualInterfacesRequest.t
type output = DescribeLocalGatewayVirtualInterfacesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error