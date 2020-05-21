(** "<p>This implementation of the GET operation uses the <code>accelerate</code> subresource to return the Transfer Acceleration state of a bucket, which is either <code>Enabled</code> or <code>Suspended</code>. Amazon S3 Transfer Acceleration is a bucket-level feature that enables you to perform faster data transfers to and from Amazon S3.</p> <p>To use this operation, you must have permission to perform the <code>s3:GetAccelerateConfiguration</code> action. The bucket owner has this permission by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev//using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\">Permissions Related to Bucket Subresource Operations</a> and <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev//s3-access-control.html\">Managing Access Permissions to your Amazon S3 Resources</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>You set the Transfer Acceleration state of an existing bucket to <code>Enabled</code> or <code>Suspended</code> by using the <a>PutBucketAccelerateConfiguration</a> operation. </p> <p>A GET <code>accelerate</code> request does not return a state value for a bucket that has no transfer acceleration state. A bucket has no Transfer Acceleration state if a state has never been set on the bucket. </p> <p>For more information about transfer acceleration, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev//transfer-acceleration.html\">Transfer Acceleration</a> in the Amazon Simple Storage Service Developer Guide.</p> <p class=\"title\"> <b>Related Resources</b> </p> <ul> <li> <p> <a>PutBucketAccelerateConfiguration</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetBucketAccelerateConfigurationRequest :
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
module GetBucketAccelerateConfigurationOutput =
GetBucketAccelerateConfigurationOutput
type input = GetBucketAccelerateConfigurationRequest.t
type output = GetBucketAccelerateConfigurationOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error