(** "<p>Updates the stack set, and associated stack instances in the specified accounts and regions.</p> <p>Even if the stack set operation created by updating the stack set fails (completely or partially, below or above a specified failure tolerance), the stack set is updated with your changes. Subsequent <a>CreateStackInstances</a> calls on the specified stack set use the updated stack set.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module UpdateStackSetInput :
sig
  type t =
    {
    stack_set_name: String.t ;
    description: String.t option ;
    template_body: String.t option ;
    template_u_r_l: String.t option ;
    use_previous_template: Boolean.t option ;
    parameters: Parameters.t ;
    capabilities: Capabilities.t ;
    tags: Tags.t ;
    operation_preferences: StackSetOperationPreferences.t option ;
    administration_role_a_r_n: String.t option ;
    execution_role_name: String.t option ;
    operation_id: String.t option ;
    accounts: AccountList.t ;
    regions: RegionList.t }
  val make :
    stack_set_name:String.t ->
      ?description:String.t ->
        ?template_body:String.t ->
          ?template_u_r_l:String.t ->
            ?use_previous_template:Boolean.t ->
              ?parameters:Parameters.t ->
                ?capabilities:Capabilities.t ->
                  ?tags:Tags.t ->
                    ?operation_preferences:StackSetOperationPreferences.t ->
                      ?administration_role_a_r_n:String.t ->
                        ?execution_role_name:String.t ->
                          ?operation_id:String.t ->
                            ?accounts:AccountList.t ->
                              ?regions:RegionList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module UpdateStackSetOutput = UpdateStackSetOutput
type input = UpdateStackSetInput.t
type output = UpdateStackSetOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error