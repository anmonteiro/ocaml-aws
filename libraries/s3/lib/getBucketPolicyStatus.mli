(** "<p>Retrieves the policy status for an Amazon S3 bucket, indicating whether the bucket is public. In order to use this operation, you must have the <code>s3:GetBucketPolicyStatus</code> permission. For more information about Amazon S3 permissions, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html\">Specifying Permissions in a Policy</a>.</p> <p> For more information about when Amazon S3 considers a bucket public, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/access-control-block-public-access.html#access-control-block-public-access-policy-status\">The Meaning of \"Public\"</a>. </p> <p>The following operations are related to <code>GetBucketPolicyStatus</code>:</p> <ul> <li> <p> <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/access-control-block-public-access.html\">Using Amazon S3 Block Public Access</a> </p> </li> <li> <p> <a>GetPublicAccessBlock</a> </p> </li> <li> <p> <a>PutPublicAccessBlock</a> </p> </li> <li> <p> <a>DeletePublicAccessBlock</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetBucketPolicyStatusRequest :
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
module GetBucketPolicyStatusOutput = GetBucketPolicyStatusOutput
type input = GetBucketPolicyStatusRequest.t
type output = GetBucketPolicyStatusOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error