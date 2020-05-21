(** "<p>Updates an association. You can update the association name and version, the document version, schedule, parameters, and Amazon S3 output. </p> <p>In order to call this API action, your IAM user account, group, or role must be configured with permission to call the <a>DescribeAssociation</a> API action. If you don't have permission to call DescribeAssociation, then you receive the following error: <code>An error occurred (AccessDeniedException) when calling the UpdateAssociation operation: User: &lt;user_arn&gt; is not authorized to perform: ssm:DescribeAssociation on resource: &lt;resource_arn&gt;</code> </p> <important> <p>When you update an association, the association immediately runs against the specified targets.</p> </important>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module UpdateAssociationRequest :
sig
  type t =
    {
    association_id: String.t ;
    parameters: Parameters.t option ;
    document_version: String.t option ;
    schedule_expression: String.t option ;
    output_location: InstanceAssociationOutputLocation.t option ;
    name: String.t option ;
    targets: Targets.t ;
    association_name: String.t option ;
    association_version: String.t option ;
    automation_target_parameter_name: String.t option ;
    max_errors: String.t option ;
    max_concurrency: String.t option ;
    compliance_severity: AssociationComplianceSeverity.t option }
  val make :
    association_id:String.t ->
      ?parameters:Parameters.t ->
        ?document_version:String.t ->
          ?schedule_expression:String.t ->
            ?output_location:InstanceAssociationOutputLocation.t ->
              ?name:String.t ->
                ?targets:Targets.t ->
                  ?association_name:String.t ->
                    ?association_version:String.t ->
                      ?automation_target_parameter_name:String.t ->
                        ?max_errors:String.t ->
                          ?max_concurrency:String.t ->
                            ?compliance_severity:AssociationComplianceSeverity.t
                              -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module UpdateAssociationResult = UpdateAssociationResult
type input = UpdateAssociationRequest.t
type output = UpdateAssociationResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error