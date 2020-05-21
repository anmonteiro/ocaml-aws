(** "<p>Describes the events for the specified Spot Fleet request during the specified time.</p> <p>Spot Fleet events are delayed by up to 30 seconds before they can be described. This ensures that you can query by the last evaluated time and not miss a recorded event. Spot Fleet events are available for 48 hours.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeSpotFleetRequestHistoryRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    event_type: EventType.t option ;
    max_results: Integer.t option ;
    next_token: String.t option ;
    spot_fleet_request_id: String.t ;
    start_time: DateTime.t }[@@ocaml.doc
                              "<p>Contains the parameters for DescribeSpotFleetRequestHistory.</p>"]
  val make :
    ?dry_run:Boolean.t ->
      ?event_type:EventType.t ->
        ?max_results:Integer.t ->
          ?next_token:String.t ->
            spot_fleet_request_id:String.t ->
              start_time:DateTime.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeSpotFleetRequestHistoryResponse =
DescribeSpotFleetRequestHistoryResponse
type input = DescribeSpotFleetRequestHistoryRequest.t
type output = DescribeSpotFleetRequestHistoryResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error