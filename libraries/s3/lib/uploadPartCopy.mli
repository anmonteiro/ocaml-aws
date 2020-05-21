(** "<p>Uploads a part by copying data from an existing object as data source. You specify the data source by adding the request header <code>x-amz-copy-source</code> in your request and a byte range by adding the request header <code>x-amz-copy-source-range</code> in your request. </p> <p>The minimum allowable part size for a multipart upload is 5 MB. For more information about multipart upload limits, go to <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/qfacts.html\">Quick Facts</a> in the <i>Amazon Simple Storage Service Developer Guide</i>. </p> <note> <p>Instead of using an existing object as part data, you might use the <a>UploadPart</a> operation and provide data in your request.</p> </note> <p>You must initiate a multipart upload before you can upload any part. In response to your initiate request. Amazon S3 returns a unique identifier, the upload ID, that you must include in your upload part request.</p> <p>For more information about using the <code>UploadPartCopy</code> operation, see the following:</p> <ul> <li> <p>For conceptual information about multipart uploads, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/uploadobjusingmpu.html\">Uploading Objects Using Multipart Upload</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> </li> <li> <p>For information about permissions required to use the multipart upload API, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuAndPermissions.html\">Multipart Upload API and Permissions</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> </li> <li> <p>For information about copying objects using a single atomic operation vs. the multipart upload, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/ObjectOperations.html\">Operations on Objects</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> </li> <li> <p>For information about using server-side encryption with customer-provided encryption keys with the UploadPartCopy operation, see <a>CopyObject</a> and <a>UploadPart</a>.</p> </li> </ul> <p>Note the following additional considerations about the request headers <code>x-amz-copy-source-if-match</code>, <code>x-amz-copy-source-if-none-match</code>, <code>x-amz-copy-source-if-unmodified-since</code>, and <code>x-amz-copy-source-if-modified-since</code>:</p> <p> </p> <ul> <li> <p> <b>Consideration 1</b> - If both of the <code>x-amz-copy-source-if-match</code> and <code>x-amz-copy-source-if-unmodified-since</code> headers are present in the request as follows:</p> <p> <code>x-amz-copy-source-if-match</code> condition evaluates to <code>true</code>, and;</p> <p> <code>x-amz-copy-source-if-unmodified-since</code> condition evaluates to <code>false</code>;</p> <p>Amazon S3 returns <code>200 OK</code> and copies the data. </p> </li> <li> <p> <b>Consideration 2</b> - If both of the <code>x-amz-copy-source-if-none-match</code> and <code>x-amz-copy-source-if-modified-since</code> headers are present in the request as follows:</p> <p> <code>x-amz-copy-source-if-none-match</code> condition evaluates to <code>false</code>, and;</p> <p> <code>x-amz-copy-source-if-modified-since</code> condition evaluates to <code>true</code>;</p> <p>Amazon S3 returns <code>412 Precondition Failed</code> response code. </p> </li> </ul> <p> <b>Versioning</b> </p> <p>If your bucket has versioning enabled, you could have multiple versions of the same object. By default, <code>x-amz-copy-source</code> identifies the current version of the object to copy. If the current version is a delete marker and you don't specify a versionId in the <code>x-amz-copy-source</code>, Amazon S3 returns a 404 error, because the object does not exist. If you specify versionId in the <code>x-amz-copy-source</code> and the versionId is a delete marker, Amazon S3 returns an HTTP 400 error, because you are not allowed to specify a delete marker as a version for the <code>x-amz-copy-source</code>. </p> <p>You can optionally specify a specific version of the source object to copy by adding the <code>versionId</code> subresource as shown in the following example:</p> <p> <code>x-amz-copy-source: /bucket/object?versionId=version id</code> </p> <p class=\"title\"> <b>Special Errors</b> </p> <ul> <li> <p class=\"title\"> <b/> </p> <ul> <li> <p> <i>Code: NoSuchUpload</i> </p> </li> <li> <p> <i>Cause: The specified multipart upload does not exist. The upload ID might be invalid, or the multipart upload might have been aborted or completed.</i> </p> </li> <li> <p> <i>HTTP Status Code: 404 Not Found</i> </p> </li> </ul> </li> <li> <p class=\"title\"> <b/> </p> <ul> <li> <p> <i>Code: InvalidRequest</i> </p> </li> <li> <p> <i>Cause: The specified copy source is not supported as a byte-range copy source.</i> </p> </li> <li> <p> <i>HTTP Status Code: 400 Bad Request</i> </p> </li> </ul> </li> </ul> <p class=\"title\"> <b>Related Resources</b> </p> <ul> <li> <p> <a>CreateMultipartUpload</a> </p> </li> <li> <p> <a>UploadPart</a> </p> </li> <li> <p> <a>CompleteMultipartUpload</a> </p> </li> <li> <p> <a>AbortMultipartUpload</a> </p> </li> <li> <p> <a>ListParts</a> </p> </li> <li> <p> <a>ListMultipartUploads</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module UploadPartCopyRequest :
sig
  type t =
    {
    bucket: String.t ;
    copy_source: String.t ;
    copy_source_if_match: String.t option ;
    copy_source_if_modified_since: DateTime.t option ;
    copy_source_if_none_match: String.t option ;
    copy_source_if_unmodified_since: DateTime.t option ;
    copy_source_range: String.t option ;
    key: String.t ;
    part_number: Integer.t ;
    upload_id: String.t ;
    s_s_e_customer_algorithm: String.t option ;
    s_s_e_customer_key: String.t option ;
    s_s_e_customer_key_m_d5: String.t option ;
    copy_source_s_s_e_customer_algorithm: String.t option ;
    copy_source_s_s_e_customer_key: String.t option ;
    copy_source_s_s_e_customer_key_m_d5: String.t option ;
    request_payer: RequestPayer.t option }
  val make :
    bucket:String.t ->
      copy_source:String.t ->
        ?copy_source_if_match:String.t ->
          ?copy_source_if_modified_since:DateTime.t ->
            ?copy_source_if_none_match:String.t ->
              ?copy_source_if_unmodified_since:DateTime.t ->
                ?copy_source_range:String.t ->
                  key:String.t ->
                    part_number:Integer.t ->
                      upload_id:String.t ->
                        ?s_s_e_customer_algorithm:String.t ->
                          ?s_s_e_customer_key:String.t ->
                            ?s_s_e_customer_key_m_d5:String.t ->
                              ?copy_source_s_s_e_customer_algorithm:String.t
                                ->
                                ?copy_source_s_s_e_customer_key:String.t ->
                                  ?copy_source_s_s_e_customer_key_m_d5:String.t
                                    ->
                                    ?request_payer:RequestPayer.t ->
                                      unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module UploadPartCopyOutput = UploadPartCopyOutput
type input = UploadPartCopyRequest.t
type output = UploadPartCopyOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error