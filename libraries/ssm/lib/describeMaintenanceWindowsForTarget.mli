(** "<p>Retrieves information about the maintenance window targets or tasks that an instance is associated with.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeMaintenanceWindowsForTargetRequest :
sig
  type t =
    {
    targets: Targets.t ;
    resource_type: MaintenanceWindowResourceType.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    targets:Targets.t ->
      resource_type:MaintenanceWindowResourceType.t ->
        ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module DescribeMaintenanceWindowsForTargetResult =
DescribeMaintenanceWindowsForTargetResult
type input = DescribeMaintenanceWindowsForTargetRequest.t
type output = DescribeMaintenanceWindowsForTargetResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error