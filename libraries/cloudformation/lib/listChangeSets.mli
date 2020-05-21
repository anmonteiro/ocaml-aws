(** "<p>Returns the ID and status of each active change set for a stack. For example, AWS CloudFormation lists change sets that are in the <code>CREATE_IN_PROGRESS</code> or <code>CREATE_PENDING</code> state.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListChangeSetsInput :
sig
  type t = {
    stack_name: String.t ;
    next_token: String.t option }[@@ocaml.doc
                                   "<p>The input for the <a>ListChangeSets</a> action.</p>"]
  val make : stack_name:String.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ListChangeSetsOutput = ListChangeSetsOutput
type input = ListChangeSetsInput.t
type output = ListChangeSetsOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error