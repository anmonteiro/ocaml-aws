(** "<p> Deletes the replication configuration from the bucket.</p> <p>To use this operation, you must have permissions to perform the <code>s3:PutReplicationConfiguration</code> action. The bucket owner has these permissions by default and can grant it to others. For more information about permissions, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\">Permissions Related to Bucket Subresource Operations</a> and <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\">Managing Access Permissions to Your Amazon S3 Resources</a>. </p> <note> <p>It can take a while for the deletion of a replication configuration to fully propagate.</p> </note> <p> For information about replication configuration, see <a href=\" https://docs.aws.amazon.com/AmazonS3/latest/dev/replication.html\">Replication</a> in the <i>Amazon S3 Developer Guide</i>. </p> <p>The following operations are related to <code>DeleteBucketReplication</code>:</p> <ul> <li> <p> <a>PutBucketReplication</a> </p> </li> <li> <p> <a>GetBucketReplication</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteBucketReplicationRequest :
sig
  type t = {
    bucket: String.t }
  val make : bucket:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = DeleteBucketReplicationRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error