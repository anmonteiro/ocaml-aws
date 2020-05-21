(** "<p>Set the logging parameters for a bucket and to specify permissions for who can view and modify the logging parameters. All logs are saved to buckets in the same AWS Region as the source bucket. To set the logging status of a bucket, you must be the bucket owner.</p> <p>The bucket owner is automatically granted FULL_CONTROL to all logs. You use the <code>Grantee</code> request element to grant access to other people. The <code>Permissions</code> request element specifies the kind of access the grantee has to the logs.</p> <p> <b>Grantee Values</b> </p> <p>You can specify the person (grantee) to whom you're assigning access rights (using request elements) in the following ways:</p> <ul> <li> <p>By the person's ID:</p> <p> <code>&lt;Grantee xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:type=\"CanonicalUser\"&gt;&lt;ID&gt;&lt;&gt;ID&lt;&gt;&lt;/ID&gt;&lt;DisplayName&gt;&lt;&gt;GranteesEmail&lt;&gt;&lt;/DisplayName&gt; &lt;/Grantee&gt;</code> </p> <p>DisplayName is optional and ignored in the request.</p> </li> <li> <p>By Email address:</p> <p> <code> &lt;Grantee xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:type=\"AmazonCustomerByEmail\"&gt;&lt;EmailAddress&gt;&lt;&gt;Grantees@email.com&lt;&gt;&lt;/EmailAddress&gt;&lt;/Grantee&gt;</code> </p> <p>The grantee is resolved to the CanonicalUser and, in a response to a GET Object acl request, appears as the CanonicalUser.</p> </li> <li> <p>By URI:</p> <p> <code>&lt;Grantee xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:type=\"Group\"&gt;&lt;URI&gt;&lt;&gt;http://acs.amazonaws.com/groups/global/AuthenticatedUsers&lt;&gt;&lt;/URI&gt;&lt;/Grantee&gt;</code> </p> </li> </ul> <p>To enable logging, you use LoggingEnabled and its children request elements. To disable logging, you use an empty BucketLoggingStatus request element:</p> <p> <code>&lt;BucketLoggingStatus xmlns=\"http://doc.s3.amazonaws.com/2006-03-01\" /&gt;</code> </p> <p>For more information about server access logging, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerLogs.html\">Server Access Logging</a>. </p> <p>For more information about creating a bucket, see <a>CreateBucket</a>. For more information about returning the logging status of a bucket, see <a>GetBucketLogging</a>.</p> <p>The following operations are related to <code>PutBucketLogging</code>:</p> <ul> <li> <p> <a>PutObject</a> </p> </li> <li> <p> <a>DeleteBucket</a> </p> </li> <li> <p> <a>CreateBucket</a> </p> </li> <li> <p> <a>GetBucketLogging</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PutBucketLoggingRequest :
sig
  type t =
    {
    bucket: String.t ;
    bucket_logging_status: BucketLoggingStatus.t ;
    content_m_d5: String.t option }
  val make :
    bucket:String.t ->
      bucket_logging_status:BucketLoggingStatus.t ->
        ?content_m_d5:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = PutBucketLoggingRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error