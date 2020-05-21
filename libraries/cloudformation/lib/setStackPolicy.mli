(** "<p>Sets a stack policy for a specified stack.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module SetStackPolicyInput :
sig
  type t =
    {
    stack_name: String.t ;
    stack_policy_body: String.t option ;
    stack_policy_u_r_l: String.t option }[@@ocaml.doc
                                           "<p>The input for the <a>SetStackPolicy</a> action.</p>"]
  val make :
    stack_name:String.t ->
      ?stack_policy_body:String.t ->
        ?stack_policy_u_r_l:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = SetStackPolicyInput.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error