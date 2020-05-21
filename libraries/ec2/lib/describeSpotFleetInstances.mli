(** "<p>Describes the running instances for the specified Spot Fleet.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeSpotFleetInstancesRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    max_results: Integer.t option ;
    next_token: String.t option ;
    spot_fleet_request_id: String.t }[@@ocaml.doc
                                       "<p>Contains the parameters for DescribeSpotFleetInstances.</p>"]
  val make :
    ?dry_run:Boolean.t ->
      ?max_results:Integer.t ->
        ?next_token:String.t -> spot_fleet_request_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeSpotFleetInstancesResponse =
DescribeSpotFleetInstancesResponse
type input = DescribeSpotFleetInstancesRequest.t
type output = DescribeSpotFleetInstancesResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error