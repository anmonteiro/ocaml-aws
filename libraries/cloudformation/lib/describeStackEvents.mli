(** "<p>Returns all stack related events for a specified stack in reverse chronological order. For more information about a stack's event history, go to <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/concept-stack.html\">Stacks</a> in the AWS CloudFormation User Guide.</p> <note> <p>You can list events for stacks that have failed to create or have been deleted by specifying the unique stack identifier (stack ID).</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeStackEventsInput :
sig
  type t = {
    stack_name: String.t option ;
    next_token: String.t option }[@@ocaml.doc
                                   "<p>The input for <a>DescribeStackEvents</a> action.</p>"]
  val make : ?stack_name:String.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeStackEventsOutput = DescribeStackEventsOutput
type input = DescribeStackEventsInput.t
type output = DescribeStackEventsOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error