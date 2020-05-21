(** "<p>This operation aborts a multipart upload. After a multipart upload is aborted, no additional parts can be uploaded using that upload ID. The storage consumed by any previously uploaded parts will be freed. However, if any part uploads are currently in progress, those part uploads might or might not succeed. As a result, it might be necessary to abort a given multipart upload multiple times in order to completely free all storage consumed by all parts. </p> <p>To verify that all parts have been removed, so you don't get charged for the part storage, you should call the <a>ListParts</a> operation and ensure that the parts list is empty.</p> <p>For information about permissions required to use the multipart upload API, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuAndPermissions.html\">Multipart Upload API and Permissions</a>.</p> <p>The following operations are related to <code>AbortMultipartUpload</code>:</p> <ul> <li> <p> <a>CreateMultipartUpload</a> </p> </li> <li> <p> <a>UploadPart</a> </p> </li> <li> <p> <a>CompleteMultipartUpload</a> </p> </li> <li> <p> <a>ListParts</a> </p> </li> <li> <p> <a>ListMultipartUploads</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AbortMultipartUploadRequest :
sig
  type t =
    {
    bucket: String.t ;
    key: String.t ;
    upload_id: String.t ;
    request_payer: RequestPayer.t option }
  val make :
    bucket:String.t ->
      key:String.t ->
        upload_id:String.t -> ?request_payer:RequestPayer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module AbortMultipartUploadOutput = AbortMultipartUploadOutput
type input = AbortMultipartUploadRequest.t
type output = AbortMultipartUploadOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error