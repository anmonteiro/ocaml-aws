(** "<p>Copies the specified DB snapshot. The source DB snapshot must be in the \"available\" state.</p> <p>You can copy a snapshot from one AWS Region to another. In that case, the AWS Region where you call the <code>CopyDBSnapshot</code> action is the destination AWS Region for the DB snapshot copy. </p> <p>For more information about copying snapshots, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_CopySnapshot.html#USER_CopyDBSnapshot\">Copying a DB Snapshot</a> in the <i>Amazon RDS User Guide.</i> </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CopyDBSnapshotMessage :
sig
  type t =
    {
    source_d_b_snapshot_identifier: String.t ;
    target_d_b_snapshot_identifier: String.t ;
    kms_key_id: String.t option ;
    tags: TagList.t ;
    copy_tags: Boolean.t option ;
    pre_signed_url: String.t option ;
    option_group_name: String.t option }[@@ocaml.doc "<p/>"]
  val make :
    source_d_b_snapshot_identifier:String.t ->
      target_d_b_snapshot_identifier:String.t ->
        ?kms_key_id:String.t ->
          ?tags:TagList.t ->
            ?copy_tags:Boolean.t ->
              ?pre_signed_url:String.t ->
                ?option_group_name:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CopyDBSnapshotResult = CopyDBSnapshotResult
type input = CopyDBSnapshotMessage.t
type output = CopyDBSnapshotResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error