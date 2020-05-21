(** "<p>Describes available services to which you can create a VPC endpoint.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeVpcEndpointServicesRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    service_names: ValueStringList.t ;
    filters: FilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option }[@@ocaml.doc
                                   "<p>Contains the parameters for DescribeVpcEndpointServices.</p>"]
  val make :
    ?dry_run:Boolean.t ->
      ?service_names:ValueStringList.t ->
        ?filters:FilterList.t ->
          ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeVpcEndpointServicesResult = DescribeVpcEndpointServicesResult
type input = DescribeVpcEndpointServicesRequest.t
type output = DescribeVpcEndpointServicesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error