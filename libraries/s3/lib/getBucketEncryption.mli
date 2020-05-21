(** "<p>Returns the default encryption configuration for an Amazon S3 bucket. For information about the Amazon S3 default encryption feature, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-encryption.html\">Amazon S3 Default Bucket Encryption</a>.</p> <p> To use this operation, you must have permission to perform the <code>s3:GetEncryptionConfiguration</code> action. The bucket owner has this permission by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\">Permissions Related to Bucket Subresource Operations</a> and <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p>The following operations are related to <code>GetBucketEncryption</code>:</p> <ul> <li> <p> <a>PutBucketEncryption</a> </p> </li> <li> <p> <a>DeleteBucketEncryption</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetBucketEncryptionRequest :
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
module GetBucketEncryptionOutput = GetBucketEncryptionOutput
type input = GetBucketEncryptionRequest.t
type output = GetBucketEncryptionOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error