(** "<p>Updates the parameter values for stack instances for the specified accounts, within the specified regions. A stack instance refers to a stack in a specific account and region. </p> <p>You can only update stack instances in regions and accounts where they already exist; to create additional stack instances, use <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_CreateStackInstances.html\">CreateStackInstances</a>. </p> <p>During stack set updates, any parameters overridden for a stack instance are not updated, but retain their overridden value.</p> <p>You can only update the parameter <i>values</i> that are specified in the stack set; to add or delete a parameter itself, use <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_UpdateStackSet.html\">UpdateStackSet</a> to update the stack set template. If you add a parameter to a template, before you can override the parameter value specified in the stack set you must first use <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_UpdateStackSet.html\">UpdateStackSet</a> to update all stack instances with the updated template and parameter value specified in the stack set. Once a stack instance has been updated with the new parameter, you can then override the parameter value using <code>UpdateStackInstances</code>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module UpdateStackInstancesInput :
sig
  type t =
    {
    stack_set_name: String.t ;
    accounts: AccountList.t ;
    regions: RegionList.t ;
    parameter_overrides: Parameters.t ;
    operation_preferences: StackSetOperationPreferences.t option ;
    operation_id: String.t option }
  val make :
    stack_set_name:String.t ->
      accounts:AccountList.t ->
        regions:RegionList.t ->
          ?parameter_overrides:Parameters.t ->
            ?operation_preferences:StackSetOperationPreferences.t ->
              ?operation_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module UpdateStackInstancesOutput = UpdateStackInstancesOutput
type input = UpdateStackInstancesInput.t
type output = UpdateStackInstancesOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error