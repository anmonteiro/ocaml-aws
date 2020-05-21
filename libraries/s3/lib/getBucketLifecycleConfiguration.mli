(** "<note> <p>Bucket lifecycle configuration now supports specifying a lifecycle rule using an object key name prefix, one or more object tags, or a combination of both. Accordingly, this section describes the latest API. The response describes the new filter element that you can use to specify a filter to select a subset of objects to which the rule applies. If you are still using previous version of the lifecycle configuration, it works. For the earlier API description, see <a>GetBucketLifecycle</a>.</p> </note> <p>Returns the lifecycle configuration information set on the bucket. For information about lifecycle configuration, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html\">Object Lifecycle Management</a>.</p> <p>To use this operation, you must have permission to perform the <code>s3:GetLifecycleConfiguration</code> action. The bucket owner has this permission, by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\">Permissions Related to Bucket Subresource Operations</a> and <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p> <code>GetBucketLifecycleConfiguration</code> has the following special error:</p> <ul> <li> <p>Error code: <code>NoSuchLifecycleConfiguration</code> </p> <ul> <li> <p>Description: The lifecycle configuration does not exist.</p> </li> <li> <p>HTTP Status Code: 404 Not Found</p> </li> <li> <p>SOAP Fault Code Prefix: Client</p> </li> </ul> </li> </ul> <p>The following operations are related to <code>DeleteBucketMetricsConfiguration</code>:</p> <ul> <li> <p> <a>GetBucketLifecycle</a> </p> </li> <li> <p> <a>PutBucketLifecycle</a> </p> </li> <li> <p> <a>DeleteBucketLifecycle</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetBucketLifecycleConfigurationRequest :
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
module GetBucketLifecycleConfigurationOutput =
GetBucketLifecycleConfigurationOutput
type input = GetBucketLifecycleConfigurationRequest.t
type output = GetBucketLifecycleConfigurationOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error