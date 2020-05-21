(** "<p>This operation lists in-progress multipart uploads. An in-progress multipart upload is a multipart upload that has been initiated using the Initiate Multipart Upload request, but has not yet been completed or aborted.</p> <p>This operation returns at most 1,000 multipart uploads in the response. 1,000 multipart uploads is the maximum number of uploads a response can include, which is also the default value. You can further limit the number of uploads in a response by specifying the <code>max-uploads</code> parameter in the response. If additional multipart uploads satisfy the list criteria, the response will contain an <code>IsTruncated</code> element with the value true. To list the additional multipart uploads, use the <code>key-marker</code> and <code>upload-id-marker</code> request parameters.</p> <p>In the response, the uploads are sorted by key. If your application has initiated more than one multipart upload using the same object key, then uploads in the response are first sorted by key. Additionally, uploads are sorted in ascending order within each key by the upload initiation time.</p> <p>For more information on multipart uploads, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/uploadobjusingmpu.html\">Uploading Objects Using Multipart Upload</a>.</p> <p>For information on permissions required to use the multipart upload API, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuAndPermissions.html\">Multipart Upload API and Permissions</a>.</p> <p>The following operations are related to <code>ListMultipartUploads</code>:</p> <ul> <li> <p> <a>CreateMultipartUpload</a> </p> </li> <li> <p> <a>UploadPart</a> </p> </li> <li> <p> <a>CompleteMultipartUpload</a> </p> </li> <li> <p> <a>ListParts</a> </p> </li> <li> <p> <a>AbortMultipartUpload</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListMultipartUploadsRequest :
sig
  type t =
    {
    bucket: String.t ;
    delimiter: String.t option ;
    encoding_type: EncodingType.t option ;
    key_marker: String.t option ;
    max_uploads: Integer.t option ;
    prefix: String.t option ;
    upload_id_marker: String.t option }
  val make :
    bucket:String.t ->
      ?delimiter:String.t ->
        ?encoding_type:EncodingType.t ->
          ?key_marker:String.t ->
            ?max_uploads:Integer.t ->
              ?prefix:String.t -> ?upload_id_marker:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ListMultipartUploadsOutput = ListMultipartUploadsOutput
type input = ListMultipartUploadsRequest.t
type output = ListMultipartUploadsOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error