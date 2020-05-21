(** "<p>Retrieves your account's AWS CloudFormation limits, such as the maximum number of stacks that you can create in your account. For more information about account limits, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cloudformation-limits.html\">AWS CloudFormation Limits</a> in the <i>AWS CloudFormation User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeAccountLimitsInput :
sig
  type t = {
    next_token: String.t option }[@@ocaml.doc
                                   "<p>The input for the <a>DescribeAccountLimits</a> action.</p>"]
  val make : ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeAccountLimitsOutput = DescribeAccountLimitsOutput
type input = DescribeAccountLimitsInput.t
type output = DescribeAccountLimitsOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error