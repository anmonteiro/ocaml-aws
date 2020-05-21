(** "<p>Deletes stack instances for the specified accounts, in the specified regions. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteStackInstancesInput :
sig
  type t =
    {
    stack_set_name: String.t ;
    accounts: AccountList.t ;
    regions: RegionList.t ;
    operation_preferences: StackSetOperationPreferences.t option ;
    retain_stacks: Boolean.t ;
    operation_id: String.t option }
  val make :
    stack_set_name:String.t ->
      accounts:AccountList.t ->
        regions:RegionList.t ->
          ?operation_preferences:StackSetOperationPreferences.t ->
            retain_stacks:Boolean.t -> ?operation_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DeleteStackInstancesOutput = DeleteStackInstancesOutput
type input = DeleteStackInstancesInput.t
type output = DeleteStackInstancesOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error