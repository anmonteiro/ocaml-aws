(** "<p>Sets the tags for a bucket.</p> <p>Use tags to organize your AWS bill to reflect your own cost structure. To do this, sign up to get your AWS account bill with tag key values included. Then, to see the cost of combined resources, organize your billing information according to resources with the same tag key values. For example, you can tag several resources with a specific application name, and then organize your billing information to see the total cost of that application across several services. For more information, see <a href=\"https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html\">Cost Allocation and Tagging</a>.</p> <note> <p>Within a bucket, if you add a tag that has the same key as an existing tag, the new value overwrites the old value. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/CostAllocTagging.html\">Using Cost Allocation in Amazon S3 Bucket Tags</a>.</p> </note> <p>To use this operation, you must have permissions to perform the <code>s3:PutBucketTagging</code> action. The bucket owner has this permission by default and can grant this permission to others. For more information about permissions, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\">Permissions Related to Bucket Subresource Operations</a> and <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p> <code>PutBucketTagging</code> has the following special errors:</p> <ul> <li> <p>Error code: <code>InvalidTagError</code> </p> <ul> <li> <p>Description: The tag provided was not a valid tag. This error can occur if the tag did not pass input validation. For information about tag restrictions, see <a href=\"https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2//allocation-tag-restrictions.html\">User-Defined Tag Restrictions</a> and <a href=\"https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2//aws-tag-restrictions.html\">AWS-Generated Cost Allocation Tag Restrictions</a>.</p> </li> </ul> </li> <li> <p>Error code: <code>MalformedXMLError</code> </p> <ul> <li> <p>Description: The XML provided does not match the schema.</p> </li> </ul> </li> <li> <p>Error code: <code>OperationAbortedError </code> </p> <ul> <li> <p>Description: A conflicting conditional operation is currently in progress against this resource. Please try again.</p> </li> </ul> </li> <li> <p>Error code: <code>InternalError</code> </p> <ul> <li> <p>Description: The service was unable to apply the provided tag to the bucket.</p> </li> </ul> </li> </ul> <p>The following operations are related to <code>PutBucketTagging</code>:</p> <ul> <li> <p> <a>GetBucketTagging</a> </p> </li> <li> <p> <a>DeleteBucketTagging</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PutBucketTaggingRequest :
sig
  type t =
    {
    bucket: String.t ;
    content_m_d5: String.t option ;
    tagging: Tagging.t }
  val make :
    bucket:String.t ->
      ?content_m_d5:String.t -> tagging:Tagging.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = PutBucketTaggingRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error