(** "<p>This operation enables you to delete multiple objects from a bucket using a single HTTP request. If you know the object keys that you want to delete, then this operation provides a suitable alternative to sending individual delete requests, reducing per-request overhead.</p> <p>The request contains a list of up to 1000 keys that you want to delete. In the XML, you provide the object key names, and optionally, version IDs if you want to delete a specific version of the object from a versioning-enabled bucket. For each key, Amazon S3 performs a delete operation and returns the result of that delete, success, or failure, in the response. Note that if the object specified in the request is not found, Amazon S3 returns the result as deleted.</p> <p> The operation supports two modes for the response: verbose and quiet. By default, the operation uses verbose mode in which the response includes the result of deletion of each key in your request. In quiet mode the response includes only keys where the delete operation encountered an error. For a successful deletion, the operation does not return any information about the delete in the response body.</p> <p>When performing this operation on an MFA Delete enabled bucket, that attempts to delete any versioned objects, you must include an MFA token. If you do not provide one, the entire request will fail, even if there are non-versioned objects you are trying to delete. If you provide an invalid token, whether there are versioned keys in the request or not, the entire Multi-Object Delete request will fail. For information about MFA Delete, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/Versioning.html#MultiFactorAuthenticationDelete\"> MFA Delete</a>.</p> <p>Finally, the Content-MD5 header is required for all Multi-Object Delete requests. Amazon S3 uses the header value to ensure that your request body has not been altered in transit.</p> <p>The following operations are related to <code>DeleteObjects</code>:</p> <ul> <li> <p> <a>CreateMultipartUpload</a> </p> </li> <li> <p> <a>UploadPart</a> </p> </li> <li> <p> <a>CompleteMultipartUpload</a> </p> </li> <li> <p> <a>ListParts</a> </p> </li> <li> <p> <a>AbortMultipartUpload</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteObjectsRequest :
sig
  type t =
    {
    bucket: String.t ;
    delete: Delete.t ;
    m_f_a: String.t option ;
    request_payer: RequestPayer.t option ;
    bypass_governance_retention: Boolean.t option }
  val make :
    bucket:String.t ->
      delete:Delete.t ->
        ?m_f_a:String.t ->
          ?request_payer:RequestPayer.t ->
            ?bypass_governance_retention:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DeleteObjectsOutput = DeleteObjectsOutput
type input = DeleteObjectsRequest.t
type output = DeleteObjectsOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error