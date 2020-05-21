(** "<p>Creates stack instances for the specified accounts, within the specified regions. A stack instance refers to a stack in a specific account and region. <code>Accounts</code> and <code>Regions</code> are required parameters\226\128\148you must specify at least one account and one region. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateStackInstancesInput :
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
module CreateStackInstancesOutput = CreateStackInstancesOutput
type input = CreateStackInstancesInput.t
type output = CreateStackInstancesOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error