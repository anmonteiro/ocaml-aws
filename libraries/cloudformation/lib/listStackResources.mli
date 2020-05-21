(** "<p>Returns descriptions of all resources of the specified stack.</p> <p>For deleted stacks, ListStackResources returns resource information for up to 90 days after the stack has been deleted.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListStackResourcesInput :
sig
  type t = {
    stack_name: String.t ;
    next_token: String.t option }[@@ocaml.doc
                                   "<p>The input for the <a>ListStackResource</a> action.</p>"]
  val make : stack_name:String.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ListStackResourcesOutput = ListStackResourcesOutput
type input = ListStackResourcesInput.t
type output = ListStackResourcesOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error