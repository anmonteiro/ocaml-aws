(** "<p>Deletes one or more scheduled actions for the specified Auto Scaling group.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module BatchDeleteScheduledActionType :
sig
  type t =
    {
    auto_scaling_group_name: String.t ;
    scheduled_action_names: ScheduledActionNames.t }
  val make :
    auto_scaling_group_name:String.t ->
      scheduled_action_names:ScheduledActionNames.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module BatchDeleteScheduledActionAnswer = BatchDeleteScheduledActionAnswer
type input = BatchDeleteScheduledActionType.t
type output = BatchDeleteScheduledActionAnswer.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error