(** "<p>Applies an Amazon S3 bucket policy to an Amazon S3 bucket. If you are using an identity other than the root user of the AWS account that owns the bucket, the calling identity must have the <code>PutBucketPolicy</code> permissions on the specified bucket and belong to the bucket owner's account in order to use this operation.</p> <p>If you don't have <code>PutBucketPolic</code>y permissions, Amazon S3 returns a <code>403 Access Denied</code> error. If you have the correct permissions, but you're not using an identity that belongs to the bucket owner's account, Amazon S3 returns a <code>405 Method Not Allowed</code> error.</p> <important> <p> As a security precaution, the root user of the AWS account that owns a bucket can always use this operation, even if the policy explicitly denies the root user the ability to perform this action. </p> </important> <p>For more information about bucket policies, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-iam-policies.html\">Using Bucket Policies and User Policies</a>.</p> <p>The following operations are related to <code>PutBucketPolicy</code>:</p> <ul> <li> <p> <a>CreateBucket</a> </p> </li> <li> <p> <a>DeleteBucket</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PutBucketPolicyRequest :
sig
  type t =
    {
    bucket: String.t ;
    content_m_d5: String.t option ;
    confirm_remove_self_bucket_access: Boolean.t option ;
    policy: String.t }
  val make :
    bucket:String.t ->
      ?content_m_d5:String.t ->
        ?confirm_remove_self_bucket_access:Boolean.t ->
          policy:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = PutBucketPolicyRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error