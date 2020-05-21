(** "<p>Returns summary information about operations performed on a stack set. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListStackSetOperationsInput :
sig
  type t =
    {
    stack_set_name: String.t ;
    next_token: String.t option ;
    max_results: Integer.t option }
  val make :
    stack_set_name:String.t ->
      ?next_token:String.t -> ?max_results:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ListStackSetOperationsOutput = ListStackSetOperationsOutput
type input = ListStackSetOperationsInput.t
type output = ListStackSetOperationsOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error