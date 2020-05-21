(** "<p>Stops an in-progress operation on a stack set and its associated stack instances. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module StopStackSetOperationInput :
sig
  type t = {
    stack_set_name: String.t ;
    operation_id: String.t }
  val make : stack_set_name:String.t -> operation_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = StopStackSetOperationInput.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error