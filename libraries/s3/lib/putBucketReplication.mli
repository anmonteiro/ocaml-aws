(** "<p> Creates a replication configuration or replaces an existing one. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/replication.html\">Replication</a> in the <i>Amazon S3 Developer Guide</i>. </p> <note> <p>To perform this operation, the user or role performing the operation must have the <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_passrole.html\">iam:PassRole</a> permission.</p> </note> <p>Specify the replication configuration in the request body. In the replication configuration, you provide the name of the destination bucket where you want Amazon S3 to replicate objects, the IAM role that Amazon S3 can assume to replicate objects on your behalf, and other relevant information.</p> <p>A replication configuration must include at least one rule, and can contain a maximum of 1,000. Each rule identifies a subset of objects to replicate by filtering the objects in the source bucket. To choose additional subsets of objects to replicate, add a rule for each subset. All rules must specify the same destination bucket.</p> <p>To specify a subset of the objects in the source bucket to apply a replication rule to, add the Filter element as a child of the Rule element. You can filter objects based on an object key prefix, one or more object tags, or both. When you add the Filter element in the configuration, you must also add the following elements: <code>DeleteMarkerReplication</code>, <code>Status</code>, and <code>Priority</code>.</p> <p>For information about enabling versioning on a bucket, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/Versioning.html\">Using Versioning</a>.</p> <p>By default, a resource owner, in this case the AWS account that created the bucket, can perform this operation. The resource owner can also grant others permissions to perform the operation. For more information about permissions, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html\">Specifying Permissions in a Policy</a> and <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p> <b>Handling Replication of Encrypted Objects</b> </p> <p>By default, Amazon S3 doesn't replicate objects that are stored at rest using server-side encryption with CMKs stored in AWS KMS. To replicate AWS KMS-encrypted objects, add the following: <code>SourceSelectionCriteria</code>, <code>SseKmsEncryptedObjects</code>, <code>Status</code>, <code>EncryptionConfiguration</code>, and <code>ReplicaKmsKeyID</code>. For information about replication configuration, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-config-for-kms-objects.html\">Replicating Objects Created with SSE Using CMKs stored in AWS KMS</a>.</p> <p>For information on <code>PutBucketReplication</code> errors, see <a>ReplicationErrorCodeList</a> </p> <p>The following operations are related to <code>PutBucketReplication</code>:</p> <ul> <li> <p> <a>GetBucketReplication</a> </p> </li> <li> <p> <a>DeleteBucketReplication</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PutBucketReplicationRequest :
sig
  type t =
    {
    bucket: String.t ;
    content_m_d5: String.t option ;
    replication_configuration: ReplicationConfiguration.t ;
    token: String.t option }
  val make :
    bucket:String.t ->
      ?content_m_d5:String.t ->
        replication_configuration:ReplicationConfiguration.t ->
          ?token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = PutBucketReplicationRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error