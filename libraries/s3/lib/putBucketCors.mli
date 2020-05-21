(** "<p>Sets the <code>cors</code> configuration for your bucket. If the configuration exists, Amazon S3 replaces it.</p> <p>To use this operation, you must be allowed to perform the <code>s3:PutBucketCORS</code> action. By default, the bucket owner has this permission and can grant it to others.</p> <p>You set this configuration on a bucket so that the bucket can service cross-origin requests. For example, you might want to enable a request whose origin is <code>http://www.example.com</code> to access your Amazon S3 bucket at <code>my.example.bucket.com</code> by using the browser's <code>XMLHttpRequest</code> capability.</p> <p>To enable cross-origin resource sharing (CORS) on a bucket, you add the <code>cors</code> subresource to the bucket. The <code>cors</code> subresource is an XML document in which you configure rules that identify origins and the HTTP methods that can be executed on your bucket. The document is limited to 64 KB in size. </p> <p>When Amazon S3 receives a cross-origin request (or a pre-flight OPTIONS request) against a bucket, it evaluates the <code>cors</code> configuration on the bucket and uses the first <code>CORSRule</code> rule that matches the incoming browser request to enable a cross-origin request. For a rule to match, the following conditions must be met:</p> <ul> <li> <p>The request's <code>Origin</code> header must match <code>AllowedOrigin</code> elements.</p> </li> <li> <p>The request method (for example, GET, PUT, HEAD, and so on) or the <code>Access-Control-Request-Method</code> header in case of a pre-flight <code>OPTIONS</code> request must be one of the <code>AllowedMethod</code> elements. </p> </li> <li> <p>Every header specified in the <code>Access-Control-Request-Headers</code> request header of a pre-flight request must match an <code>AllowedHeader</code> element. </p> </li> </ul> <p> For more information about CORS, go to <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/cors.html\">Enabling Cross-Origin Resource Sharing</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p class=\"title\"> <b>Related Resources</b> </p> <ul> <li> <p> <a>GetBucketCors</a> </p> </li> <li> <p> <a>DeleteBucketCors</a> </p> </li> <li> <p> <a>RESTOPTIONSobject</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PutBucketCorsRequest :
sig
  type t =
    {
    bucket: String.t ;
    c_o_r_s_configuration: CORSConfiguration.t ;
    content_m_d5: String.t option }
  val make :
    bucket:String.t ->
      c_o_r_s_configuration:CORSConfiguration.t ->
        ?content_m_d5:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = PutBucketCorsRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error