(** "<p>Retrieves the history for the specified alarm. You can filter the results by date range or item type. If an alarm name is not specified, the histories for all alarms are returned.</p> <p>CloudWatch retains the history of an alarm even if you delete the alarm.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeAlarmHistoryInput :
sig
  type t =
    {
    alarm_name: String.t option ;
    history_item_type: HistoryItemType.t option ;
    start_date: DateTime.t option ;
    end_date: DateTime.t option ;
    max_records: Integer.t option ;
    next_token: String.t option }
  val make :
    ?alarm_name:String.t ->
      ?history_item_type:HistoryItemType.t ->
        ?start_date:DateTime.t ->
          ?end_date:DateTime.t ->
            ?max_records:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeAlarmHistoryOutput = DescribeAlarmHistoryOutput
type input = DescribeAlarmHistoryInput.t
type output = DescribeAlarmHistoryOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error