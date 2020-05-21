(** "<p>Describes the actions scheduled for your Auto Scaling group that haven't run or that have not reached their end time. To describe the actions that have already run, use <a>DescribeScalingActivities</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeScheduledActionsType :
sig
  type t =
    {
    auto_scaling_group_name: String.t option ;
    scheduled_action_names: ScheduledActionNames.t ;
    start_time: DateTime.t option ;
    end_time: DateTime.t option ;
    next_token: String.t option ;
    max_records: Integer.t option }
  val make :
    ?auto_scaling_group_name:String.t ->
      ?scheduled_action_names:ScheduledActionNames.t ->
        ?start_time:DateTime.t ->
          ?end_time:DateTime.t ->
            ?next_token:String.t -> ?max_records:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ScheduledActionsType = ScheduledActionsType
type input = DescribeScheduledActionsType.t
type output = ScheduledActionsType.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error