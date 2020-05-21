(** "<p>Returns the stack policy for a specified stack. If a stack doesn't have a policy, a null value is returned.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetStackPolicyInput :
sig
  type t = {
    stack_name: String.t }[@@ocaml.doc
                            "<p>The input for the <a>GetStackPolicy</a> action.</p>"]
  val make : stack_name:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module GetStackPolicyOutput = GetStackPolicyOutput
type input = GetStackPolicyInput.t
type output = GetStackPolicyOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error