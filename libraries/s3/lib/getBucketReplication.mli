(** "<p>Returns the replication configuration of a bucket.</p> <note> <p> It can take a while to propagate the put or delete a replication configuration to all Amazon S3 systems. Therefore, a get request soon after put or delete can return a wrong result. </p> </note> <p> For information about replication configuration, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/replication.html\">Replication</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>This operation requires permissions for the <code>s3:GetReplicationConfiguration</code> action. For more information about permissions, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-iam-policies.html\">Using Bucket Policies and User Policies</a>.</p> <p>If you include the <code>Filter</code> element in a replication configuration, you must also include the <code>DeleteMarkerReplication</code> and <code>Priority</code> elements. The response also returns those elements.</p> <p>For information about <code>GetBucketReplication</code> errors, see <a>ReplicationErrorCodeList</a> </p> <p>The following operations are related to <code>GetBucketReplication</code>:</p> <ul> <li> <p> <a>PutBucketReplication</a> </p> </li> <li> <p> <a>DeleteBucketReplication</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetBucketReplicationRequest :
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
module GetBucketReplicationOutput = GetBucketReplicationOutput
type input = GetBucketReplicationRequest.t
type output = GetBucketReplicationOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error