(** "<p>Retrieves information about the patches on the specified instance and their state relative to the patch baseline being used for the instance.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeInstancePatchesRequest :
sig
  type t =
    {
    instance_id: String.t ;
    filters: PatchOrchestratorFilterList.t ;
    next_token: String.t option ;
    max_results: Integer.t option }
  val make :
    instance_id:String.t ->
      ?filters:PatchOrchestratorFilterList.t ->
        ?next_token:String.t -> ?max_results:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module DescribeInstancePatchesResult = DescribeInstancePatchesResult
type input = DescribeInstancePatchesRequest.t
type output = DescribeInstancePatchesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error