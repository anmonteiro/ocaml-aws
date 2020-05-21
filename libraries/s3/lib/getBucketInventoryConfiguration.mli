(** "<p>Returns an inventory configuration (identified by the inventory configuration ID) from the bucket.</p> <p>To use this operation, you must have permissions to perform the <code>s3:GetInventoryConfiguration</code> action. The bucket owner has this permission by default and can grant this permission to others. For more information about permissions, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\">Permissions Related to Bucket Subresource Operations</a> and <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p>For information about the Amazon S3 inventory feature, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-inventory.html\">Amazon S3 Inventory</a>.</p> <p>The following operations are related to <code>GetBucketInventoryConfiguration</code>:</p> <ul> <li> <p> <a>DeleteBucketInventoryConfiguration</a> </p> </li> <li> <p> <a>ListBucketInventoryConfigurations</a> </p> </li> <li> <p> <a>PutBucketInventoryConfiguration</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetBucketInventoryConfigurationRequest :
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
module GetBucketInventoryConfigurationOutput =
GetBucketInventoryConfigurationOutput
type input = GetBucketInventoryConfigurationRequest.t
type output = GetBucketInventoryConfigurationOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error