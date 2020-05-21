(** "<p>Returns the inputs for the change set and a list of changes that AWS CloudFormation will make if you execute the change set. For more information, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-updating-stacks-changesets.html\">Updating Stacks Using Change Sets</a> in the AWS CloudFormation User Guide.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeChangeSetInput :
sig
  type t =
    {
    change_set_name: String.t ;
    stack_name: String.t option ;
    next_token: String.t option }[@@ocaml.doc
                                   "<p>The input for the <a>DescribeChangeSet</a> action.</p>"]
  val make :
    change_set_name:String.t ->
      ?stack_name:String.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeChangeSetOutput = DescribeChangeSetOutput
type input = DescribeChangeSetInput.t
type output = DescribeChangeSetOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error