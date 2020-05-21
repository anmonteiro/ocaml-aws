(** "<p>Sets the accelerate configuration of an existing bucket. Amazon S3 Transfer Acceleration is a bucket-level feature that enables you to perform faster data transfers to Amazon S3.</p> <p> To use this operation, you must have permission to perform the s3:PutAccelerateConfiguration action. The bucket owner has this permission by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\">Permissions Related to Bucket Subresource Operations</a> and <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p> The Transfer Acceleration state of a bucket can be set to one of the following two values:</p> <ul> <li> <p> Enabled \226\128\147 Enables accelerated data transfers to the bucket.</p> </li> <li> <p> Suspended \226\128\147 Disables accelerated data transfers to the bucket.</p> </li> </ul> <p>The <a>GetBucketAccelerateConfiguration</a> operation returns the transfer acceleration state of a bucket.</p> <p>After setting the Transfer Acceleration state of a bucket to Enabled, it might take up to thirty minutes before the data transfer rates to the bucket increase.</p> <p> The name of the bucket used for Transfer Acceleration must be DNS-compliant and must not contain periods (\".\").</p> <p> For more information about transfer acceleration, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/transfer-acceleration.html\">Transfer Acceleration</a>.</p> <p>The following operations are related to <code>PutBucketAccelerateConfiguration</code>:</p> <ul> <li> <p> <a>GetBucketAccelerateConfiguration</a> </p> </li> <li> <p> <a>CreateBucket</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PutBucketAccelerateConfigurationRequest :
sig
  type t =
    {
    bucket: String.t ;
    accelerate_configuration: AccelerateConfiguration.t }
  val make :
    bucket:String.t ->
      accelerate_configuration:AccelerateConfiguration.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = PutBucketAccelerateConfigurationRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error