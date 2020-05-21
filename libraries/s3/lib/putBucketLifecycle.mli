(** "<important> <p>For an updated version of this API, see <a>PutBucketLifecycleConfiguration</a>. This version has been deprecated. Existing lifecycle configurations will work. For new lifecycle configurations, use the updated API. </p> </important> <p>Creates a new lifecycle configuration for the bucket or replaces an existing lifecycle configuration. For information about lifecycle configuration, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev//object-lifecycle-mgmt.html\">Object Lifecycle Management</a> in the <i>Amazon Simple Storage Service Developer Guide</i>. </p> <p>By default, all Amazon S3 resources, including buckets, objects, and related subresources (for example, lifecycle configuration and website configuration) are private. Only the resource owner, the AWS account that created the resource, can access it. The resource owner can optionally grant access permissions to others by writing an access policy. For this operation, users must get the <code>s3:PutLifecycleConfiguration</code> permission.</p> <p>You can also explicitly deny permissions. Explicit denial also supersedes any other permissions. If you want to prevent users or accounts from removing or deleting objects from your bucket, you must deny them permissions for the following actions: </p> <ul> <li> <p> <code>s3:DeleteObject</code> </p> </li> <li> <p> <code>s3:DeleteObjectVersion</code> </p> </li> <li> <p> <code>s3:PutLifecycleConfiguration</code> </p> </li> </ul> <p>For more information about permissions, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev//s3-access-control.html\">Managing Access Permissions to your Amazon S3 Resources</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>For more examples of transitioning objects to storage classes such as STANDARD_IA or ONEZONE_IA, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev//intro-lifecycle-rules.html#lifecycle-configuration-examples\">Examples of Lifecycle Configuration</a>.</p> <p class=\"title\"> <b>Related Resources</b> </p> <ul> <li> <p> <a>GetBucketLifecycle</a>(Deprecated)</p> </li> <li> <p> <a>GetBucketLifecycleConfiguration</a> </p> </li> <li> <p> </p> </li> <li> <p>By default, a resource owner\226\128\148in this case, a bucket owner, which is the AWS account that created the bucket\226\128\148can perform any of the operations. A resource owner can also grant others permission to perform the operation. For more information, see the following topics in the Amazon Simple Storage Service Developer Guide: </p> <ul> <li> <p> <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev//using-with-s3-actions.html\">Specifying Permissions in a Policy</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev//s3-access-control.html\">Managing Access Permissions to your Amazon S3 Resources</a> </p> </li> </ul> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PutBucketLifecycleRequest :
sig
  type t =
    {
    bucket: String.t ;
    content_m_d5: String.t option ;
    lifecycle_configuration: LifecycleConfiguration.t option }
  val make :
    bucket:String.t ->
      ?content_m_d5:String.t ->
        ?lifecycle_configuration:LifecycleConfiguration.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = PutBucketLifecycleRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error