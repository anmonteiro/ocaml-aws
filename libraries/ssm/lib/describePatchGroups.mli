(** "<p>Lists all patch groups that have been registered with patch baselines.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribePatchGroupsRequest :
sig
  type t =
    {
    max_results: Integer.t option ;
    filters: PatchOrchestratorFilterList.t ;
    next_token: String.t option }
  val make :
    ?max_results:Integer.t ->
      ?filters:PatchOrchestratorFilterList.t ->
        ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module DescribePatchGroupsResult = DescribePatchGroupsResult
type input = DescribePatchGroupsRequest.t
type output = DescribePatchGroupsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error