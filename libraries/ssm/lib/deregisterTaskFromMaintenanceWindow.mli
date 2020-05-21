(** "<p>Removes a task from a maintenance window.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeregisterTaskFromMaintenanceWindowRequest :
sig
  type t = {
    window_id: String.t ;
    window_task_id: String.t }
  val make : window_id:String.t -> window_task_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module DeregisterTaskFromMaintenanceWindowResult =
DeregisterTaskFromMaintenanceWindowResult
type input = DeregisterTaskFromMaintenanceWindowRequest.t
type output = DeregisterTaskFromMaintenanceWindowResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error