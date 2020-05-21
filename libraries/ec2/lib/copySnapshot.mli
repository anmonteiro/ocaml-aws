(** "<p>Copies a point-in-time snapshot of an EBS volume and stores it in Amazon S3. You can copy the snapshot within the same Region or from one Region to another. You can use the snapshot to create EBS volumes or Amazon Machine Images (AMIs).</p> <p>Copies of encrypted EBS snapshots remain encrypted. Copies of unencrypted snapshots remain unencrypted, unless you enable encryption for the snapshot copy operation. By default, encrypted snapshot copies use the default AWS Key Management Service (AWS KMS) customer master key (CMK); however, you can specify a different CMK.</p> <p>To copy an encrypted snapshot that has been shared from another account, you must have permissions for the CMK used to encrypt the snapshot.</p> <p>Snapshots created by copying another snapshot have an arbitrary volume ID that should not be used for any purpose.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-copy-snapshot.html\">Copying an Amazon EBS Snapshot</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CopySnapshotRequest :
sig
  type t =
    {
    description: String.t option ;
    destination_region: String.t option ;
    encrypted: Boolean.t option ;
    kms_key_id: String.t option ;
    presigned_url: String.t option ;
    source_region: String.t ;
    source_snapshot_id: String.t ;
    tag_specifications: TagSpecificationList.t ;
    dry_run: Boolean.t option }
  val make :
    ?description:String.t ->
      ?destination_region:String.t ->
        ?encrypted:Boolean.t ->
          ?kms_key_id:String.t ->
            ?presigned_url:String.t ->
              source_region:String.t ->
                source_snapshot_id:String.t ->
                  ?tag_specifications:TagSpecificationList.t ->
                    ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CopySnapshotResult = CopySnapshotResult
type input = CopySnapshotRequest.t
type output = CopySnapshotResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error