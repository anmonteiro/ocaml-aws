(** "<p>Uploads a part in a multipart upload.</p> <note> <p>In this operation, you provide part data in your request. However, you have an option to specify your existing Amazon S3 object as a data source for the part you are uploading. To upload a part from an existing object, you use the <a>UploadPartCopy</a> operation. </p> </note> <p>You must initiate a multipart upload (see <a>CreateMultipartUpload</a>) before you can upload any part. In response to your initiate request, Amazon S3 returns an upload ID, a unique identifier, that you must include in your upload part request.</p> <p>Part numbers can be any number from 1 to 10,000, inclusive. A part number uniquely identifies a part and also defines its position within the object being created. If you upload a new part using the same part number that was used with a previous part, the previously uploaded part is overwritten. Each part must be at least 5 MB in size, except the last part. There is no size limit on the last part of your multipart upload.</p> <p>To ensure that data is not corrupted when traversing the network, specify the <code>Content-MD5</code> header in the upload part request. Amazon S3 checks the part data against the provided MD5 value. If they do not match, Amazon S3 returns an error. </p> <p> <b>Note:</b> After you initiate multipart upload and upload one or more parts, you must either complete or abort multipart upload in order to stop getting charged for storage of the uploaded parts. Only after you either complete or abort multipart upload, Amazon S3 frees up the parts storage and stops charging you for the parts storage.</p> <p>For more information on multipart uploads, go to <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html\">Multipart Upload Overview</a> in the <i>Amazon Simple Storage Service Developer Guide </i>.</p> <p>For information on the permissions required to use the multipart upload API, go to <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuAndPermissions.html\">Multipart Upload API and Permissions</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>You can optionally request server-side encryption where Amazon S3 encrypts your data as it writes it to disks in its data centers and decrypts it for you when you access it. You have the option of providing your own encryption key, or you can use the AWS managed encryption keys. If you choose to provide your own encryption key, the request headers you provide in the request must match the headers you used in the request to initiate the upload by using <a>CreateMultipartUpload</a>. For more information, go to <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingServerSideEncryption.html\">Using Server-Side Encryption</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>Server-side encryption is supported by the S3 Multipart Upload actions. Unless you are using a customer-provided encryption key, you don't need to specify the encryption parameters in each UploadPart request. Instead, you only need to specify the server-side encryption parameters in the initial Initiate Multipart request. For more information, see <a>CreateMultipartUpload</a>.</p> <p>If you requested server-side encryption using a customer-provided encryption key in your initiate multipart upload request, you must provide identical encryption information in each part upload using the following headers.</p> <ul> <li> <p>x-amz-server-side\226\128\139-encryption\226\128\139-customer-algorithm</p> </li> <li> <p>x-amz-server-side\226\128\139-encryption\226\128\139-customer-key</p> </li> <li> <p>x-amz-server-side\226\128\139-encryption\226\128\139-customer-key-MD5</p> </li> </ul> <p class=\"title\"> <b>Special Errors</b> </p> <ul> <li> <p class=\"title\"> <b/> </p> <ul> <li> <p> <i>Code: NoSuchUpload</i> </p> </li> <li> <p> <i>Cause: The specified multipart upload does not exist. The upload ID might be invalid, or the multipart upload might have been aborted or completed.</i> </p> </li> <li> <p> <i> HTTP Status Code: 404 Not Found </i> </p> </li> <li> <p> <i>SOAP Fault Code Prefix: Client</i> </p> </li> </ul> </li> </ul> <p class=\"title\"> <b>Related Resources</b> </p> <ul> <li> <p> <a>CreateMultipartUpload</a> </p> </li> <li> <p> <a>CompleteMultipartUpload</a> </p> </li> <li> <p> <a>AbortMultipartUpload</a> </p> </li> <li> <p> <a>ListParts</a> </p> </li> <li> <p> <a>ListMultipartUploads</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module UploadPartRequest :
sig
  type t =
    {
    body: Blob.t option ;
    bucket: String.t ;
    content_length: Long.t option ;
    content_m_d5: String.t option ;
    key: String.t ;
    part_number: Integer.t ;
    upload_id: String.t ;
    s_s_e_customer_algorithm: String.t option ;
    s_s_e_customer_key: String.t option ;
    s_s_e_customer_key_m_d5: String.t option ;
    request_payer: RequestPayer.t option }
  val make :
    ?body:Blob.t ->
      bucket:String.t ->
        ?content_length:Long.t ->
          ?content_m_d5:String.t ->
            key:String.t ->
              part_number:Integer.t ->
                upload_id:String.t ->
                  ?s_s_e_customer_algorithm:String.t ->
                    ?s_s_e_customer_key:String.t ->
                      ?s_s_e_customer_key_m_d5:String.t ->
                        ?request_payer:RequestPayer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module UploadPartOutput = UploadPartOutput
type input = UploadPartRequest.t
type output = UploadPartOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error