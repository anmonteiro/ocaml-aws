(** "<p>Associates the specified Systems Manager document with the specified instances or targets.</p> <p>When you associate a document with one or more instances using instance IDs or tags, SSM Agent running on the instance processes the document and configures the instance as specified.</p> <p>If you associate a document with an instance that already has an associated document, the system returns the AssociationAlreadyExists exception.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateAssociationRequest :
sig
  type t =
    {
    name: String.t ;
    document_version: String.t option ;
    instance_id: String.t option ;
    parameters: Parameters.t option ;
    targets: Targets.t ;
    schedule_expression: String.t option ;
    output_location: InstanceAssociationOutputLocation.t option ;
    association_name: String.t option ;
    automation_target_parameter_name: String.t option ;
    max_errors: String.t option ;
    max_concurrency: String.t option ;
    compliance_severity: AssociationComplianceSeverity.t option }
  val make :
    name:String.t ->
      ?document_version:String.t ->
        ?instance_id:String.t ->
          ?parameters:Parameters.t ->
            ?targets:Targets.t ->
              ?schedule_expression:String.t ->
                ?output_location:InstanceAssociationOutputLocation.t ->
                  ?association_name:String.t ->
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
module CreateAssociationResult = CreateAssociationResult
type input = CreateAssociationRequest.t
type output = CreateAssociationResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error