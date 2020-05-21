(** "<p>Creates or updates one or more scheduled scaling actions for an Auto Scaling group. If you leave a parameter unspecified when updating a scheduled scaling action, the corresponding value remains unchanged.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module BatchPutScheduledUpdateGroupActionType :
sig
  type t =
    {
    auto_scaling_group_name: String.t ;
    scheduled_update_group_actions: ScheduledUpdateGroupActionRequests.t }
  val make :
    auto_scaling_group_name:String.t ->
      scheduled_update_group_actions:ScheduledUpdateGroupActionRequests.t ->
        unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module BatchPutScheduledUpdateGroupActionAnswer =
BatchPutScheduledUpdateGroupActionAnswer
type input = BatchPutScheduledUpdateGroupActionType.t
type output = BatchPutScheduledUpdateGroupActionAnswer.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error