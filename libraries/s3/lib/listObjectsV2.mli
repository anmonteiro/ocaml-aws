(** "<p>Returns some or all (up to 1,000) of the objects in a bucket. You can use the request parameters as selection criteria to return a subset of the objects in a bucket. A <code>200 OK</code> response can contain valid or invalid XML. Make sure to design your application to parse the contents of the response and handle it appropriately.</p> <p>To use this operation, you must have READ access to the bucket.</p> <p>To use this operation in an AWS Identity and Access Management (IAM) policy, you must have permissions to perform the <code>s3:ListBucket</code> action. The bucket owner has this permission by default and can grant this permission to others. For more information about permissions, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\">Permissions Related to Bucket Subresource Operations</a> and <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <important> <p>This section describes the latest revision of the API. We recommend that you use this revised API for application development. For backward compatibility, Amazon S3 continues to support the prior version of this API, <a>ListObjects</a>.</p> </important> <p>To get a list of your buckets, see <a>ListBuckets</a>.</p> <p>The following operations are related to <code>ListObjectsV2</code>:</p> <ul> <li> <p> <a>GetObject</a> </p> </li> <li> <p> <a>PutObject</a> </p> </li> <li> <p> <a>CreateBucket</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListObjectsV2Request :
sig
  type t =
    {
    bucket: String.t ;
    delimiter: String.t option ;
    encoding_type: EncodingType.t option ;
    max_keys: Integer.t option ;
    prefix: String.t option ;
    continuation_token: String.t option ;
    fetch_owner: Boolean.t option ;
    start_after: String.t option ;
    request_payer: RequestPayer.t option }
  val make :
    bucket:String.t ->
      ?delimiter:String.t ->
        ?encoding_type:EncodingType.t ->
          ?max_keys:Integer.t ->
            ?prefix:String.t ->
              ?continuation_token:String.t ->
                ?fetch_owner:Boolean.t ->
                  ?start_after:String.t ->
                    ?request_payer:RequestPayer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ListObjectsV2Output = ListObjectsV2Output
type input = ListObjectsV2Request.t
type output = ListObjectsV2Output.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error