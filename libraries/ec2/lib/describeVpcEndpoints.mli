(** "<p>Describes one or more of your VPC endpoints.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeVpcEndpointsRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    vpc_endpoint_ids: ValueStringList.t ;
    filters: FilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option }[@@ocaml.doc
                                   "<p>Contains the parameters for DescribeVpcEndpoints.</p>"]
  val make :
    ?dry_run:Boolean.t ->
      ?vpc_endpoint_ids:ValueStringList.t ->
        ?filters:FilterList.t ->
          ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeVpcEndpointsResult = DescribeVpcEndpointsResult
type input = DescribeVpcEndpointsRequest.t
type output = DescribeVpcEndpointsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error