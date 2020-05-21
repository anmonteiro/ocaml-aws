(** "<important> <p>For an updated version of this API, see <a>GetBucketLifecycleConfiguration</a>. If you configured a bucket lifecycle using the <code>filter</code> element, you should see the updated version of this topic. This topic is provided for backward compatibility.</p> </important> <p>Returns the lifecycle configuration information set on the bucket. For information about lifecycle configuration, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html\">Object Lifecycle Management</a>.</p> <p> To use this operation, you must have permission to perform the <code>s3:GetLifecycleConfiguration</code> action. The bucket owner has this permission by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\">Permissions Related to Bucket Subresource Operations</a> and <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p> <code>GetBucketLifecycle</code> has the following special error:</p> <ul> <li> <p>Error code: <code>NoSuchLifecycleConfiguration</code> </p> <ul> <li> <p>Description: The lifecycle configuration does not exist.</p> </li> <li> <p>HTTP Status Code: 404 Not Found</p> </li> <li> <p>SOAP Fault Code Prefix: Client</p> </li> </ul> </li> </ul> <p>The following operations are related to <code>GetBucketLifecycle</code>:</p> <ul> <li> <p> <a>GetBucketLifecycleConfiguration</a> </p> </li> <li> <p> <a>PutBucketLifecycle</a> </p> </li> <li> <p> <a>DeleteBucketLifecycle</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetBucketLifecycleRequest :
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
module GetBucketLifecycleOutput = GetBucketLifecycleOutput
type input = GetBucketLifecycleRequest.t
type output = GetBucketLifecycleOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error