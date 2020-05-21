(** "<p>View a summary of OpsItems based on specified filters and aggregators.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetOpsSummaryRequest :
sig
  type t =
    {
    sync_name: String.t option ;
    filters: OpsFilterList.t ;
    aggregators: OpsAggregatorList.t ;
    result_attributes: OpsResultAttributeList.t ;
    next_token: String.t option ;
    max_results: Integer.t option }
  val make :
    ?sync_name:String.t ->
      ?filters:OpsFilterList.t ->
        ?aggregators:OpsAggregatorList.t ->
          ?result_attributes:OpsResultAttributeList.t ->
            ?next_token:String.t -> ?max_results:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module GetOpsSummaryResult = GetOpsSummaryResult
type input = GetOpsSummaryRequest.t
type output = GetOpsSummaryResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error