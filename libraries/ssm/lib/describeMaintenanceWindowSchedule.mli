(** "<p>Retrieves information about upcoming executions of a maintenance window.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeMaintenanceWindowScheduleRequest :
sig
  type t =
    {
    window_id: String.t option ;
    targets: Targets.t ;
    resource_type: MaintenanceWindowResourceType.t option ;
    filters: PatchOrchestratorFilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    ?window_id:String.t ->
      ?targets:Targets.t ->
        ?resource_type:MaintenanceWindowResourceType.t ->
          ?filters:PatchOrchestratorFilterList.t ->
            ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module DescribeMaintenanceWindowScheduleResult =
DescribeMaintenanceWindowScheduleResult
type input = DescribeMaintenanceWindowScheduleRequest.t
type output = DescribeMaintenanceWindowScheduleResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error