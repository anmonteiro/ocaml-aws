(** "<p>Retrieves the high-level patch state for the instances in the specified patch group.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeInstancePatchStatesForPatchGroupRequest :
sig
  type t =
    {
    patch_group: String.t ;
    filters: InstancePatchStateFilterList.t ;
    next_token: String.t option ;
    max_results: Integer.t option }
  val make :
    patch_group:String.t ->
      ?filters:InstancePatchStateFilterList.t ->
        ?next_token:String.t -> ?max_results:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module DescribeInstancePatchStatesForPatchGroupResult =
DescribeInstancePatchStatesForPatchGroupResult
type input = DescribeInstancePatchStatesForPatchGroupRequest.t
type output = DescribeInstancePatchStatesForPatchGroupResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error