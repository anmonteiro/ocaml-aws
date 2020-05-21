(** "<p>Information about all active and terminated step executions in an Automation workflow.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeAutomationStepExecutionsRequest :
sig
  type t =
    {
    automation_execution_id: String.t ;
    filters: StepExecutionFilterList.t ;
    next_token: String.t option ;
    max_results: Integer.t option ;
    reverse_order: Boolean.t option }
  val make :
    automation_execution_id:String.t ->
      ?filters:StepExecutionFilterList.t ->
        ?next_token:String.t ->
          ?max_results:Integer.t -> ?reverse_order:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module DescribeAutomationStepExecutionsResult =
DescribeAutomationStepExecutionsResult
type input = DescribeAutomationStepExecutionsRequest.t
type output = DescribeAutomationStepExecutionsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error