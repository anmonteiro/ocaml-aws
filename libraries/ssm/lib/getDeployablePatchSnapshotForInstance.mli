(** "<p>Retrieves the current snapshot for the patch baseline the instance uses. This API is primarily used by the AWS-RunPatchBaseline Systems Manager document. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetDeployablePatchSnapshotForInstanceRequest :
sig
  type t = {
    instance_id: String.t ;
    snapshot_id: String.t }
  val make : instance_id:String.t -> snapshot_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module GetDeployablePatchSnapshotForInstanceResult =
GetDeployablePatchSnapshotForInstanceResult
type input = GetDeployablePatchSnapshotForInstanceRequest.t
type output = GetDeployablePatchSnapshotForInstanceResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error