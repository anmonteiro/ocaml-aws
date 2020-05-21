(** "<p>Sets a metrics configuration (specified by the metrics configuration ID) for the bucket. You can have up to 1,000 metrics configurations per bucket. If you're updating an existing metrics configuration, note that this is a full replacement of the existing metrics configuration. If you don't include the elements you want to keep, they are erased.</p> <p>To use this operation, you must have permissions to perform the <code>s3:PutMetricsConfiguration</code> action. The bucket owner has this permission by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\">Permissions Related to Bucket Subresource Operations</a> and <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p>For information about CloudWatch request metrics for Amazon S3, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/cloudwatch-monitoring.html\">Monitoring Metrics with Amazon CloudWatch</a>.</p> <p>The following operations are related to <code>PutBucketMetricsConfiguration</code>:</p> <ul> <li> <p> <a>DeleteBucketMetricsConfiguration</a> </p> </li> <li> <p> <a>PutBucketMetricsConfiguration</a> </p> </li> <li> <p> <a>ListBucketMetricsConfigurations</a> </p> </li> </ul> <p> <code>GetBucketLifecycle</code> has the following special error:</p> <ul> <li> <p>Error code: <code>TooManyConfigurations</code> </p> <ul> <li> <p>Description: You are attempting to create a new configuration but have already reached the 1,000-configuration limit.</p> </li> <li> <p>HTTP Status Code: HTTP 400 Bad Request</p> </li> </ul> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PutBucketMetricsConfigurationRequest :
sig
  type t =
    {
    bucket: String.t ;
    id: String.t ;
    metrics_configuration: MetricsConfiguration.t }
  val make :
    bucket:String.t ->
      id:String.t ->
        metrics_configuration:MetricsConfiguration.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = PutBucketMetricsConfigurationRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error