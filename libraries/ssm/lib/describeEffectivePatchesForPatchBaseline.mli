(** "<p>Retrieves the current effective patches (the patch and the approval state) for the specified patch baseline. Note that this API applies only to Windows patch baselines.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeEffectivePatchesForPatchBaselineRequest :
sig
  type t =
    {
    baseline_id: String.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    baseline_id:String.t ->
      ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module DescribeEffectivePatchesForPatchBaselineResult =
DescribeEffectivePatchesForPatchBaselineResult
type input = DescribeEffectivePatchesForPatchBaselineRequest.t
type output = DescribeEffectivePatchesForPatchBaselineResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error