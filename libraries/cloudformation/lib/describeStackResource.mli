(** "<p>Returns a description of the specified resource in the specified stack.</p> <p>For deleted stacks, DescribeStackResource returns resource information for up to 90 days after the stack has been deleted.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeStackResourceInput :
sig
  type t = {
    stack_name: String.t ;
    logical_resource_id: String.t }[@@ocaml.doc
                                     "<p>The input for <a>DescribeStackResource</a> action.</p>"]
  val make : stack_name:String.t -> logical_resource_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeStackResourceOutput = DescribeStackResourceOutput
type input = DescribeStackResourceInput.t
type output = DescribeStackResourceOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error