(** "<p>Finds available schedules that meet the specified criteria.</p> <p>You can search for an available schedule no more than 3 months in advance. You must meet the minimum required duration of 1,200 hours per year. For example, the minimum daily schedule is 4 hours, the minimum weekly schedule is 24 hours, and the minimum monthly schedule is 100 hours.</p> <p>After you find a schedule that meets your needs, call <a>PurchaseScheduledInstances</a> to purchase Scheduled Instances with that schedule.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeScheduledInstanceAvailabilityRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    filters: FilterList.t ;
    first_slot_start_time_range: SlotDateTimeRangeRequest.t ;
    max_results: Integer.t option ;
    max_slot_duration_in_hours: Integer.t option ;
    min_slot_duration_in_hours: Integer.t option ;
    next_token: String.t option ;
    recurrence: ScheduledInstanceRecurrenceRequest.t }[@@ocaml.doc
                                                        "<p>Contains the parameters for DescribeScheduledInstanceAvailability.</p>"]
  val make :
    ?dry_run:Boolean.t ->
      ?filters:FilterList.t ->
        first_slot_start_time_range:SlotDateTimeRangeRequest.t ->
          ?max_results:Integer.t ->
            ?max_slot_duration_in_hours:Integer.t ->
              ?min_slot_duration_in_hours:Integer.t ->
                ?next_token:String.t ->
                  recurrence:ScheduledInstanceRecurrenceRequest.t ->
                    unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeScheduledInstanceAvailabilityResult =
DescribeScheduledInstanceAvailabilityResult
type input = DescribeScheduledInstanceAvailabilityRequest.t
type output = DescribeScheduledInstanceAvailabilityResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error