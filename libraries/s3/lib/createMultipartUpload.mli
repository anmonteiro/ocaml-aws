(** "<p>This operation initiates a multipart upload and returns an upload ID. This upload ID is used to associate all of the parts in the specific multipart upload. You specify this upload ID in each of your subsequent upload part requests (see <a>UploadPart</a>). You also include this upload ID in the final request to either complete or abort the multipart upload request.</p> <p>For more information about multipart uploads, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html\">Multipart Upload Overview</a>.</p> <p>If you have configured a lifecycle rule to abort incomplete multipart uploads, the upload must complete within the number of days specified in the bucket lifecycle configuration. Otherwise, the incomplete multipart upload becomes eligible for an abort operation and Amazon S3 aborts the multipart upload. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html#mpu-abort-incomplete-mpu-lifecycle-config\">Aborting Incomplete Multipart Uploads Using a Bucket Lifecycle Policy</a>.</p> <p>For information about the permissions required to use the multipart upload API, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuAndPermissions.html\">Multipart Upload API and Permissions</a>.</p> <p>For request signing, multipart upload is just a series of regular requests. You initiate a multipart upload, send one or more requests to upload parts, and then complete the multipart upload process. You sign each request individually. There is nothing special about signing multipart upload requests. For more information about signing, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html\">Authenticating Requests (AWS Signature Version 4)</a>.</p> <note> <p> After you initiate a multipart upload and upload one or more parts, to stop being charged for storing the uploaded parts, you must either complete or abort the multipart upload. Amazon S3 frees up the space used to store the parts and stop charging you for storing them only after you either complete or abort a multipart upload. </p> </note> <p>You can optionally request server-side encryption. For server-side encryption, Amazon S3 encrypts your data as it writes it to disks in its data centers and decrypts it when you access it. You can provide your own encryption key, or use AWS Key Management Service (AWS KMS) customer master keys (CMKs) or Amazon S3-managed encryption keys. If you choose to provide your own encryption key, the request headers you provide in <a>UploadPart</a>) and <a>UploadPartCopy</a>) requests must match the headers you used in the request to initiate the upload by using <code>CreateMultipartUpload</code>. </p> <p>To perform a multipart upload with encryption using an AWS KMS CMK, the requester must have permission to the <code>kms:Encrypt</code>, <code>kms:Decrypt</code>, <code>kms:ReEncrypt*</code>, <code>kms:GenerateDataKey*</code>, and <code>kms:DescribeKey</code> actions on the key. These permissions are required because Amazon S3 must decrypt and read data from the encrypted file parts before it completes the multipart upload.</p> <p>If your AWS Identity and Access Management (IAM) user or role is in the same AWS account as the AWS KMS CMK, then you must have these permissions on the key policy. If your IAM user or role belongs to a different account than the key, then you must have the permissions on both the key policy and your IAM user or role.</p> <p> For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/serv-side-encryption.html\">Protecting Data Using Server-Side Encryption</a>.</p> <dl> <dt>Access Permissions</dt> <dd> <p>When copying an object, you can optionally specify the accounts or groups that should be granted specific permissions on the new object. There are two ways to grant the permissions using the request headers:</p> <ul> <li> <p>Specify a canned ACL with the <code>x-amz-acl</code> request header. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#CannedACL\">Canned ACL</a>.</p> </li> <li> <p>Specify access permissions explicitly with the <code>x-amz-grant-read</code>, <code>x-amz-grant-read-acp</code>, <code>x-amz-grant-write-acp</code>, and <code>x-amz-grant-full-control</code> headers. These parameters map to the set of permissions that Amazon S3 supports in an ACL. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html\">Access Control List (ACL) Overview</a>.</p> </li> </ul> <p>You can use either a canned ACL or specify access permissions explicitly. You cannot do both.</p> </dd> <dt>Server-Side- Encryption-Specific Request Headers</dt> <dd> <p>You can optionally tell Amazon S3 to encrypt data at rest using server-side encryption. Server-side encryption is for data encryption at rest. Amazon S3 encrypts your data as it writes it to disks in its data centers and decrypts it when you access it. The option you use depends on whether you want to use AWS managed encryption keys or provide your own encryption key. </p> <ul> <li> <p>Use encryption keys managed by Amazon S3 or customer master keys (CMKs) stored in AWS Key Management Service (AWS KMS) \226\128\147 If you want AWS to manage the keys used to encrypt data, specify the following headers in the request.</p> <ul> <li> <p>x-amz-server-side\226\128\139-encryption</p> </li> <li> <p>x-amz-server-side-encryption-aws-kms-key-id</p> </li> <li> <p>x-amz-server-side-encryption-context</p> </li> </ul> <note> <p>If you specify <code>x-amz-server-side-encryption:aws:kms</code>, but don't provide <code>x-amz-server-side-encryption-aws-kms-key-id</code>, Amazon S3 uses the AWS managed CMK in AWS KMS to protect the data.</p> </note> <important> <p>All GET and PUT requests for an object protected by AWS KMS fail if you don't make them with SSL or by using SigV4.</p> </important> <p>For more information about server-side encryption with CMKs stored in AWS KMS (SSE-KMS), see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingKMSEncryption.html\">Protecting Data Using Server-Side Encryption with CMKs stored in AWS KMS</a>.</p> </li> <li> <p>Use customer-provided encryption keys \226\128\147 If you want to manage your own encryption keys, provide all the following headers in the request.</p> <ul> <li> <p>x-amz-server-side\226\128\139-encryption\226\128\139-customer-algorithm</p> </li> <li> <p>x-amz-server-side\226\128\139-encryption\226\128\139-customer-key</p> </li> <li> <p>x-amz-server-side\226\128\139-encryption\226\128\139-customer-key-MD5</p> </li> </ul> <p>For more information about server-side encryption with CMKs stored in AWS KMS (SSE-KMS), see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingKMSEncryption.html\">Protecting Data Using Server-Side Encryption with CMKs stored in AWS KMS</a>.</p> </li> </ul> </dd> <dt>Access-Control-List (ACL)-Specific Request Headers</dt> <dd> <p>You also can use the following access control\226\128\147related headers with this operation. By default, all objects are private. Only the owner has full access control. When adding a new object, you can grant permissions to individual AWS accounts or to predefined groups defined by Amazon S3. These permissions are then added to the access control list (ACL) on the object. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3_ACLs_UsingACLs.html\">Using ACLs</a>. With this operation, you can grant access permissions using one of the following two methods:</p> <ul> <li> <p>Specify a canned ACL (<code>x-amz-acl</code>) \226\128\148 Amazon S3 supports a set of predefined ACLs, known as <i>canned ACLs</i>. Each canned ACL has a predefined set of grantees and permissions. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#CannedACL\">Canned ACL</a>.</p> </li> <li> <p>Specify access permissions explicitly \226\128\148 To explicitly grant access permissions to specific AWS accounts or groups, use the following headers. Each header maps to specific permissions that Amazon S3 supports in an ACL. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html\">Access Control List (ACL) Overview</a>. In the header, you specify a list of grantees who get the specific permission. To grant permissions explicitly, use:</p> <ul> <li> <p>x-amz-grant-read</p> </li> <li> <p>x-amz-grant-write</p> </li> <li> <p>x-amz-grant-read-acp</p> </li> <li> <p>x-amz-grant-write-acp</p> </li> <li> <p>x-amz-grant-full-control</p> </li> </ul> <p>You specify each grantee as a type=value pair, where the type is one of the following:</p> <ul> <li> <p> <code>emailAddress</code> \226\128\147 if the value specified is the email address of an AWS account</p> </li> <li> <p> <code>id</code> \226\128\147 if the value specified is the canonical user ID of an AWS account</p> </li> <li> <p> <code>uri</code> \226\128\147 if you are granting permissions to a predefined group</p> </li> </ul> <p>For example, the following <code>x-amz-grant-read</code> header grants the AWS accounts identified by email addresses permissions to read object data and its metadata:</p> <p> <code>x-amz-grant-read: emailAddress=\"xyz@amazon.com\", emailAddress=\"abc@amazon.com\" </code> </p> </li> </ul> </dd> </dl> <p>The following operations are related to <code>CreateMultipartUpload</code>:</p> <ul> <li> <p> <a>UploadPart</a> </p> </li> <li> <p> <a>CompleteMultipartUpload</a> </p> </li> <li> <p> <a>AbortMultipartUpload</a> </p> </li> <li> <p> <a>ListParts</a> </p> </li> <li> <p> <a>ListMultipartUploads</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateMultipartUploadRequest :
sig
  type t =
    {
    a_c_l: ObjectCannedACL.t option ;
    bucket: String.t ;
    cache_control: String.t option ;
    content_disposition: String.t option ;
    content_encoding: String.t option ;
    content_language: String.t option ;
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
      bucket:String.t ->
        ?cache_control:String.t ->
          ?content_disposition:String.t ->
            ?content_encoding:String.t ->
              ?content_language:String.t ->
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
                                    ?website_redirect_location:String.t ->
                                      ?s_s_e_customer_algorithm:String.t ->
                                        ?s_s_e_customer_key:String.t ->
                                          ?s_s_e_customer_key_m_d5:String.t
                                            ->
                                            ?s_s_e_k_m_s_key_id:String.t ->
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
module CreateMultipartUploadOutput = CreateMultipartUploadOutput
type input = CreateMultipartUploadRequest.t
type output = CreateMultipartUploadOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error