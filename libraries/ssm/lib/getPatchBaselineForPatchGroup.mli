(** "<p>Retrieves the patch baseline that should be used for the specified patch group.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetPatchBaselineForPatchGroupRequest :
sig
  type t =
    {
    patch_group: String.t ;
    operating_system: OperatingSystem.t option }
  val make :
    patch_group:String.t -> ?operating_system:OperatingSystem.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module GetPatchBaselineForPatchGroupResult =
GetPatchBaselineForPatchGroupResult
type input = GetPatchBaselineForPatchGroupRequest.t
type output = GetPatchBaselineForPatchGroupResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error