(** "<p>Sets the permissions on an existing bucket using access control lists (ACL). For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3_ACLs_UsingACLs.html\">Using ACLs</a>. To set the ACL of a bucket, you must have <code>WRITE_ACP</code> permission.</p> <p>You can use one of the following two ways to set a bucket's permissions:</p> <ul> <li> <p>Specify the ACL in the request body</p> </li> <li> <p>Specify permissions using request headers</p> </li> </ul> <note> <p>You cannot specify access permission using both the body and the request headers.</p> </note> <p>Depending on your application needs, you may choose to set the ACL on a bucket using either the request body or the headers. For example, if you have an existing application that updates a bucket ACL using the request body, then you can continue to use that approach.</p> <p> <b>Access Permissions</b> </p> <p>You can set access permissions using one of the following methods:</p> <ul> <li> <p>Specify a canned ACL with the <code>x-amz-acl</code> request header. Amazon S3 supports a set of predefined ACLs, known as <i>canned ACLs</i>. Each canned ACL has a predefined set of grantees and permissions. Specify the canned ACL name as the value of <code>x-amz-acl</code>. If you use this header, you cannot use other access control-specific headers in your request. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#CannedACL\">Canned ACL</a>.</p> </li> <li> <p>Specify access permissions explicitly with the <code>x-amz-grant-read</code>, <code>x-amz-grant-read-acp</code>, <code>x-amz-grant-write-acp</code>, and <code>x-amz-grant-full-control</code> headers. When using these headers, you specify explicit access permissions and grantees (AWS accounts or Amazon S3 groups) who will receive the permission. If you use these ACL-specific headers, you cannot use the <code>x-amz-acl</code> header to set a canned ACL. These parameters map to the set of permissions that Amazon S3 supports in an ACL. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html\">Access Control List (ACL) Overview</a>.</p> <p>You specify each grantee as a type=value pair, where the type is one of the following:</p> <ul> <li> <p> <code>emailAddress</code> \226\128\147 if the value specified is the email address of an AWS account</p> </li> <li> <p> <code>id</code> \226\128\147 if the value specified is the canonical user ID of an AWS account</p> </li> <li> <p> <code>uri</code> \226\128\147 if you are granting permissions to a predefined group</p> </li> </ul> <p>For example, the following <code>x-amz-grant-write</code> header grants create, overwrite, and delete objects permission to LogDelivery group predefined by Amazon S3 and two AWS accounts identified by their email addresses.</p> <p> <code>x-amz-grant-write: uri=\"http://acs.amazonaws.com/groups/s3/LogDelivery\", emailAddress=\"xyz@amazon.com\", emailAddress=\"abc@amazon.com\" </code> </p> </li> </ul> <p>You can use either a canned ACL or specify access permissions explicitly. You cannot do both.</p> <p> <b>Grantee Values</b> </p> <p>You can specify the person (grantee) to whom you're assigning access rights (using request elements) in the following ways:</p> <ul> <li> <p>By Email address:</p> <p> <code>&lt;Grantee xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:type=\"AmazonCustomerByEmail\"&gt;&lt;EmailAddress&gt;&lt;&gt;Grantees@email.com&lt;&gt;&lt;/EmailAddress&gt;lt;/Grantee&gt;</code> </p> <p>The grantee is resolved to the CanonicalUser and, in a response to a GET Object acl request, appears as the CanonicalUser.</p> </li> <li> <p>By the person's ID:</p> <p> <code>&lt;Grantee xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:type=\"CanonicalUser\"&gt;&lt;ID&gt;&lt;&gt;ID&lt;&gt;&lt;/ID&gt;&lt;DisplayName&gt;&lt;&gt;GranteesEmail&lt;&gt;&lt;/DisplayName&gt; &lt;/Grantee&gt;</code> </p> <p>DisplayName is optional and ignored in the request</p> </li> <li> <p>By URI:</p> <p> <code>&lt;Grantee xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:type=\"Group\"&gt;&lt;URI&gt;&lt;&gt;http://acs.amazonaws.com/groups/global/AuthenticatedUsers&lt;&gt;&lt;/URI&gt;&lt;/Grantee&gt;</code> </p> </li> </ul> <p class=\"title\"> <b>Related Resources</b> </p> <ul> <li> <p> <a>CreateBucket</a> </p> </li> <li> <p> <a>DeleteBucket</a> </p> </li> <li> <p> <a>GetObjectAcl</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PutBucketAclRequest :
sig
  type t =
    {
    a_c_l: BucketCannedACL.t option ;
    access_control_policy: AccessControlPolicy.t option ;
    bucket: String.t ;
    content_m_d5: String.t option ;
    grant_full_control: String.t option ;
    grant_read: String.t option ;
    grant_read_a_c_p: String.t option ;
    grant_write: String.t option ;
    grant_write_a_c_p: String.t option }
  val make :
    ?a_c_l:BucketCannedACL.t ->
      ?access_control_policy:AccessControlPolicy.t ->
        bucket:String.t ->
          ?content_m_d5:String.t ->
            ?grant_full_control:String.t ->
              ?grant_read:String.t ->
                ?grant_read_a_c_p:String.t ->
                  ?grant_write:String.t ->
                    ?grant_write_a_c_p:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = PutBucketAclRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error