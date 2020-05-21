(** "<p>Retrieves a list of all active sessions (both connected and disconnected) or terminated sessions from the past 30 days.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeSessionsRequest :
sig
  type t =
    {
    state: SessionState.t ;
    max_results: Integer.t option ;
    next_token: String.t option ;
    filters: SessionFilterList.t }
  val make :
    state:SessionState.t ->
      ?max_results:Integer.t ->
        ?next_token:String.t -> ?filters:SessionFilterList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module DescribeSessionsResponse = DescribeSessionsResponse
type input = DescribeSessionsRequest.t
type output = DescribeSessionsResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error