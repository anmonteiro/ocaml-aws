(** "<p>Creates a copy of an object that is already stored in Amazon S3.</p> <note> <p>You can store individual objects of up to 5 TB in Amazon S3. You create a copy of your object up to 5 GB in size in a single atomic operation using this API. However, for copying an object greater than 5 GB, you must use the multipart upload Upload Part - Copy API. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/CopyingObjctsUsingRESTMPUapi.html\">Copy Object Using the REST Multipart Upload API</a>.</p> </note> <p>When copying an object, you can preserve all metadata (default) or specify new metadata. However, the ACL is not preserved and is set to private for the user making the request. To override the default ACL setting, specify a new ACL when generating a copy request. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3_ACLs_UsingACLs.html\">Using ACLs</a>.</p> <important> <p>Amazon S3 transfer acceleration does not support cross-region copies. If you request a cross-region copy using a transfer acceleration endpoint, you get a 400 <code>Bad Request</code> error. For more information about transfer acceleration, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/transfer-acceleration.html\">Transfer Acceleration</a>.</p> </important> <p>All copy requests must be authenticated. Additionally, you must have <i>read</i> access to the source object and <i>write</i> access to the destination bucket. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/RESTAuthentication.html\">REST Authentication</a>. Both the Region that you want to copy the object from and the Region that you want to copy the object to must be enabled for your account.</p> <p>To only copy an object under certain conditions, such as whether the <code>Etag</code> matches or whether the object was modified before or after a specified date, use the request parameters <code>x-amz-copy-source-if-match</code>, <code>x-amz-copy-source-if-none-match</code>, <code>x-amz-copy-source-if-unmodified-since</code>, or <code> x-amz-copy-source-if-modified-since</code>.</p> <note> <p>All headers with the <code>x-amz-</code> prefix, including <code>x-amz-copy-source</code>, must be signed.</p> </note> <p>You can use this operation to change the storage class of an object that is already stored in Amazon S3 using the <code>StorageClass</code> parameter. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-class-intro.html\">Storage Classes</a>.</p> <p>The source object that you are copying can be encrypted or unencrypted. If the source object is encrypted, it can be encrypted by server-side encryption using AWS managed encryption keys or by using a customer-provided encryption key. When copying an object, you can request that Amazon S3 encrypt the target object by using either the AWS managed encryption keys or by using your own encryption key. You can do this regardless of the form of server-side encryption that was used to encrypt the source, or even if the source object was not encrypted. For more information about server-side encryption, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/serv-side-encryption.html\">Using Server-Side Encryption</a>.</p> <p>A copy request might return an error when Amazon S3 receives the copy request or while Amazon S3 is copying the files. If the error occurs before the copy operation starts, you receive a standard Amazon S3 error. If the error occurs during the copy operation, the error response is embedded in the <code>200 OK</code> response. This means that a <code>200 OK</code> response can contain either a success or an error. Design your application to parse the contents of the response and handle it appropriately.</p> <p>If the copy is successful, you receive a response with information about the copied object.</p> <note> <p>If the request is an HTTP 1.1 request, the response is chunk encoded. If it were not, it would not contain the content-length, and you would need to read the entire body.</p> </note> <p>Consider the following when using request headers:</p> <ul> <li> <p> Consideration 1 \226\128\147 If both the <code>x-amz-copy-source-if-match</code> and <code>x-amz-copy-source-if-unmodified-since</code> headers are present in the request and evaluate as follows, Amazon S3 returns 200 OK and copies the data:</p> <ul> <li> <p> <code>x-amz-copy-source-if-match</code> condition evaluates to true</p> </li> <li> <p> <code>x-amz-copy-source-if-unmodified-since</code> condition evaluates to false</p> </li> </ul> </li> <li> <p> Consideration 2 \226\128\147 If both of the <code>x-amz-copy-source-if-none-match</code> and <code>x-amz-copy-source-if-modified-since</code> headers are present in the request and evaluate as follows, Amazon S3 returns the <code>412 Precondition Failed</code> response code:</p> <ul> <li> <p> <code>x-amz-copy-source-if-none-match</code> condition evaluates to false</p> </li> <li> <p> <code>x-amz-copy-source-if-modified-since</code> condition evaluates to true</p> </li> </ul> </li> </ul> <p>The copy request charge is based on the storage class and Region you specify for the destination object. For pricing information, see <a href=\"https://aws.amazon.com/s3/pricing/\">Amazon S3 Pricing</a>.</p> <p>Following are other considerations when using <code>CopyObject</code>:</p> <dl> <dt>Versioning</dt> <dd> <p>By default, <code>x-amz-copy-source</code> identifies the current version of an object to copy. (If the current version is a delete marker, Amazon S3 behaves as if the object was deleted.) To copy a different version, use the <code>versionId</code> subresource.</p> <p>If you enable versioning on the target bucket, Amazon S3 generates a unique version ID for the object being copied. This version ID is different from the version ID of the source object. Amazon S3 returns the version ID of the copied object in the <code>x-amz-version-id</code> response header in the response.</p> <p>If you do not enable versioning or suspend it on the target bucket, the version ID that Amazon S3 generates is always null.</p> <p>If the source object's storage class is GLACIER, you must restore a copy of this object before you can use it as a source object for the copy operation. For more information, see .</p> </dd> <dt>Access Permissions</dt> <dd> <p>When copying an object, you can optionally specify the accounts or groups that should be granted specific permissions on the new object. There are two ways to grant the permissions using the request headers:</p> <ul> <li> <p>Specify a canned ACL with the <code>x-amz-acl</code> request header. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#CannedACL\">Canned ACL</a>.</p> </li> <li> <p>Specify access permissions explicitly with the <code>x-amz-grant-read</code>, <code>x-amz-grant-read-acp</code>, <code>x-amz-grant-write-acp</code>, and <code>x-amz-grant-full-control</code> headers. These parameters map to the set of permissions that Amazon S3 supports in an ACL. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html\">Access Control List (ACL) Overview</a>.</p> </li> </ul> <p>You can use either a canned ACL or specify access permissions explicitly. You cannot do both.</p> </dd> <dt>Server-Side- Encryption-Specific Request Headers</dt> <dd> <p>To encrypt the target object, you must provide the appropriate encryption-related request headers. The one you use depends on whether you want to use AWS managed encryption keys or provide your own encryption key. </p> <ul> <li> <p>To encrypt the target object using server-side encryption with an AWS managed encryption key, provide the following request headers, as appropriate.</p> <ul> <li> <p> <code>x-amz-server-side\226\128\139-encryption</code> </p> </li> <li> <p> <code>x-amz-server-side-encryption-aws-kms-key-id</code> </p> </li> <li> <p> <code>x-amz-server-side-encryption-context</code> </p> </li> </ul> <note> <p>If you specify <code>x-amz-server-side-encryption:aws:kms</code>, but don't provide <code>x-amz-server-side-encryption-aws-kms-key-id</code>, Amazon S3 uses the AWS managed CMK in AWS KMS to protect the data. If you want to use a customer managed AWS KMS CMK, you must provide the <code>x-amz-server-side-encryption-aws-kms-key-id</code> of the symmetric customer managed CMK. Amazon S3 only supports symmetric CMKs and not asymmetric CMKs. For more information, see <a href=\"https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html\">Using Symmetric and Asymmetric Keys</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> </note> <important> <p>All GET and PUT requests for an object protected by AWS KMS fail if you don't make them with SSL or by using SigV4.</p> </important> <p>For more information about server-side encryption with CMKs stored in AWS KMS (SSE-KMS), see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingKMSEncryption.html\">Protecting Data Using Server-Side Encryption with CMKs stored in KMS</a>.</p> </li> <li> <p>To encrypt the target object using server-side encryption with an encryption key that you provide, use the following headers.</p> <ul> <li> <p>x-amz-server-side\226\128\139-encryption\226\128\139-customer-algorithm</p> </li> <li> <p>x-amz-server-side\226\128\139-encryption\226\128\139-customer-key</p> </li> <li> <p>x-amz-server-side\226\128\139-encryption\226\128\139-customer-key-MD5</p> </li> </ul> </li> <li> <p>If the source object is encrypted using server-side encryption with customer-provided encryption keys, you must use the following headers.</p> <ul> <li> <p>x-amz-copy-source\226\128\139-server-side\226\128\139-encryption\226\128\139-customer-algorithm</p> </li> <li> <p>x-amz-copy-source\226\128\139-server-side\226\128\139-encryption\226\128\139-customer-key</p> </li> <li> <p>x-amz-copy-source-\226\128\139server-side\226\128\139-encryption\226\128\139-customer-key-MD5</p> </li> </ul> <p>For more information about server-side encryption with CMKs stored in AWS KMS (SSE-KMS), see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingKMSEncryption.html\">Protecting Data Using Server-Side Encryption with CMKs stored in Amazon KMS</a>.</p> </li> </ul> </dd> <dt>Access-Control-List (ACL)-Specific Request Headers</dt> <dd> <p>You also can use the following access control\226\128\147related headers with this operation. By default, all objects are private. Only the owner has full access control. When adding a new object, you can grant permissions to individual AWS accounts or to predefined groups defined by Amazon S3. These permissions are then added to the access control list (ACL) on the object. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3_ACLs_UsingACLs.html\">Using ACLs</a>. With this operation, you can grant access permissions using one of the following two methods:</p> <ul> <li> <p>Specify a canned ACL (<code>x-amz-acl</code>) \226\128\148 Amazon S3 supports a set of predefined ACLs, known as <i>canned ACLs</i>. Each canned ACL has a predefined set of grantees and permissions. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#CannedACL\">Canned ACL</a>.</p> </li> <li> <p>Specify access permissions explicitly \226\128\148 To explicitly grant access permissions to specific AWS accounts or groups, use the following headers. Each header maps to specific permissions that Amazon S3 supports in an ACL. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html\">Access Control List (ACL) Overview</a>. In the header, you specify a list of grantees who get the specific permission. To grant permissions explicitly, use:</p> <ul> <li> <p>x-amz-grant-read</p> </li> <li> <p>x-amz-grant-write</p> </li> <li> <p>x-amz-grant-read-acp</p> </li> <li> <p>x-amz-grant-write-acp</p> </li> <li> <p>x-amz-grant-full-control</p> </li> </ul> <p>You specify each grantee as a type=value pair, where the type is one of the following:</p> <ul> <li> <p> <code>emailAddress</code> \226\128\147 if the value specified is the email address of an AWS account</p> </li> <li> <p> <code>id</code> \226\128\147 if the value specified is the canonical user ID of an AWS account</p> </li> <li> <p> <code>uri</code> \226\128\147 if you are granting permissions to a predefined group</p> </li> </ul> <p>For example, the following <code>x-amz-grant-read</code> header grants the AWS accounts identified by email addresses permissions to read object data and its metadata:</p> <p> <code>x-amz-grant-read: emailAddress=\"xyz@amazon.com\", emailAddress=\"abc@amazon.com\" </code> </p> </li> </ul> </dd> </dl> <p>The following operations are related to <code>CopyObject</code>:</p> <ul> <li> <p> <a>PutObject</a> </p> </li> <li> <p> <a>GetObject</a> </p> </li> </ul> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/CopyingObjectsExamples.html\">Copying Objects</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CopyObjectRequest :
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
    copy_source: String.t ;
    copy_source_if_match: String.t option ;
    copy_source_if_modified_since: DateTime.t option ;
    copy_source_if_none_match: String.t option ;
    copy_source_if_unmodified_since: DateTime.t option ;
    expires: DateTime.t option ;
    grant_full_control: String.t option ;
    grant_read: String.t option ;
    grant_read_a_c_p: String.t option ;
    grant_write_a_c_p: String.t option ;
    key: String.t ;
    metadata: Metadata.t option ;
    metadata_directive: MetadataDirective.t option ;
    tagging_directive: TaggingDirective.t option ;
    server_side_encryption: ServerSideEncryption.t option ;
    storage_class: StorageClass.t option ;
    website_redirect_location: String.t option ;
    s_s_e_customer_algorithm: String.t option ;
    s_s_e_customer_key: String.t option ;
    s_s_e_customer_key_m_d5: String.t option ;
    s_s_e_k_m_s_key_id: String.t option ;
    s_s_e_k_m_s_encryption_context: String.t option ;
    copy_source_s_s_e_customer_algorithm: String.t option ;
    copy_source_s_s_e_customer_key: String.t option ;
    copy_source_s_s_e_customer_key_m_d5: String.t option ;
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
                  copy_source:String.t ->
                    ?copy_source_if_match:String.t ->
                      ?copy_source_if_modified_since:DateTime.t ->
                        ?copy_source_if_none_match:String.t ->
                          ?copy_source_if_unmodified_since:DateTime.t ->
                            ?expires:DateTime.t ->
                              ?grant_full_control:String.t ->
                                ?grant_read:String.t ->
                                  ?grant_read_a_c_p:String.t ->
                                    ?grant_write_a_c_p:String.t ->
                                      key:String.t ->
                                        ?metadata:Metadata.t ->
                                          ?metadata_directive:MetadataDirective.t
                                            ->
                                            ?tagging_directive:TaggingDirective.t
                                              ->
                                              ?server_side_encryption:ServerSideEncryption.t
                                                ->
                                                ?storage_class:StorageClass.t
                                                  ->
                                                  ?website_redirect_location:String.t
                                                    ->
                                                    ?s_s_e_customer_algorithm:String.t
                                                      ->
                                                      ?s_s_e_customer_key:String.t
                                                        ->
                                                        ?s_s_e_customer_key_m_d5:String.t
                                                          ->
                                                          ?s_s_e_k_m_s_key_id:String.t
                                                            ->
                                                            ?s_s_e_k_m_s_encryption_context:String.t
                                                              ->
                                                              ?copy_source_s_s_e_customer_algorithm:String.t
                                                                ->
                                                                ?copy_source_s_s_e_customer_key:String.t
                                                                  ->
                                                                  ?copy_source_s_s_e_customer_key_m_d5:String.t
                                                                    ->
                                                                    ?request_payer:RequestPayer.t
                                                                    ->
                                                                    ?tagging:String.t
                                                                    ->
                                                                    ?object_lock_mode:ObjectLockMode.t
                                                                    ->
                                                                    ?object_lock_retain_until_date:DateTime.t
                                                                    ->
                                                                    ?object_lock_legal_hold_status:ObjectLockLegalHoldStatus.t
                                                                    ->
                                                                    unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CopyObjectOutput = CopyObjectOutput
type input = CopyObjectRequest.t
type output = CopyObjectOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error