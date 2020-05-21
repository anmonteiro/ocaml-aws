(** "<p>Retrieves the specified alarms. If no alarms are specified, all alarms are returned. Alarms can be retrieved by using only a prefix for the alarm name, the alarm state, or a prefix for any action.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeAlarmsInput :
sig
  type t =
    {
    alarm_names: AlarmNames.t ;
    alarm_name_prefix: String.t option ;
    state_value: StateValue.t option ;
    action_prefix: String.t option ;
    max_records: Integer.t option ;
    next_token: String.t option }
  val make :
    ?alarm_names:AlarmNames.t ->
      ?alarm_name_prefix:String.t ->
        ?state_value:StateValue.t ->
          ?action_prefix:String.t ->
            ?max_records:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeAlarmsOutput = DescribeAlarmsOutput
type input = DescribeAlarmsInput.t
type output = DescribeAlarmsOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error