(** "<p>This implementation of the GET operation returns an analytics configuration (identified by the analytics configuration ID) from the bucket.</p> <p>To use this operation, you must have permissions to perform the <code>s3:GetAnalyticsConfiguration</code> action. The bucket owner has this permission by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\"> Permissions Related to Bucket Subresource Operations</a> and <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\">Managing Access Permissions to Your Amazon S3 Resources</a> in the <i>Amazon Simple Storage Service Developer Guide</i>. </p> <p>For information about Amazon S3 analytics feature, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/analytics-storage-class.html\">Amazon S3 Analytics \226\128\147 Storage Class Analysis</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p class=\"title\"> <b>Related Resources</b> </p> <ul> <li> <p> </p> </li> <li> <p> </p> </li> <li> <p> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetBucketAnalyticsConfigurationRequest :
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
module GetBucketAnalyticsConfigurationOutput =
GetBucketAnalyticsConfigurationOutput
type input = GetBucketAnalyticsConfigurationRequest.t
type output = GetBucketAnalyticsConfigurationOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error