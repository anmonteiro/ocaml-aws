(** "<p>Creates a new bucket. To create a bucket, you must register with Amazon S3 and have a valid AWS Access Key ID to authenticate requests. Anonymous requests are never allowed to create buckets. By creating the bucket, you become the bucket owner.</p> <p>Not every string is an acceptable bucket name. For information on bucket naming restrictions, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html\">Working with Amazon S3 Buckets</a>.</p> <p>By default, the bucket is created in the US East (N. Virginia) Region. You can optionally specify a Region in the request body. You might choose a Region to optimize latency, minimize costs, or address regulatory requirements. For example, if you reside in Europe, you will probably find it advantageous to create buckets in the EU (Ireland) Region. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html#access-bucket-intro\">How to Select a Region for Your Buckets</a>.</p> <note> <p>If you send your create bucket request to the <code>s3.amazonaws.com</code> endpoint, the request goes to the us-east-1 Region. Accordingly, the signature calculations in Signature Version 4 must use us-east-1 as the Region, even if the location constraint in the request specifies another Region where the bucket is to be created. If you create a bucket in a Region other than US East (N. Virginia), your application must be able to handle 307 redirect. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/VirtualHosting.html\">Virtual Hosting of Buckets</a>.</p> </note> <p>When creating a bucket using this operation, you can optionally specify the accounts or groups that should be granted specific permissions on the bucket. There are two ways to grant the appropriate permissions using the request headers.</p> <ul> <li> <p>Specify a canned ACL using the <code>x-amz-acl</code> request header. Amazon S3 supports a set of predefined ACLs, known as <i>canned ACLs</i>. Each canned ACL has a predefined set of grantees and permissions. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#CannedACL\">Canned ACL</a>.</p> </li> <li> <p>Specify access permissions explicitly using the <code>x-amz-grant-read</code>, <code>x-amz-grant-write</code>, <code>x-amz-grant-read-acp</code>, <code>x-amz-grant-write-acp</code>, and <code>x-amz-grant-full-control</code> headers. These headers map to the set of permissions Amazon S3 supports in an ACL. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html\">Access Control List (ACL) Overview</a>.</p> <p>You specify each grantee as a type=value pair, where the type is one of the following:</p> <ul> <li> <p> <code>emailAddress</code> \226\128\147 if the value specified is the email address of an AWS account</p> </li> <li> <p> <code>id</code> \226\128\147 if the value specified is the canonical user ID of an AWS account</p> </li> <li> <p> <code>uri</code> \226\128\147 if you are granting permissions to a predefined group</p> </li> </ul> <p>For example, the following <code>x-amz-grant-read</code> header grants the AWS accounts identified by email addresses permissions to read object data and its metadata:</p> <p> <code>x-amz-grant-read: emailAddress=\"xyz@amazon.com\", emailAddress=\"abc@amazon.com\" </code> </p> </li> </ul> <note> <p>You can use either a canned ACL or specify access permissions explicitly. You cannot do both.</p> </note> <p>The following operations are related to <code>CreateBucket</code>:</p> <ul> <li> <p> <a>PutObject</a> </p> </li> <li> <p> <a>DeleteBucket</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateBucketRequest :
sig
  type t =
    {
    a_c_l: BucketCannedACL.t option ;
    bucket: String.t ;
    create_bucket_configuration: CreateBucketConfiguration.t option ;
    grant_full_control: String.t option ;
    grant_read: String.t option ;
    grant_read_a_c_p: String.t option ;
    grant_write: String.t option ;
    grant_write_a_c_p: String.t option ;
    object_lock_enabled_for_bucket: Boolean.t option }
  val make :
    ?a_c_l:BucketCannedACL.t ->
      bucket:String.t ->
        ?create_bucket_configuration:CreateBucketConfiguration.t ->
          ?grant_full_control:String.t ->
            ?grant_read:String.t ->
              ?grant_read_a_c_p:String.t ->
                ?grant_write:String.t ->
                  ?grant_write_a_c_p:String.t ->
                    ?object_lock_enabled_for_bucket:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateBucketOutput = CreateBucketOutput
type input = CreateBucketRequest.t
type output = CreateBucketOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error