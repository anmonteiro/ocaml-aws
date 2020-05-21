(** "<p>Retrieves objects from Amazon S3. To use <code>GET</code>, you must have <code>READ</code> access to the object. If you grant <code>READ</code> access to the anonymous user, you can return the object without using an authorization header.</p> <p>An Amazon S3 bucket has no directory hierarchy such as you would find in a typical computer file system. You can, however, create a logical hierarchy by using object key names that imply a folder structure. For example, instead of naming an object <code>sample.jpg</code>, you can name it <code>photos/2006/February/sample.jpg</code>.</p> <p>To get an object from such a logical hierarchy, specify the full key name for the object in the <code>GET</code> operation. For a virtual hosted-style request example, if you have the object <code>photos/2006/February/sample.jpg</code>, specify the resource as <code>/photos/2006/February/sample.jpg</code>. For a path-style request example, if you have the object <code>photos/2006/February/sample.jpg</code> in the bucket named <code>examplebucket</code>, specify the resource as <code>/examplebucket/photos/2006/February/sample.jpg</code>. For more information about request types, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/VirtualHosting.html#VirtualHostingSpecifyBucket\">HTTP Host Header Bucket Specification</a>.</p> <p>To distribute large files to many people, you can save bandwidth costs by using BitTorrent. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3Torrent.html\">Amazon S3 Torrent</a>. For more information about returning the ACL of an object, see <a>GetObjectAcl</a>.</p> <p>If the object you are retrieving is stored in the GLACIER or DEEP_ARCHIVE storage classes, before you can retrieve the object you must first restore a copy using . Otherwise, this operation returns an <code>InvalidObjectStateError</code> error. For information about restoring archived objects, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/restoring-objects.html\">Restoring Archived Objects</a>.</p> <p>Encryption request headers, like <code>x-amz-server-side-encryption</code>, should not be sent for GET requests if your object uses server-side encryption with CMKs stored in AWS KMS (SSE-KMS) or server-side encryption with Amazon S3\226\128\147managed encryption keys (SSE-S3). If your object does use these types of keys, you\226\128\153ll get an HTTP 400 BadRequest error.</p> <p>If you encrypt an object by using server-side encryption with customer-provided encryption keys (SSE-C) when you store the object in Amazon S3, then when you GET the object, you must use the following headers:</p> <ul> <li> <p>x-amz-server-side\226\128\139-encryption\226\128\139-customer-algorithm</p> </li> <li> <p>x-amz-server-side\226\128\139-encryption\226\128\139-customer-key</p> </li> <li> <p>x-amz-server-side\226\128\139-encryption\226\128\139-customer-key-MD5</p> </li> </ul> <p>For more information about SSE-C, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html\">Server-Side Encryption (Using Customer-Provided Encryption Keys)</a>.</p> <p>Assuming you have permission to read object tags (permission for the <code>s3:GetObjectVersionTagging</code> action), the response also returns the <code>x-amz-tagging-count</code> header that provides the count of number of tags associated with the object. You can use <a>GetObjectTagging</a> to retrieve the tag set associated with an object.</p> <p> <b>Permissions</b> </p> <p>You need the <code>s3:GetObject</code> permission for this operation. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html\">Specifying Permissions in a Policy</a>. If the object you request does not exist, the error Amazon S3 returns depends on whether you also have the <code>s3:ListBucket</code> permission.</p> <ul> <li> <p>If you have the <code>s3:ListBucket</code> permission on the bucket, Amazon S3 will return an HTTP status code 404 (\"no such key\") error.</p> </li> <li> <p>If you don\226\128\153t have the <code>s3:ListBucket</code> permission, Amazon S3 will return an HTTP status code 403 (\"access denied\") error.</p> </li> </ul> <p> <b>Versioning</b> </p> <p>By default, the GET operation returns the current version of an object. To return a different version, use the <code>versionId</code> subresource.</p> <note> <p>If the current version of the object is a delete marker, Amazon S3 behaves as if the object was deleted and includes <code>x-amz-delete-marker: true</code> in the response.</p> </note> <p>For more information about versioning, see <a>PutBucketVersioning</a>. </p> <p> <b>Overriding Response Header Values</b> </p> <p>There are times when you want to override certain response header values in a GET response. For example, you might override the Content-Disposition response header value in your GET request.</p> <p>You can override values for a set of response headers using the following query parameters. These response header values are sent only on a successful request, that is, when status code 200 OK is returned. The set of headers you can override using these parameters is a subset of the headers that Amazon S3 accepts when you create an object. The response headers that you can override for the GET response are <code>Content-Type</code>, <code>Content-Language</code>, <code>Expires</code>, <code>Cache-Control</code>, <code>Content-Disposition</code>, and <code>Content-Encoding</code>. To override these header values in the GET response, you use the following request parameters.</p> <note> <p>You must sign the request, either using an Authorization header or a presigned URL, when using these parameters. They cannot be used with an unsigned (anonymous) request.</p> </note> <ul> <li> <p> <code>response-content-type</code> </p> </li> <li> <p> <code>response-content-language</code> </p> </li> <li> <p> <code>response-expires</code> </p> </li> <li> <p> <code>response-cache-control</code> </p> </li> <li> <p> <code>response-content-disposition</code> </p> </li> <li> <p> <code>response-content-encoding</code> </p> </li> </ul> <p> <b>Additional Considerations about Request Headers</b> </p> <p>If both of the <code>If-Match</code> and <code>If-Unmodified-Since</code> headers are present in the request as follows: <code>If-Match</code> condition evaluates to <code>true</code>, and; <code>If-Unmodified-Since</code> condition evaluates to <code>false</code>; then, S3 returns 200 OK and the data requested. </p> <p>If both of the <code>If-None-Match</code> and <code>If-Modified-Since</code> headers are present in the request as follows:<code> If-None-Match</code> condition evaluates to <code>false</code>, and; <code>If-Modified-Since</code> condition evaluates to <code>true</code>; then, S3 returns 304 Not Modified response code.</p> <p>For more information about conditional requests, see <a href=\"https://tools.ietf.org/html/rfc7232\">RFC 7232</a>.</p> <p>The following operations are related to <code>GetObject</code>:</p> <ul> <li> <p> <a>ListBuckets</a> </p> </li> <li> <p> <a>GetObjectAcl</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetObjectRequest :
sig
  type t =
    {
    bucket: String.t ;
    if_match: String.t option ;
    if_modified_since: DateTime.t option ;
    if_none_match: String.t option ;
    if_unmodified_since: DateTime.t option ;
    key: String.t ;
    range: String.t option ;
    response_cache_control: String.t option ;
    response_content_disposition: String.t option ;
    response_content_encoding: String.t option ;
    response_content_language: String.t option ;
    response_content_type: String.t option ;
    response_expires: DateTime.t option ;
    version_id: String.t option ;
    s_s_e_customer_algorithm: String.t option ;
    s_s_e_customer_key: String.t option ;
    s_s_e_customer_key_m_d5: String.t option ;
    request_payer: RequestPayer.t option ;
    part_number: Integer.t option }
  val make :
    bucket:String.t ->
      ?if_match:String.t ->
        ?if_modified_since:DateTime.t ->
          ?if_none_match:String.t ->
            ?if_unmodified_since:DateTime.t ->
              key:String.t ->
                ?range:String.t ->
                  ?response_cache_control:String.t ->
                    ?response_content_disposition:String.t ->
                      ?response_content_encoding:String.t ->
                        ?response_content_language:String.t ->
                          ?response_content_type:String.t ->
                            ?response_expires:DateTime.t ->
                              ?version_id:String.t ->
                                ?s_s_e_customer_algorithm:String.t ->
                                  ?s_s_e_customer_key:String.t ->
                                    ?s_s_e_customer_key_m_d5:String.t ->
                                      ?request_payer:RequestPayer.t ->
                                        ?part_number:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module GetObjectOutput = GetObjectOutput
type input = GetObjectRequest.t
type output = (GetObjectOutput.t * Piaf.Body.t)
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error