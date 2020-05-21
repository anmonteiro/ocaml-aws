(** "<p>Describes one or more of your egress-only internet gateways.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeEgressOnlyInternetGatewaysRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    egress_only_internet_gateway_ids: EgressOnlyInternetGatewayIdList.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    ?dry_run:Boolean.t ->
      ?egress_only_internet_gateway_ids:EgressOnlyInternetGatewayIdList.t ->
        ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeEgressOnlyInternetGatewaysResult =
DescribeEgressOnlyInternetGatewaysResult
type input = DescribeEgressOnlyInternetGatewaysRequest.t
type output = DescribeEgressOnlyInternetGatewaysResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error