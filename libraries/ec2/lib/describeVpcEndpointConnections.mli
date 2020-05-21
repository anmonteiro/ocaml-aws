(** "<p>Describes the VPC endpoint connections to your VPC endpoint services, including any endpoints that are pending your acceptance.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeVpcEndpointConnectionsRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    filters: FilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    ?dry_run:Boolean.t ->
      ?filters:FilterList.t ->
        ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeVpcEndpointConnectionsResult =
DescribeVpcEndpointConnectionsResult
type input = DescribeVpcEndpointConnectionsRequest.t
type output = DescribeVpcEndpointConnectionsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error