(** "<p>Returns the description of the specified stack set. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeStackSetInput :
sig
  type t = {
    stack_set_name: String.t }
  val make : stack_set_name:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeStackSetOutput = DescribeStackSetOutput
type input = DescribeStackSetInput.t
type output = DescribeStackSetOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error