(** "<p>Retrieves a maintenance window.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetMaintenanceWindowRequest :
sig
  type t = {
    window_id: String.t }
  val make : window_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module GetMaintenanceWindowResult = GetMaintenanceWindowResult
type input = GetMaintenanceWindowRequest.t
type output = GetMaintenanceWindowResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error