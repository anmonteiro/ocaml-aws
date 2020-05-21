(** "<p>Lists all patches eligible to be included in a patch baseline.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeAvailablePatchesRequest :
sig
  type t =
    {
    filters: PatchOrchestratorFilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    ?filters:PatchOrchestratorFilterList.t ->
      ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module DescribeAvailablePatchesResult = DescribeAvailablePatchesResult
type input = DescribeAvailablePatchesRequest.t
type output = DescribeAvailablePatchesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error