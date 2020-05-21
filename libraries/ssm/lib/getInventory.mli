(** "<p>Query inventory information.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetInventoryRequest :
sig
  type t =
    {
    filters: InventoryFilterList.t ;
    aggregators: InventoryAggregatorList.t ;
    result_attributes: ResultAttributeList.t ;
    next_token: String.t option ;
    max_results: Integer.t option }
  val make :
    ?filters:InventoryFilterList.t ->
      ?aggregators:InventoryAggregatorList.t ->
        ?result_attributes:ResultAttributeList.t ->
          ?next_token:String.t -> ?max_results:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module GetInventoryResult = GetInventoryResult
type input = GetInventoryRequest.t
type output = GetInventoryResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error