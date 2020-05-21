(** "<p>Returns the description for the specified stack; if no stack name was specified, then it returns the description for all the stacks created.</p> <note> <p>If the stack does not exist, an <code>AmazonCloudFormationException</code> is returned.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeStacksInput :
sig
  type t = {
    stack_name: String.t option ;
    next_token: String.t option }[@@ocaml.doc
                                   "<p>The input for <a>DescribeStacks</a> action.</p>"]
  val make : ?stack_name:String.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeStacksOutput = DescribeStacksOutput
type input = DescribeStacksInput.t
type output = DescribeStacksOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error