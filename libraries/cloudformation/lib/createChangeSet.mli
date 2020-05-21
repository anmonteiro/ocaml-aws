(** "<p>Creates a list of changes that will be applied to a stack so that you can review the changes before executing them. You can create a change set for a stack that doesn't exist or an existing stack. If you create a change set for a stack that doesn't exist, the change set shows all of the resources that AWS CloudFormation will create. If you create a change set for an existing stack, AWS CloudFormation compares the stack's information with the information that you submit in the change set and lists the differences. Use change sets to understand which resources AWS CloudFormation will create or change, and how it will change resources in an existing stack, before you create or update a stack.</p> <p>To create a change set for a stack that doesn't exist, for the <code>ChangeSetType</code> parameter, specify <code>CREATE</code>. To create a change set for an existing stack, specify <code>UPDATE</code> for the <code>ChangeSetType</code> parameter. To create a change set for an import operation, specify <code>IMPORT</code> for the <code>ChangeSetType</code> parameter. After the <code>CreateChangeSet</code> call successfully completes, AWS CloudFormation starts creating the change set. To check the status of the change set or to review it, use the <a>DescribeChangeSet</a> action.</p> <p>When you are satisfied with the changes the change set will make, execute the change set by using the <a>ExecuteChangeSet</a> action. AWS CloudFormation doesn't make changes until you execute the change set.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateChangeSetInput :
sig
  type t =
    {
    stack_name: String.t ;
    template_body: String.t option ;
    template_u_r_l: String.t option ;
    use_previous_template: Boolean.t option ;
    parameters: Parameters.t ;
    capabilities: Capabilities.t ;
    resource_types: ResourceTypes.t ;
    role_a_r_n: String.t option ;
    rollback_configuration: RollbackConfiguration.t option ;
    notification_a_r_ns: NotificationARNs.t ;
    tags: Tags.t ;
    change_set_name: String.t ;
    client_token: String.t option ;
    description: String.t option ;
    change_set_type: ChangeSetType.t option ;
    resources_to_import: ResourcesToImport.t }[@@ocaml.doc
                                                "<p>The input for the <a>CreateChangeSet</a> action.</p>"]
  val make :
    stack_name:String.t ->
      ?template_body:String.t ->
        ?template_u_r_l:String.t ->
          ?use_previous_template:Boolean.t ->
            ?parameters:Parameters.t ->
              ?capabilities:Capabilities.t ->
                ?resource_types:ResourceTypes.t ->
                  ?role_a_r_n:String.t ->
                    ?rollback_configuration:RollbackConfiguration.t ->
                      ?notification_a_r_ns:NotificationARNs.t ->
                        ?tags:Tags.t ->
                          change_set_name:String.t ->
                            ?client_token:String.t ->
                              ?description:String.t ->
                                ?change_set_type:ChangeSetType.t ->
                                  ?resources_to_import:ResourcesToImport.t ->
                                    unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateChangeSetOutput = CreateChangeSetOutput
type input = CreateChangeSetInput.t
type output = CreateChangeSetOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error