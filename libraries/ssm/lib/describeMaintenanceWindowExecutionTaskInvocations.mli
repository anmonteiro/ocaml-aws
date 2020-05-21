(** "<p>Retrieves the individual task executions (one per target) for a particular task run as part of a maintenance window execution.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeMaintenanceWindowExecutionTaskInvocationsRequest :
sig
  type t =
    {
    window_execution_id: String.t ;
    task_id: String.t ;
    filters: MaintenanceWindowFilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    window_execution_id:String.t ->
      task_id:String.t ->
        ?filters:MaintenanceWindowFilterList.t ->
          ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module DescribeMaintenanceWindowExecutionTaskInvocationsResult =
DescribeMaintenanceWindowExecutionTaskInvocationsResult
type input = DescribeMaintenanceWindowExecutionTaskInvocationsRequest.t
type output = DescribeMaintenanceWindowExecutionTaskInvocationsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error