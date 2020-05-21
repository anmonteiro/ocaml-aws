(** "<p>Completes a multipart upload by assembling previously uploaded parts.</p> <p>You first initiate the multipart upload and then upload all parts using the <a>UploadPart</a> operation. After successfully uploading all relevant parts of an upload, you call this operation to complete the upload. Upon receiving this request, Amazon S3 concatenates all the parts in ascending order by part number to create a new object. In the Complete Multipart Upload request, you must provide the parts list. You must ensure that the parts list is complete. This operation concatenates the parts that you provide in the list. For each part in the list, you must provide the part number and the <code>ETag</code> value, returned after that part was uploaded.</p> <p>Processing of a Complete Multipart Upload request could take several minutes to complete. After Amazon S3 begins processing the request, it sends an HTTP response header that specifies a 200 OK response. While processing is in progress, Amazon S3 periodically sends white space characters to keep the connection from timing out. Because a request could fail after the initial 200 OK response has been sent, it is important that you check the response body to determine whether the request succeeded.</p> <p>Note that if <code>CompleteMultipartUpload</code> fails, applications should be prepared to retry the failed requests. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/ErrorBestPractices.html\">Amazon S3 Error Best Practices</a>.</p> <p>For more information about multipart uploads, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/uploadobjusingmpu.html\">Uploading Objects Using Multipart Upload</a>.</p> <p>For information about permissions required to use the multipart upload API, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuAndPermissions.html\">Multipart Upload API and Permissions</a>.</p> <p> <code>GetBucketLifecycle</code> has the following special errors:</p> <ul> <li> <p>Error code: <code>EntityTooSmall</code> </p> <ul> <li> <p>Description: Your proposed upload is smaller than the minimum allowed object size. Each part must be at least 5 MB in size, except the last part.</p> </li> <li> <p>400 Bad Request</p> </li> </ul> </li> <li> <p>Error code: <code>InvalidPart</code> </p> <ul> <li> <p>Description: One or more of the specified parts could not be found. The part might not have been uploaded, or the specified entity tag might not have matched the part's entity tag.</p> </li> <li> <p>400 Bad Request</p> </li> </ul> </li> <li> <p>Error code: <code>InvalidPartOrder</code> </p> <ul> <li> <p>Description: The list of parts was not in ascending order. The parts list must be specified in order by part number.</p> </li> <li> <p>400 Bad Request</p> </li> </ul> </li> <li> <p>Error code: <code>NoSuchUpload</code> </p> <ul> <li> <p>Description: The specified multipart upload does not exist. The upload ID might be invalid, or the multipart upload might have been aborted or completed.</p> </li> <li> <p>404 Not Found</p> </li> </ul> </li> </ul> <p>The following operations are related to <code>DeleteBucketMetricsConfiguration</code>:</p> <ul> <li> <p> <a>CreateMultipartUpload</a> </p> </li> <li> <p> <a>UploadPart</a> </p> </li> <li> <p> <a>AbortMultipartUpload</a> </p> </li> <li> <p> <a>ListParts</a> </p> </li> <li> <p> <a>ListMultipartUploads</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CompleteMultipartUploadRequest :
sig
  type t =
    {
    bucket: String.t ;
    key: String.t ;
    multipart_upload: CompletedMultipartUpload.t option ;
    upload_id: String.t ;
    request_payer: RequestPayer.t option }
  val make :
    bucket:String.t ->
      key:String.t ->
        ?multipart_upload:CompletedMultipartUpload.t ->
          upload_id:String.t -> ?request_payer:RequestPayer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CompleteMultipartUploadOutput = CompleteMultipartUploadOutput
type input = CompleteMultipartUploadRequest.t
type output = CompleteMultipartUploadOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error