(** "<p>Creates a new OpsItem. You must have permission in AWS Identity and Access Management (IAM) to create a new OpsItem. For more information, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-getting-started.html\">Getting Started with OpsCenter</a> in the <i>AWS Systems Manager User Guide</i>.</p> <p>Operations engineers and IT professionals use OpsCenter to view, investigate, and remediate operational issues impacting the performance and health of their AWS resources. For more information, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter.html\">AWS Systems Manager OpsCenter</a> in the <i>AWS Systems Manager User Guide</i>. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateOpsItemRequest :
sig
  type t =
    {
    description: String.t ;
    operational_data: OpsItemOperationalData.t option ;
    notifications: OpsItemNotifications.t ;
    priority: Integer.t option ;
    related_ops_items: RelatedOpsItems.t ;
    source: String.t ;
    title: String.t ;
    tags: TagList.t ;
    category: String.t option ;
    severity: String.t option }
  val make :
    description:String.t ->
      ?operational_data:OpsItemOperationalData.t ->
        ?notifications:OpsItemNotifications.t ->
          ?priority:Integer.t ->
            ?related_ops_items:RelatedOpsItems.t ->
              source:String.t ->
                title:String.t ->
                  ?tags:TagList.t ->
                    ?category:String.t -> ?severity:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module CreateOpsItemResponse = CreateOpsItemResponse
type input = CreateOpsItemRequest.t
type output = CreateOpsItemResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error