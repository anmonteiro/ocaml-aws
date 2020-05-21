(** "<p>Query a list of all parameters used by the AWS account.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetParameterHistoryRequest :
sig
  type t =
    {
    name: String.t ;
    with_decryption: Boolean.t option ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    name:String.t ->
      ?with_decryption:Boolean.t ->
        ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module GetParameterHistoryResult = GetParameterHistoryResult
type input = GetParameterHistoryRequest.t
type output = GetParameterHistoryResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error