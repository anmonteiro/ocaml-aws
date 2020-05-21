(** "<p>Registers a target with a maintenance window.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RegisterTargetWithMaintenanceWindowRequest :
sig
  type t =
    {
    window_id: String.t ;
    resource_type: MaintenanceWindowResourceType.t ;
    targets: Targets.t ;
    owner_information: String.t option ;
    name: String.t option ;
    description: String.t option ;
    client_token: String.t option }
  val make :
    window_id:String.t ->
      resource_type:MaintenanceWindowResourceType.t ->
        targets:Targets.t ->
          ?owner_information:String.t ->
            ?name:String.t ->
              ?description:String.t -> ?client_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module RegisterTargetWithMaintenanceWindowResult =
RegisterTargetWithMaintenanceWindowResult
type input = RegisterTargetWithMaintenanceWindowRequest.t
type output = RegisterTargetWithMaintenanceWindowResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error