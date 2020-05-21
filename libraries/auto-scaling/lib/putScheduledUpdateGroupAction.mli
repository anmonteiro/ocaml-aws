(** "<p>Creates or updates a scheduled scaling action for an Auto Scaling group. If you leave a parameter unspecified when updating a scheduled scaling action, the corresponding value remains unchanged.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/schedule_time.html\">Scheduled Scaling</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PutScheduledUpdateGroupActionType :
sig
  type t =
    {
    auto_scaling_group_name: String.t ;
    scheduled_action_name: String.t ;
    time: DateTime.t option ;
    start_time: DateTime.t option ;
    end_time: DateTime.t option ;
    recurrence: String.t option ;
    min_size: Integer.t option ;
    max_size: Integer.t option ;
    desired_capacity: Integer.t option }
  val make :
    auto_scaling_group_name:String.t ->
      scheduled_action_name:String.t ->
        ?time:DateTime.t ->
          ?start_time:DateTime.t ->
            ?end_time:DateTime.t ->
              ?recurrence:String.t ->
                ?min_size:Integer.t ->
                  ?max_size:Integer.t ->
                    ?desired_capacity:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = PutScheduledUpdateGroupActionType.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error