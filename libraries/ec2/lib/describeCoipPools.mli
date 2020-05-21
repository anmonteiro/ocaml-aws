(** "<p>Describes the specified customer-owned address pools or all of your customer-owned address pools.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeCoipPoolsRequest :
sig
  type t =
    {
    pool_ids: CoipPoolIdSet.t ;
    filters: FilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option ;
    dry_run: Boolean.t option }
  val make :
    ?pool_ids:CoipPoolIdSet.t ->
      ?filters:FilterList.t ->
        ?max_results:Integer.t ->
          ?next_token:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeCoipPoolsResult = DescribeCoipPoolsResult
type input = DescribeCoipPoolsRequest.t
type output = DescribeCoipPoolsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error