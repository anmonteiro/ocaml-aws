(** "<p>Returns the summary information for stacks whose status matches the specified StackStatusFilter. Summary information for stacks that have been deleted is kept for 90 days after the stack is deleted. If no StackStatusFilter is specified, summary information for all stacks is returned (including existing stacks and stacks that have been deleted).</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListStacksInput :
sig
  type t =
    {
    next_token: String.t option ;
    stack_status_filter: StackStatusFilter.t }[@@ocaml.doc
                                                "<p>The input for <a>ListStacks</a> action.</p>"]
  val make :
    ?next_token:String.t ->
      ?stack_status_filter:StackStatusFilter.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ListStacksOutput = ListStacksOutput
type input = ListStacksInput.t
type output = ListStacksOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error