(** "<p>Returns the policy of a specified bucket. If you are using an identity other than the root user of the AWS account that owns the bucket, the calling identity must have the <code>GetBucketPolicy</code> permissions on the specified bucket and belong to the bucket owner's account in order to use this operation.</p> <p>If you don't have <code>GetBucketPolicy</code> permissions, Amazon S3 returns a <code>403 Access Denied</code> error. If you have the correct permissions, but you're not using an identity that belongs to the bucket owner's account, Amazon S3 returns a <code>405 Method Not Allowed</code> error.</p> <important> <p>As a security precaution, the root user of the AWS account that owns a bucket can always use this operation, even if the policy explicitly denies the root user the ability to perform this action.</p> </important> <p>For more information about bucket policies, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-iam-policies.html\">Using Bucket Policies and User Policies</a>.</p> <p>The following operation is related to <code>GetBucketPolicy</code>:</p> <ul> <li> <p> <a>GetObject</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetBucketPolicyRequest :
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
module GetBucketPolicyOutput = GetBucketPolicyOutput
type input = GetBucketPolicyRequest.t
type output = (GetBucketPolicyOutput.t * Piaf.Body.t)
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error