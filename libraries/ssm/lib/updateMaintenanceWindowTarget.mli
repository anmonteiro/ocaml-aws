(** "<p>Modifies the target of an existing maintenance window. You can change the following:</p> <ul> <li> <p>Name</p> </li> <li> <p>Description</p> </li> <li> <p>Owner</p> </li> <li> <p>IDs for an ID target</p> </li> <li> <p>Tags for a Tag target</p> </li> <li> <p>From any supported tag type to another. The three supported tag types are ID target, Tag target, and resource group. For more information, see <a>Target</a>.</p> </li> </ul> <note> <p>If a parameter is null, then the corresponding field is not modified.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module UpdateMaintenanceWindowTargetRequest :
sig
  type t =
    {
    window_id: String.t ;
    window_target_id: String.t ;
    targets: Targets.t ;
    owner_information: String.t option ;
    name: String.t option ;
    description: String.t option ;
    replace: Boolean.t option }
  val make :
    window_id:String.t ->
      window_target_id:String.t ->
        ?targets:Targets.t ->
          ?owner_information:String.t ->
            ?name:String.t ->
              ?description:String.t -> ?replace:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module UpdateMaintenanceWindowTargetResult =
UpdateMaintenanceWindowTargetResult
type input = UpdateMaintenanceWindowTargetRequest.t
type output = UpdateMaintenanceWindowTargetResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error