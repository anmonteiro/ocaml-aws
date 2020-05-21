(** "<p>Lists trails that are in the current account.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListTrailsRequest :
sig
  type t = {
    next_token: String.t option }
  val make : ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module ListTrailsResponse = ListTrailsResponse
type input = ListTrailsRequest.t
type output = ListTrailsResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error