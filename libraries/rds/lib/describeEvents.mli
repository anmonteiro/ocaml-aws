(** "<p>Returns events related to DB instances, DB security groups, DB snapshots, and DB parameter groups for the past 14 days. Events specific to a particular DB instance, DB security group, database snapshot, or DB parameter group can be obtained by providing the name as a parameter. By default, the past hour of events are returned.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeEventsMessage :
sig
  type t =
    {
    source_identifier: String.t option ;
    source_type: SourceType.t option ;
    start_time: DateTime.t option ;
    end_time: DateTime.t option ;
    duration: Integer.t option ;
    event_categories: EventCategoriesList.t ;
    filters: FilterList.t ;
    max_records: Integer.t option ;
    marker: String.t option }[@@ocaml.doc "<p/>"]
  val make :
    ?source_identifier:String.t ->
      ?source_type:SourceType.t ->
        ?start_time:DateTime.t ->
          ?end_time:DateTime.t ->
            ?duration:Integer.t ->
              ?event_categories:EventCategoriesList.t ->
                ?filters:FilterList.t ->
                  ?max_records:Integer.t -> ?marker:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module EventsMessage = EventsMessage
type input = DescribeEventsMessage.t
type output = EventsMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error