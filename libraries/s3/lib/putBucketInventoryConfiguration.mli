(** "<p>This implementation of the <code>PUT</code> operation adds an inventory configuration (identified by the inventory ID) to the bucket. You can have up to 1,000 inventory configurations per bucket. </p> <p>Amazon S3 inventory generates inventories of the objects in the bucket on a daily or weekly basis, and the results are published to a flat file. The bucket that is inventoried is called the <i>source</i> bucket, and the bucket where the inventory flat file is stored is called the <i>destination</i> bucket. The <i>destination</i> bucket must be in the same AWS Region as the <i>source</i> bucket. </p> <p>When you configure an inventory for a <i>source</i> bucket, you specify the <i>destination</i> bucket where you want the inventory to be stored, and whether to generate the inventory daily or weekly. You can also configure what object metadata to include and whether to inventory all object versions or only current versions. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev//storage-inventory.html\">Amazon S3 Inventory</a> in the Amazon Simple Storage Service Developer Guide.</p> <important> <p>You must create a bucket policy on the <i>destination</i> bucket to grant permissions to Amazon S3 to write objects to the bucket in the defined location. For an example policy, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/example-bucket-policies.html#example-bucket-policies-use-case-9\"> Granting Permissions for Amazon S3 Inventory and Storage Class Analysis.</a> </p> </important> <p>To use this operation, you must have permissions to perform the <code>s3:PutInventoryConfiguration</code> action. The bucket owner has this permission by default and can grant this permission to others. For more information about permissions, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev//using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\">Permissions Related to Bucket Subresource Operations</a> and <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev//s3-access-control.html\">Managing Access Permissions to Your Amazon S3 Resources</a> in the Amazon Simple Storage Service Developer Guide.</p> <p class=\"title\"> <b>Special Errors</b> </p> <ul> <li> <p class=\"title\"> <b>HTTP 400 Bad Request Error</b> </p> <ul> <li> <p> <i>Code:</i> InvalidArgument</p> </li> <li> <p> <i>Cause:</i> Invalid Argument</p> </li> </ul> </li> <li> <p class=\"title\"> <b>HTTP 400 Bad Request Error</b> </p> <ul> <li> <p> <i>Code:</i> TooManyConfigurations</p> </li> <li> <p> <i>Cause:</i> You are attempting to create a new configuration but have already reached the 1,000-configuration limit. </p> </li> </ul> </li> <li> <p class=\"title\"> <b>HTTP 403 Forbidden Error</b> </p> <ul> <li> <p> <i>Code:</i> AccessDenied</p> </li> <li> <p> <i>Cause:</i> You are not the owner of the specified bucket, or you do not have the <code>s3:PutInventoryConfiguration</code> bucket permission to set the configuration on the bucket </p> </li> </ul> </li> </ul> <p class=\"title\"> <b>Related Resources</b> </p> <ul> <li> <p> <a>GetBucketInventoryConfiguration</a> </p> </li> <li> <p> <a>DeleteBucketInventoryConfiguration</a> </p> </li> <li> <p> <a>ListBucketInventoryConfigurations</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PutBucketInventoryConfigurationRequest :
sig
  type t =
    {
    bucket: String.t ;
    id: String.t ;
    inventory_configuration: InventoryConfiguration.t }
  val make :
    bucket:String.t ->
      id:String.t ->
        inventory_configuration:InventoryConfiguration.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = PutBucketInventoryConfigurationRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error