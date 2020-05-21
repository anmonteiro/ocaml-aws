(** "<p>Edit or change an OpsItem. You must have permission in AWS Identity and Access Management (IAM) to update an OpsItem. For more information, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-getting-started.html\">Getting Started with OpsCenter</a> in the <i>AWS Systems Manager User Guide</i>.</p> <p>Operations engineers and IT professionals use OpsCenter to view, investigate, and remediate operational issues impacting the performance and health of their AWS resources. For more information, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter.html\">AWS Systems Manager OpsCenter</a> in the <i>AWS Systems Manager User Guide</i>. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module UpdateOpsItemRequest :
sig
  type t =
    {
    description: String.t option ;
    operational_data: OpsItemOperationalData.t option ;
    operational_data_to_delete: OpsItemOpsDataKeysList.t ;
    notifications: OpsItemNotifications.t ;
    priority: Integer.t option ;
    related_ops_items: RelatedOpsItems.t ;
    status: OpsItemStatus.t option ;
    ops_item_id: String.t ;
    title: String.t option ;
    category: String.t option ;
    severity: String.t option }
  val make :
    ?description:String.t ->
      ?operational_data:OpsItemOperationalData.t ->
        ?operational_data_to_delete:OpsItemOpsDataKeysList.t ->
          ?notifications:OpsItemNotifications.t ->
            ?priority:Integer.t ->
              ?related_ops_items:RelatedOpsItems.t ->
                ?status:OpsItemStatus.t ->
                  ops_item_id:String.t ->
                    ?title:String.t ->
                      ?category:String.t -> ?severity:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module Output = Aws.BaseTypes.Unit
type input = UpdateOpsItemRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error