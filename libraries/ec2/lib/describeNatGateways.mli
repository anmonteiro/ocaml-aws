(** "<p>Describes one or more of your NAT gateways.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeNatGatewaysRequest :
sig
  type t =
    {
    filter: FilterList.t ;
    max_results: Integer.t option ;
    nat_gateway_ids: ValueStringList.t ;
    next_token: String.t option }
  val make :
    ?filter:FilterList.t ->
      ?max_results:Integer.t ->
        ?nat_gateway_ids:ValueStringList.t ->
          ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeNatGatewaysResult = DescribeNatGatewaysResult
type input = DescribeNatGatewaysRequest.t
type output = DescribeNatGatewaysResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error