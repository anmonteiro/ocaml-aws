(** "<p>Describes the events for the specified EC2 Fleet during the specified time.</p> <p>EC2 Fleet events are delayed by up to 30 seconds before they can be described. This ensures that you can query by the last evaluated time and not miss a recorded event. EC2 Fleet events are available for 48 hours.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeFleetHistoryRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    event_type: FleetEventType.t option ;
    max_results: Integer.t option ;
    next_token: String.t option ;
    fleet_id: String.t ;
    start_time: DateTime.t }
  val make :
    ?dry_run:Boolean.t ->
      ?event_type:FleetEventType.t ->
        ?max_results:Integer.t ->
          ?next_token:String.t ->
            fleet_id:String.t -> start_time:DateTime.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeFleetHistoryResult = DescribeFleetHistoryResult
type input = DescribeFleetHistoryRequest.t
type output = DescribeFleetHistoryResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error