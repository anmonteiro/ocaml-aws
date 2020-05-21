(** "<p>Describes the specified Scheduled Instances or all your Scheduled Instances.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeScheduledInstancesRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    filters: FilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option ;
    scheduled_instance_ids: ScheduledInstanceIdRequestSet.t ;
    slot_start_time_range: SlotStartTimeRangeRequest.t option }[@@ocaml.doc
                                                                 "<p>Contains the parameters for DescribeScheduledInstances.</p>"]
  val make :
    ?dry_run:Boolean.t ->
      ?filters:FilterList.t ->
        ?max_results:Integer.t ->
          ?next_token:String.t ->
            ?scheduled_instance_ids:ScheduledInstanceIdRequestSet.t ->
              ?slot_start_time_range:SlotStartTimeRangeRequest.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeScheduledInstancesResult = DescribeScheduledInstancesResult
type input = DescribeScheduledInstancesRequest.t
type output = DescribeScheduledInstancesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error