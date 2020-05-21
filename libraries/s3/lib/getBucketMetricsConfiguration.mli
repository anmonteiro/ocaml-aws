(** "<p>Gets a metrics configuration (specified by the metrics configuration ID) from the bucket. Note that this doesn't include the daily storage metrics.</p> <p> To use this operation, you must have permissions to perform the <code>s3:GetMetricsConfiguration</code> action. The bucket owner has this permission by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\">Permissions Related to Bucket Subresource Operations</a> and <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p> For information about CloudWatch request metrics for Amazon S3, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/cloudwatch-monitoring.html\">Monitoring Metrics with Amazon CloudWatch</a>.</p> <p>The following operations are related to <code>GetBucketMetricsConfiguration</code>:</p> <ul> <li> <p> <a>PutBucketMetricsConfiguration</a> </p> </li> <li> <p> <a>DeleteBucketMetricsConfiguration</a> </p> </li> <li> <p> <a>ListBucketMetricsConfigurations</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/cloudwatch-monitoring.html\">Monitoring Metrics with Amazon CloudWatch</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetBucketMetricsConfigurationRequest :
sig
  type t = {
    bucket: String.t ;
    id: String.t }
  val make : bucket:String.t -> id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module GetBucketMetricsConfigurationOutput =
GetBucketMetricsConfigurationOutput
type input = GetBucketMetricsConfigurationRequest.t
type output = GetBucketMetricsConfigurationOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error