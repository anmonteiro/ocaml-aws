(** "<p>Retrieves the default patch baseline. Note that Systems Manager supports creating multiple default patch baselines. For example, you can create a default patch baseline for each operating system.</p> <p>If you do not specify an operating system value, the default patch baseline for Windows is returned.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetDefaultPatchBaselineRequest :
sig
  type t = {
    operating_system: OperatingSystem.t option }
  val make : ?operating_system:OperatingSystem.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module GetDefaultPatchBaselineResult = GetDefaultPatchBaselineResult
type input = GetDefaultPatchBaselineRequest.t
type output = GetDefaultPatchBaselineResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error