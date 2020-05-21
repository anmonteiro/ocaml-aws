(** "<p>Returns events related to clusters, cache security groups, and cache parameter groups. You can obtain events specific to a particular cluster, cache security group, or cache parameter group by providing the name as a parameter.</p> <p>By default, only the events occurring within the last hour are returned; however, you can retrieve up to 14 days' worth of events if necessary.</p>" *)
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
    max_records: Integer.t option ;
    marker: String.t option }[@@ocaml.doc
                               "<p>Represents the input of a <code>DescribeEvents</code> operation.</p>"]
  val make :
    ?source_identifier:String.t ->
      ?source_type:SourceType.t ->
        ?start_time:DateTime.t ->
          ?end_time:DateTime.t ->
            ?duration:Integer.t ->
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