(** "<p>Adds a new task to a maintenance window.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RegisterTaskWithMaintenanceWindowRequest :
sig
  type t =
    {
    window_id: String.t ;
    targets: Targets.t ;
    task_arn: String.t ;
    service_role_arn: String.t option ;
    task_type: MaintenanceWindowTaskType.t ;
    task_parameters: MaintenanceWindowTaskParameters.t option ;
    task_invocation_parameters:
      MaintenanceWindowTaskInvocationParameters.t option ;
    priority: Integer.t option ;
    max_concurrency: String.t ;
    max_errors: String.t ;
    logging_info: LoggingInfo.t option ;
    name: String.t option ;
    description: String.t option ;
    client_token: String.t option }
  val make :
    window_id:String.t ->
      targets:Targets.t ->
        task_arn:String.t ->
          ?service_role_arn:String.t ->
            task_type:MaintenanceWindowTaskType.t ->
              ?task_parameters:MaintenanceWindowTaskParameters.t ->
                ?task_invocation_parameters:MaintenanceWindowTaskInvocationParameters.t
                  ->
                  ?priority:Integer.t ->
                    max_concurrency:String.t ->
                      max_errors:String.t ->
                        ?logging_info:LoggingInfo.t ->
                          ?name:String.t ->
                            ?description:String.t ->
                              ?client_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module RegisterTaskWithMaintenanceWindowResult =
RegisterTaskWithMaintenanceWindowResult
type input = RegisterTaskWithMaintenanceWindowRequest.t
type output = RegisterTaskWithMaintenanceWindowResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error