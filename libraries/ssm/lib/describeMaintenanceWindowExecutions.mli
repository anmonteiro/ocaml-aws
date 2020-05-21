(** "<p>Lists the executions of a maintenance window. This includes information about when the maintenance window was scheduled to be active, and information about tasks registered and run with the maintenance window.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeMaintenanceWindowExecutionsRequest :
sig
  type t =
    {
    window_id: String.t ;
    filters: MaintenanceWindowFilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    window_id:String.t ->
      ?filters:MaintenanceWindowFilterList.t ->
        ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module DescribeMaintenanceWindowExecutionsResult =
DescribeMaintenanceWindowExecutionsResult
type input = DescribeMaintenanceWindowExecutionsRequest.t
type output = DescribeMaintenanceWindowExecutionsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error