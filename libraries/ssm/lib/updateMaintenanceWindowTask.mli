(** "<p>Modifies a task assigned to a maintenance window. You can't change the task type, but you can change the following values:</p> <ul> <li> <p>TaskARN. For example, you can change a RUN_COMMAND task from AWS-RunPowerShellScript to AWS-RunShellScript.</p> </li> <li> <p>ServiceRoleArn</p> </li> <li> <p>TaskInvocationParameters</p> </li> <li> <p>Priority</p> </li> <li> <p>MaxConcurrency</p> </li> <li> <p>MaxErrors</p> </li> </ul> <p>If a parameter is null, then the corresponding field is not modified. Also, if you set Replace to true, then all fields required by the <a>RegisterTaskWithMaintenanceWindow</a> action are required for this request. Optional fields that aren't specified are set to null.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module UpdateMaintenanceWindowTaskRequest :
sig
  type t =
    {
    window_id: String.t ;
    window_task_id: String.t ;
    targets: Targets.t ;
    task_arn: String.t option ;
    service_role_arn: String.t option ;
    task_parameters: MaintenanceWindowTaskParameters.t option ;
    task_invocation_parameters:
      MaintenanceWindowTaskInvocationParameters.t option ;
    priority: Integer.t option ;
    max_concurrency: String.t option ;
    max_errors: String.t option ;
    logging_info: LoggingInfo.t option ;
    name: String.t option ;
    description: String.t option ;
    replace: Boolean.t option }
  val make :
    window_id:String.t ->
      window_task_id:String.t ->
        ?targets:Targets.t ->
          ?task_arn:String.t ->
            ?service_role_arn:String.t ->
              ?task_parameters:MaintenanceWindowTaskParameters.t ->
                ?task_invocation_parameters:MaintenanceWindowTaskInvocationParameters.t
                  ->
                  ?priority:Integer.t ->
                    ?max_concurrency:String.t ->
                      ?max_errors:String.t ->
                        ?logging_info:LoggingInfo.t ->
                          ?name:String.t ->
                            ?description:String.t ->
                              ?replace:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module UpdateMaintenanceWindowTaskResult = UpdateMaintenanceWindowTaskResult
type input = UpdateMaintenanceWindowTaskRequest.t
type output = UpdateMaintenanceWindowTaskResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error