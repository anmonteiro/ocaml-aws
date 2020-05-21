(** "<p>Adds or removes permission settings for the specified snapshot. You may add or remove specified AWS account IDs from a snapshot's list of create volume permissions, but you cannot do both in a single operation. If you need to both add and remove account IDs for a snapshot, you must use multiple operations. You can make up to 500 modifications to a snapshot in a single operation.</p> <p>Encrypted snapshots and snapshots with AWS Marketplace product codes cannot be made public. Snapshots encrypted with your default CMK cannot be shared with other accounts.</p> <p>For more information about modifying snapshot permissions, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-modifying-snapshot-permissions.html\">Sharing Snapshots</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifySnapshotAttributeRequest :
sig
  type t =
    {
    attribute: SnapshotAttributeName.t option ;
    create_volume_permission: CreateVolumePermissionModifications.t option ;
    group_names: GroupNameStringList.t ;
    operation_type: OperationType.t option ;
    snapshot_id: String.t ;
    user_ids: UserIdStringList.t ;
    dry_run: Boolean.t option }
  val make :
    ?attribute:SnapshotAttributeName.t ->
      ?create_volume_permission:CreateVolumePermissionModifications.t ->
        ?group_names:GroupNameStringList.t ->
          ?operation_type:OperationType.t ->
            snapshot_id:String.t ->
              ?user_ids:UserIdStringList.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = ModifySnapshotAttributeRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error