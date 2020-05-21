(** "<p>Describes the VPC endpoint service configurations in your account (your services).</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeVpcEndpointServiceConfigurationsRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    service_ids: ValueStringList.t ;
    filters: FilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    ?dry_run:Boolean.t ->
      ?service_ids:ValueStringList.t ->
        ?filters:FilterList.t ->
          ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeVpcEndpointServiceConfigurationsResult =
DescribeVpcEndpointServiceConfigurationsResult
type input = DescribeVpcEndpointServiceConfigurationsRequest.t
type output = DescribeVpcEndpointServiceConfigurationsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error