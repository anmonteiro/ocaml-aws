(** "<p>Updates a stack as specified in the template. After the call completes successfully, the stack update starts. You can check the status of the stack via the <a>DescribeStacks</a> action.</p> <p>To get a copy of the template for an existing stack, you can use the <a>GetTemplate</a> action.</p> <p>For more information about creating an update template, updating a stack, and monitoring the progress of the update, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-updating-stacks.html\">Updating a Stack</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module UpdateStackInput :
sig
  type t =
    {
    stack_name: String.t ;
    template_body: String.t option ;
    template_u_r_l: String.t option ;
    use_previous_template: Boolean.t option ;
    stack_policy_during_update_body: String.t option ;
    stack_policy_during_update_u_r_l: String.t option ;
    parameters: Parameters.t ;
    capabilities: Capabilities.t ;
    resource_types: ResourceTypes.t ;
    role_a_r_n: String.t option ;
    rollback_configuration: RollbackConfiguration.t option ;
    stack_policy_body: String.t option ;
    stack_policy_u_r_l: String.t option ;
    notification_a_r_ns: NotificationARNs.t ;
    tags: Tags.t ;
    client_request_token: String.t option }[@@ocaml.doc
                                             "<p>The input for an <a>UpdateStack</a> action.</p>"]
  val make :
    stack_name:String.t ->
      ?template_body:String.t ->
        ?template_u_r_l:String.t ->
          ?use_previous_template:Boolean.t ->
            ?stack_policy_during_update_body:String.t ->
              ?stack_policy_during_update_u_r_l:String.t ->
                ?parameters:Parameters.t ->
                  ?capabilities:Capabilities.t ->
                    ?resource_types:ResourceTypes.t ->
                      ?role_a_r_n:String.t ->
                        ?rollback_configuration:RollbackConfiguration.t ->
                          ?stack_policy_body:String.t ->
                            ?stack_policy_u_r_l:String.t ->
                              ?notification_a_r_ns:NotificationARNs.t ->
                                ?tags:Tags.t ->
                                  ?client_request_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module UpdateStackOutput = UpdateStackOutput
type input = UpdateStackInput.t
type output = UpdateStackOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error