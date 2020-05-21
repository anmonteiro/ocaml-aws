(** "<p>This operation filters the contents of an Amazon S3 object based on a simple structured query language (SQL) statement. In the request, along with the SQL expression, you must also specify a data serialization format (JSON, CSV, or Apache Parquet) of the object. Amazon S3 uses this format to parse object data into records, and returns only records that match the specified SQL expression. You must also specify the data serialization format for the response.</p> <p>For more information about Amazon S3 Select, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/selecting-content-from-objects.html\">Selecting Content from Objects</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>For more information about using SQL with Amazon S3 Select, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-glacier-select-sql-reference.html\"> SQL Reference for Amazon S3 Select and Glacier Select</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p/> <p> <b>Permissions</b> </p> <p>You must have <code>s3:GetObject</code> permission for this operation.\194\160Amazon S3 Select does not support anonymous access. For more information about permissions, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html\">Specifying Permissions in a Policy</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p/> <p> <i>Object Data Formats</i> </p> <p>You can use Amazon S3 Select to query objects that have the following format properties:</p> <ul> <li> <p> <i>CSV, JSON, and Parquet</i> - Objects must be in CSV, JSON, or Parquet format.</p> </li> <li> <p> <i>UTF-8</i> - UTF-8 is the only encoding type Amazon S3 Select supports.</p> </li> <li> <p> <i>GZIP or BZIP2</i> - CSV and JSON files can be compressed using GZIP or BZIP2. GZIP and BZIP2 are the only compression formats that Amazon S3 Select supports for CSV and JSON files. Amazon S3 Select supports columnar compression for Parquet using GZIP or Snappy. Amazon S3 Select does not support whole-object compression for Parquet objects.</p> </li> <li> <p> <i>Server-side encryption</i> - Amazon S3 Select supports querying objects that are protected with server-side encryption.</p> <p>For objects that are encrypted with customer-provided encryption keys (SSE-C), you must use HTTPS, and you must use the headers that are documented in the <a>GetObject</a>. For more information about SSE-C, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html\">Server-Side Encryption (Using Customer-Provided Encryption Keys)</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>For objects that are encrypted with Amazon S3 managed encryption keys (SSE-S3) and customer master keys (CMKs) stored in AWS Key Management Service (SSE-KMS), server-side encryption is handled transparently, so you don't need to specify anything. For more information about server-side encryption, including SSE-S3 and SSE-KMS, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/serv-side-encryption.html\">Protecting Data Using Server-Side Encryption</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> </li> </ul> <p> <b>Working with the Response Body</b> </p> <p>Given the response size is unknown, Amazon S3 Select streams the response as a series of messages and includes a <code>Transfer-Encoding</code> header with <code>chunked</code> as its value in the response. For more information, see <a>RESTSelectObjectAppendix</a> .</p> <p/> <p> <b>GetObject Support</b> </p> <p>The <code>SelectObjectContent</code> operation does not support the following <code>GetObject</code> functionality. For more information, see <a>GetObject</a>.</p> <ul> <li> <p> <code>Range</code>: While you can specify a scan range for a Amazon S3 Select request, see <a>SelectObjectContentRequest$ScanRange</a> in the request parameters below, you cannot specify the range of bytes of an object to return. </p> </li> <li> <p>GLACIER, DEEP_ARCHIVE and REDUCED_REDUNDANCY storage classes: You cannot specify the GLACIER, DEEP_ARCHIVE, or <code>REDUCED_REDUNDANCY</code> storage classes. For more information, about storage classes see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingMetadata.html#storage-class-intro\">Storage Classes</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> </li> </ul> <p/> <p> <b>Special Errors</b> </p> <p>For a list of special errors for this operation and for general information about Amazon S3 errors and a list of error codes, see <a>ErrorResponses</a> </p> <p class=\"title\"> <b>Related Resources</b> </p> <ul> <li> <p> <a>GetObject</a> </p> </li> <li> <p> <a>GetBucketLifecycleConfiguration</a> </p> </li> <li> <p> <a>PutBucketLifecycleConfiguration</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module SelectObjectContentRequest :
sig
  type t =
    {
    bucket: String.t ;
    key: String.t ;
    s_s_e_customer_algorithm: String.t option ;
    s_s_e_customer_key: String.t option ;
    s_s_e_customer_key_m_d5: String.t option ;
    expression: String.t ;
    expression_type: ExpressionType.t ;
    request_progress: RequestProgress.t option ;
    input_serialization: InputSerialization.t ;
    output_serialization: OutputSerialization.t ;
    scan_range: ScanRange.t option }[@@ocaml.doc
                                      "<p>Request to filter the contents of an Amazon S3 object based on a simple Structured Query Language (SQL) statement. In the request, along with the SQL expression, you must specify a data serialization format (JSON or CSV) of the object. Amazon S3 uses this to parse object data into records. It returns only records that match the specified SQL expression. You must also specify the data serialization format for the response. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html\">S3Select API Documentation</a>.</p>"]
  val make :
    bucket:String.t ->
      key:String.t ->
        ?s_s_e_customer_algorithm:String.t ->
          ?s_s_e_customer_key:String.t ->
            ?s_s_e_customer_key_m_d5:String.t ->
              expression:String.t ->
                expression_type:ExpressionType.t ->
                  ?request_progress:RequestProgress.t ->
                    input_serialization:InputSerialization.t ->
                      output_serialization:OutputSerialization.t ->
                        ?scan_range:ScanRange.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module SelectObjectContentOutput = SelectObjectContentOutput
type input = SelectObjectContentRequest.t
type output = SelectObjectContentOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error