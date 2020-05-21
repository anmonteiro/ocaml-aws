(** "<p>Describes your Spot Fleet requests.</p> <p>Spot Fleet requests are deleted 48 hours after they are canceled and their instances are terminated.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeSpotFleetRequestsRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    max_results: Integer.t option ;
    next_token: String.t option ;
    spot_fleet_request_ids: ValueStringList.t }[@@ocaml.doc
                                                 "<p>Contains the parameters for DescribeSpotFleetRequests.</p>"]
  val make :
    ?dry_run:Boolean.t ->
      ?max_results:Integer.t ->
        ?next_token:String.t ->
          ?spot_fleet_request_ids:ValueStringList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeSpotFleetRequestsResponse = DescribeSpotFleetRequestsResponse
type input = DescribeSpotFleetRequestsRequest.t
type output = DescribeSpotFleetRequestsResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error