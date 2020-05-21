(** "<p>Creates a stack as specified in the template. After the call completes successfully, the stack creation starts. You can check the status of the stack via the <a>DescribeStacks</a> API.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateStackInput :
sig
  type t =
    {
    stack_name: String.t ;
    template_body: String.t option ;
    template_u_r_l: String.t option ;
    parameters: Parameters.t ;
    disable_rollback: Boolean.t option ;
    rollback_configuration: RollbackConfiguration.t option ;
    timeout_in_minutes: Integer.t option ;
    notification_a_r_ns: NotificationARNs.t ;
    capabilities: Capabilities.t ;
    resource_types: ResourceTypes.t ;
    role_a_r_n: String.t option ;
    on_failure: OnFailure.t option ;
    stack_policy_body: String.t option ;
    stack_policy_u_r_l: String.t option ;
    tags: Tags.t ;
    client_request_token: String.t option ;
    enable_termination_protection: Boolean.t option }[@@ocaml.doc
                                                       "<p>The input for <a>CreateStack</a> action.</p>"]
  val make :
    stack_name:String.t ->
      ?template_body:String.t ->
        ?template_u_r_l:String.t ->
          ?parameters:Parameters.t ->
            ?disable_rollback:Boolean.t ->
              ?rollback_configuration:RollbackConfiguration.t ->
                ?timeout_in_minutes:Integer.t ->
                  ?notification_a_r_ns:NotificationARNs.t ->
                    ?capabilities:Capabilities.t ->
                      ?resource_types:ResourceTypes.t ->
                        ?role_a_r_n:String.t ->
                          ?on_failure:OnFailure.t ->
                            ?stack_policy_body:String.t ->
                              ?stack_policy_u_r_l:String.t ->
                                ?tags:Tags.t ->
                                  ?client_request_token:String.t ->
                                    ?enable_termination_protection:Boolean.t
                                      -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateStackOutput = CreateStackOutput
type input = CreateStackInput.t
type output = CreateStackOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error