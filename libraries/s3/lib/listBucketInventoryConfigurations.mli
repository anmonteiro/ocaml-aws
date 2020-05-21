(** "<p>Returns a list of inventory configurations for the bucket. You can have up to 1,000 analytics configurations per bucket.</p> <p>This operation supports list pagination and does not return more than 100 configurations at a time. Always check the <code>IsTruncated</code> element in the response. If there are no more configurations to list, <code>IsTruncated</code> is set to false. If there are more configurations to list, <code>IsTruncated</code> is set to true, and there is a value in <code>NextContinuationToken</code>. You use the <code>NextContinuationToken</code> value to continue the pagination of the list by passing the value in continuation-token in the request to <code>GET</code> the next page.</p> <p> To use this operation, you must have permissions to perform the <code>s3:GetInventoryConfiguration</code> action. The bucket owner has this permission by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\">Permissions Related to Bucket Subresource Operations</a> and <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p>For information about the Amazon S3 inventory feature, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-inventory.html\">Amazon S3 Inventory</a> </p> <p>The following operations are related to <code>ListBucketInventoryConfigurations</code>:</p> <ul> <li> <p> <a>GetBucketInventoryConfiguration</a> </p> </li> <li> <p> <a>DeleteBucketInventoryConfiguration</a> </p> </li> <li> <p> <a>PutBucketInventoryConfiguration</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListBucketInventoryConfigurationsRequest :
sig
  type t = {
    bucket: String.t ;
    continuation_token: String.t option }
  val make : bucket:String.t -> ?continuation_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ListBucketInventoryConfigurationsOutput =
ListBucketInventoryConfigurationsOutput
type input = ListBucketInventoryConfigurationsRequest.t
type output = ListBucketInventoryConfigurationsOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error