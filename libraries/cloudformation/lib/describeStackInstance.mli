(** "<p>Returns the stack instance that's associated with the specified stack set, AWS account, and region.</p> <p>For a list of stack instances that are associated with a specific stack set, use <a>ListStackInstances</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeStackInstanceInput :
sig
  type t =
    {
    stack_set_name: String.t ;
    stack_instance_account: String.t ;
    stack_instance_region: String.t }
  val make :
    stack_set_name:String.t ->
      stack_instance_account:String.t ->
        stack_instance_region:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeStackInstanceOutput = DescribeStackInstanceOutput
type input = DescribeStackInstanceInput.t
type output = DescribeStackInstanceOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error