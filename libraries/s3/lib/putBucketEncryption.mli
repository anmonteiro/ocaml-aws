(** "<p>This implementation of the <code>PUT</code> operation uses the <code>encryption</code> subresource to set the default encryption state of an existing bucket.</p> <p>This implementation of the <code>PUT</code> operation sets default encryption for a bucket using server-side encryption with Amazon S3-managed keys SSE-S3 or AWS KMS customer master keys (CMKs) (SSE-KMS).</p> <important> <p>This operation requires AWS Signature Version 4. For more information, see <a href=\"sig-v4-authenticating-requests.html\"> Authenticating Requests (AWS Signature Version 4)</a>. </p> </important> <p>To use this operation, you must have permissions to perform the <code>s3:PutEncryptionConfiguration</code> action. The bucket owner has this permission by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\">Permissions Related to Bucket Subresource Operations</a> and <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\">Managing Access Permissions to Your Amazon S3 Resources</a> in the Amazon Simple Storage Service Developer Guide. </p> <p class=\"title\"> <b>Related Resources</b> </p> <ul> <li> <p> <a>GetBucketEncryption</a> </p> </li> <li> <p> <a>DeleteBucketEncryption</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PutBucketEncryptionRequest :
sig
  type t =
    {
    bucket: String.t ;
    content_m_d5: String.t option ;
    server_side_encryption_configuration: ServerSideEncryptionConfiguration.t }
  val make :
    bucket:String.t ->
      ?content_m_d5:String.t ->
        server_side_encryption_configuration:ServerSideEncryptionConfiguration.t
          -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = PutBucketEncryptionRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error