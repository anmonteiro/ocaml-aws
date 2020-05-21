(** "<p>Adds an object to a bucket. You must have WRITE permissions on a bucket to add an object to it.</p> <p>Amazon S3 never adds partial objects; if you receive a success response, Amazon S3 added the entire object to the bucket.</p> <p>Amazon S3 is a distributed system. If it receives multiple write requests for the same object simultaneously, it overwrites all but the last object written. Amazon S3 does not provide object locking; if you need this, make sure to build it into your application layer or use versioning instead.</p> <p>To ensure that data is not corrupted traversing the network, use the <code>Content-MD5</code> header. When you use this header, Amazon S3 checks the object against the provided MD5 value and, if they do not match, returns an error. Additionally, you can calculate the MD5 while putting an object to Amazon S3 and compare the returned ETag to the calculated MD5 value.</p> <note> <p>To configure your application to send the request headers before sending the request body, use the <code>100-continue</code> HTTP status code. For PUT operations, this helps you avoid sending the message body if the message is rejected based on the headers (for example, because authentication fails or a redirect occurs). For more information on the <code>100-continue</code> HTTP status code, see Section 8.2.3 of <a href=\"http://www.ietf.org/rfc/rfc2616.txt\">http://www.ietf.org/rfc/rfc2616.txt</a>.</p> </note> <p>You can optionally request server-side encryption. With server-side encryption, Amazon S3 encrypts your data as it writes it to disks in its data centers and decrypts the data when you access it. You have the option to provide your own encryption key or use AWS managed encryption keys. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingServerSideEncryption.html\">Using Server-Side Encryption</a>.</p> <dl> <dt>Access Permissions</dt> <dd> <p>You can optionally specify the accounts or groups that should be granted specific permissions on the new object. There are two ways to grant the permissions using the request headers:</p> <ul> <li> <p>Specify a canned ACL with the <code>x-amz-acl</code> request header. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#CannedACL\">Canned ACL</a>.</p> </li> <li> <p>Specify access permissions explicitly with the <code>x-amz-grant-read</code>, <code>x-amz-grant-read-acp</code>, <code>x-amz-grant-write-acp</code>, and <code>x-amz-grant-full-control</code> headers. These parameters map to the set of permissions that Amazon S3 supports in an ACL. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html\">Access Control List (ACL) Overview</a>.</p> </li> </ul> <p>You can use either a canned ACL or specify access permissions explicitly. You cannot do both.</p> </dd> <dt>Server-Side- Encryption-Specific Request Headers</dt> <dd> <p>You can optionally tell Amazon S3 to encrypt data at rest using server-side encryption. Server-side encryption is for data encryption at rest. Amazon S3 encrypts your data as it writes it to disks in its data centers and decrypts it when you access it. The option you use depends on whether you want to use AWS managed encryption keys or provide your own encryption key. </p> <ul> <li> <p>Use encryption keys managed by Amazon S3 or customer master keys (CMKs) stored in AWS Key Management Service (AWS KMS) \226\128\147 If you want AWS to manage the keys used to encrypt data, specify the following headers in the request.</p> <ul> <li> <p>x-amz-server-side\226\128\139-encryption</p> </li> <li> <p>x-amz-server-side-encryption-aws-kms-key-id</p> </li> <li> <p>x-amz-server-side-encryption-context</p> </li> </ul> <note> <p>If you specify <code>x-amz-server-side-encryption:aws:kms</code>, but don't provide <code>x-amz-server-side-encryption-aws-kms-key-id</code>, Amazon S3 uses the AWS managed CMK in AWS KMS to protect the data. If you want to use a customer managed AWS KMS CMK, you must provide the <code>x-amz-server-side-encryption-aws-kms-key-id</code> of the symmetric customer managed CMK. Amazon S3 only supports symmetric CMKs and not asymmetric CMKs. For more information, see <a href=\"https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html\">Using Symmetric and Asymmetric Keys</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> </note> <important> <p>All GET and PUT requests for an object protected by AWS KMS fail if you don't make them with SSL or by using SigV4.</p> </important> <p>For more information about server-side encryption with CMKs stored in AWS KMS (SSE-KMS), see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingKMSEncryption.html\">Protecting Data Using Server-Side Encryption with CMKs stored in AWS</a>.</p> </li> <li> <p>Use customer-provided encryption keys \226\128\147 If you want to manage your own encryption keys, provide all the following headers in the request.</p> <ul> <li> <p>x-amz-server-side\226\128\139-encryption\226\128\139-customer-algorithm</p> </li> <li> <p>x-amz-server-side\226\128\139-encryption\226\128\139-customer-key</p> </li> <li> <p>x-amz-server-side\226\128\139-encryption\226\128\139-customer-key-MD5</p> </li> </ul> <p>For more information about server-side encryption with CMKs stored in KMS (SSE-KMS), see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingKMSEncryption.html\">Protecting Data Using Server-Side Encryption with CMKs stored in AWS</a>.</p> </li> </ul> </dd> <dt>Access-Control-List (ACL)-Specific Request Headers</dt> <dd> <p>You also can use the following access control\226\128\147related headers with this operation. By default, all objects are private. Only the owner has full access control. When adding a new object, you can grant permissions to individual AWS accounts or to predefined groups defined by Amazon S3. These permissions are then added to the Access Control List (ACL) on the object. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3_ACLs_UsingACLs.html\">Using ACLs</a>. With this operation, you can grant access permissions using one of the following two methods:</p> <ul> <li> <p>Specify a canned ACL (<code>x-amz-acl</code>) \226\128\148 Amazon S3 supports a set of predefined ACLs, known as canned ACLs. Each canned ACL has a predefined set of grantees and permissions. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#CannedACL\">Canned ACL</a>.</p> </li> <li> <p>Specify access permissions explicitly \226\128\148 To explicitly grant access permissions to specific AWS accounts or groups, use the following headers. Each header maps to specific permissions that Amazon S3 supports in an ACL. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html\">Access Control List (ACL) Overview</a>. In the header, you specify a list of grantees who get the specific permission. To grant permissions explicitly use:</p> <ul> <li> <p>x-amz-grant-read</p> </li> <li> <p>x-amz-grant-write</p> </li> <li> <p>x-amz-grant-read-acp</p> </li> <li> <p>x-amz-grant-write-acp</p> </li> <li> <p>x-amz-grant-full-control</p> </li> </ul> <p>You specify each grantee as a type=value pair, where the type is one of the following:</p> <ul> <li> <p> <code>emailAddress</code> \226\128\147 if the value specified is the email address of an AWS account</p> <important> <p>Using email addresses to specify a grantee is only supported in the following AWS Regions: </p> <ul> <li> <p>US East (N. Virginia)</p> </li> <li> <p>US West (N. California)</p> </li> <li> <p> US West (Oregon)</p> </li> <li> <p> Asia Pacific (Singapore)</p> </li> <li> <p>Asia Pacific (Sydney)</p> </li> <li> <p>Asia Pacific (Tokyo)</p> </li> <li> <p>EU (Ireland)</p> </li> <li> <p>South America (S\195\163o Paulo)</p> </li> </ul> <p>For a list of all the Amazon S3 supported Regions and endpoints, see <a href=\"https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region\">Regions and Endpoints</a> in the AWS General Reference</p> </important> </li> <li> <p> <code>id</code> \226\128\147 if the value specified is the canonical user ID of an AWS account</p> </li> <li> <p> <code>uri</code> \226\128\147 if you are granting permissions to a predefined group</p> </li> </ul> <p>For example, the following <code>x-amz-grant-read</code> header grants the AWS accounts identified by email addresses permissions to read object data and its metadata:</p> <p> <code>x-amz-grant-read: emailAddress=\"xyz@amazon.com\", emailAddress=\"abc@amazon.com\" </code> </p> </li> </ul> </dd> <dt>Server-Side- Encryption-Specific Request Headers</dt> <dd> <p>You can optionally tell Amazon S3 to encrypt data at rest using server-side encryption. Server-side encryption is for data encryption at rest. Amazon S3 encrypts your data as it writes it to disks in its data centers and decrypts it when you access it. The option you use depends on whether you want to use AWS-managed encryption keys or provide your own encryption key. </p> <ul> <li> <p>Use encryption keys managed by Amazon S3 or customer master keys (CMKs) stored in AWS Key Management Service (AWS KMS) \226\128\147 If you want AWS to manage the keys used to encrypt data, specify the following headers in the request.</p> <ul> <li> <p>x-amz-server-side\226\128\139-encryption</p> </li> <li> <p>x-amz-server-side-encryption-aws-kms-key-id</p> </li> <li> <p>x-amz-server-side-encryption-context</p> </li> </ul> <note> <p>If you specify <code>x-amz-server-side-encryption:aws:kms</code>, but don't provide <code>x-amz-server-side-encryption-aws-kms-key-id</code>, Amazon S3 uses the AWS managed CMK in AWS KMS to protect the data. If you want to use a customer managed AWS KMS CMK, you must provide the <code>x-amz-server-side-encryption-aws-kms-key-id</code> of the symmetric customer managed CMK. Amazon S3 only supports symmetric CMKs and not asymmetric CMKs. For more information, see <a href=\"https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html\">Using Symmetric and Asymmetric Keys</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> </note> <important> <p>All GET and PUT requests for an object protected by AWS KMS fail if you don't make them with SSL or by using SigV4.</p> </important> <p>For more information about server-side encryption with CMKs stored in AWS KMS (SSE-KMS), see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingKMSEncryption.html\">Protecting Data Using Server-Side Encryption with CMKs stored in AWS KMS</a>.</p> </li> <li> <p>Use customer-provided encryption keys \226\128\147 If you want to manage your own encryption keys, provide all the following headers in the request.</p> <note> <p>If you use this feature, the ETag value that Amazon S3 returns in the response is not the MD5 of the object.</p> </note> <ul> <li> <p>x-amz-server-side\226\128\139-encryption\226\128\139-customer-algorithm</p> </li> <li> <p>x-amz-server-side\226\128\139-encryption\226\128\139-customer-key</p> </li> <li> <p>x-amz-server-side\226\128\139-encryption\226\128\139-customer-key-MD5</p> </li> </ul> <p>For more information about server-side encryption with CMKs stored in AWS KMS (SSE-KMS), see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingKMSEncryption.html\">Protecting Data Using Server-Side Encryption with CMKs stored in AWS KMS</a>.</p> </li> </ul> </dd> </dl> <p> <b>Storage Class Options</b> </p> <p>By default, Amazon S3 uses the Standard storage class to store newly created objects. The Standard storage class provides high durability and high availability. You can specify other storage classes depending on the performance needs. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-class-intro.html\">Storage Classes</a> in the Amazon Simple Storage Service Developer Guide.</p> <p> <b>Versioning</b> </p> <p>If you enable versioning for a bucket, Amazon S3 automatically generates a unique version ID for the object being stored. Amazon S3 returns this ID in the response using the <code>x-amz-version-id response</code> header. If versioning is suspended, Amazon S3 always uses null as the version ID for the object stored. For more information about returning the versioning state of a bucket, see <a>GetBucketVersioning</a>. If you enable versioning for a bucket, when Amazon S3 receives multiple write requests for the same object simultaneously, it stores all of the objects.</p> <p class=\"title\"> <b>Related Resources</b> </p> <ul> <li> <p> <a>CopyObject</a> </p> </li> <li> <p> <a>DeleteObject</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PutObjectRequest :
sig
  type t =
    {
    a_c_l: ObjectCannedACL.t option ;
    body: Blob.t option ;
    bucket: String.t ;
    cache_control: String.t option ;
    content_disposition: String.t option ;
    content_encoding: String.t option ;
    content_language: String.t option ;
    content_length: Long.t option ;
    content_m_d5: String.t option ;
    content_type: String.t option ;
    expires: DateTime.t option ;
    grant_full_control: String.t option ;
    grant_read: String.t option ;
    grant_read_a_c_p: String.t option ;
    grant_write_a_c_p: String.t option ;
    key: String.t ;
    metadata: Metadata.t option ;
    server_side_encryption: ServerSideEncryption.t option ;
    storage_class: StorageClass.t option ;
    website_redirect_location: String.t option ;
    s_s_e_customer_algorithm: String.t option ;
    s_s_e_customer_key: String.t option ;
    s_s_e_customer_key_m_d5: String.t option ;
    s_s_e_k_m_s_key_id: String.t option ;
    s_s_e_k_m_s_encryption_context: String.t option ;
    request_payer: RequestPayer.t option ;
    tagging: String.t option ;
    object_lock_mode: ObjectLockMode.t option ;
    object_lock_retain_until_date: DateTime.t option ;
    object_lock_legal_hold_status: ObjectLockLegalHoldStatus.t option }
  val make :
    ?a_c_l:ObjectCannedACL.t ->
      ?body:Blob.t ->
        bucket:String.t ->
          ?cache_control:String.t ->
            ?content_disposition:String.t ->
              ?content_encoding:String.t ->
                ?content_language:String.t ->
                  ?content_length:Long.t ->
                    ?content_m_d5:String.t ->
                      ?content_type:String.t ->
                        ?expires:DateTime.t ->
                          ?grant_full_control:String.t ->
                            ?grant_read:String.t ->
                              ?grant_read_a_c_p:String.t ->
                                ?grant_write_a_c_p:String.t ->
                                  key:String.t ->
                                    ?metadata:Metadata.t ->
                                      ?server_side_encryption:ServerSideEncryption.t
                                        ->
                                        ?storage_class:StorageClass.t ->
                                          ?website_redirect_location:String.t
                                            ->
                                            ?s_s_e_customer_algorithm:String.t
                                              ->
                                              ?s_s_e_customer_key:String.t ->
                                                ?s_s_e_customer_key_m_d5:String.t
                                                  ->
                                                  ?s_s_e_k_m_s_key_id:String.t
                                                    ->
                                                    ?s_s_e_k_m_s_encryption_context:String.t
                                                      ->
                                                      ?request_payer:RequestPayer.t
                                                        ->
                                                        ?tagging:String.t ->
                                                          ?object_lock_mode:ObjectLockMode.t
                                                            ->
                                                            ?object_lock_retain_until_date:DateTime.t
                                                              ->
                                                              ?object_lock_legal_hold_status:ObjectLockLegalHoldStatus.t
                                                                -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module PutObjectOutput = PutObjectOutput
type input = PutObjectRequest.t
type output = PutObjectOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error