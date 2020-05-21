open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CopyObjectRequest =
  struct
    type t =
      {
      a_c_l: ObjectCannedACL.t option
        [@ocaml.doc "<p>The canned ACL to apply to the object.</p>"];
      bucket: String.t
        [@ocaml.doc "<p>The name of the destination bucket.</p>"];
      cache_control: String.t option
        [@ocaml.doc
          "<p>Specifies caching behavior along the request/reply chain.</p>"];
      content_disposition: String.t option
        [@ocaml.doc
          "<p>Specifies presentational information for the object.</p>"];
      content_encoding: String.t option
        [@ocaml.doc
          "<p>Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.</p>"];
      content_language: String.t option
        [@ocaml.doc "<p>The language the content is in.</p>"];
      content_type: String.t option
        [@ocaml.doc
          "<p>A standard MIME type describing the format of the object data.</p>"];
      copy_source: String.t
        [@ocaml.doc
          "<p>The name of the source bucket and key name of the source object, separated by a slash (/). Must be URL-encoded.</p>"];
      copy_source_if_match: String.t option
        [@ocaml.doc
          "<p>Copies the object if its entity tag (ETag) matches the specified tag.</p>"];
      copy_source_if_modified_since: DateTime.t option
        [@ocaml.doc
          "<p>Copies the object if it has been modified since the specified time.</p>"];
      copy_source_if_none_match: String.t option
        [@ocaml.doc
          "<p>Copies the object if its entity tag (ETag) is different than the specified ETag.</p>"];
      copy_source_if_unmodified_since: DateTime.t option
        [@ocaml.doc
          "<p>Copies the object if it hasn't been modified since the specified time.</p>"];
      expires: DateTime.t option
        [@ocaml.doc
          "<p>The date and time at which the object is no longer cacheable.</p>"];
      grant_full_control: String.t option
        [@ocaml.doc
          "<p>Gives the grantee READ, READ_ACP, and WRITE_ACP permissions on the object.</p>"];
      grant_read: String.t option
        [@ocaml.doc
          "<p>Allows grantee to read the object data and its metadata.</p>"];
      grant_read_a_c_p: String.t option
        [@ocaml.doc "<p>Allows grantee to read the object ACL.</p>"];
      grant_write_a_c_p: String.t option
        [@ocaml.doc
          "<p>Allows grantee to write the ACL for the applicable object.</p>"];
      key: String.t [@ocaml.doc "<p>The key of the destination object.</p>"];
      metadata: Metadata.t option
        [@ocaml.doc
          "<p>A map of metadata to store with the object in S3.</p>"];
      metadata_directive: MetadataDirective.t option
        [@ocaml.doc
          "<p>Specifies whether the metadata is copied from the source object or replaced with metadata provided in the request.</p>"];
      tagging_directive: TaggingDirective.t option
        [@ocaml.doc
          "<p>Specifies whether the object tag-set are copied from the source object or replaced with tag-set provided in the request.</p>"];
      server_side_encryption: ServerSideEncryption.t option
        [@ocaml.doc
          "<p>The server-side encryption algorithm used when storing this object in Amazon S3 (for example, AES256, aws:kms).</p>"];
      storage_class: StorageClass.t option
        [@ocaml.doc
          "<p>The type of storage to use for the object. Defaults to 'STANDARD'.</p>"];
      website_redirect_location: String.t option
        [@ocaml.doc
          "<p>If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.</p>"];
      s_s_e_customer_algorithm: String.t option
        [@ocaml.doc
          "<p>Specifies the algorithm to use to when encrypting the object (for example, AES256).</p>"];
      s_s_e_customer_key: String.t option
        [@ocaml.doc
          "<p>Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon S3 does not store the encryption key. The key must be appropriate for use with the algorithm specified in the <code>x-amz-server-side\226\128\139-encryption\226\128\139-customer-algorithm</code> header.</p>"];
      s_s_e_customer_key_m_d5: String.t option
        [@ocaml.doc
          "<p>Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure that the encryption key was transmitted without error.</p>"];
      s_s_e_k_m_s_key_id: String.t option
        [@ocaml.doc
          "<p>Specifies the AWS KMS key ID to use for object encryption. All GET and PUT requests for an object protected by AWS KMS will fail if not made via SSL or using SigV4. For information about configuring using any of the officially supported AWS SDKs and AWS CLI, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingAWSSDK.html#specify-signature-version\">Specifying the Signature Version in Request Authentication</a> in the <i>Amazon S3 Developer Guide</i>.</p>"];
      s_s_e_k_m_s_encryption_context: String.t option
        [@ocaml.doc
          "<p>Specifies the AWS KMS Encryption Context to use for object encryption. The value of this header is a base64-encoded UTF-8 string holding JSON with the encryption context key-value pairs.</p>"];
      copy_source_s_s_e_customer_algorithm: String.t option
        [@ocaml.doc
          "<p>Specifies the algorithm to use when decrypting the source object (for example, AES256).</p>"];
      copy_source_s_s_e_customer_key: String.t option
        [@ocaml.doc
          "<p>Specifies the customer-provided encryption key for Amazon S3 to use to decrypt the source object. The encryption key provided in this header must be one that was used when the source object was created.</p>"];
      copy_source_s_s_e_customer_key_m_d5: String.t option
        [@ocaml.doc
          "<p>Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure that the encryption key was transmitted without error.</p>"];
      request_payer: RequestPayer.t option ;
      tagging: String.t option
        [@ocaml.doc
          "<p>The tag-set for the object destination object this value must be used in conjunction with the <code>TaggingDirective</code>. The tag-set must be encoded as URL Query parameters.</p>"];
      object_lock_mode: ObjectLockMode.t option
        [@ocaml.doc
          "<p>The Object Lock mode that you want to apply to the copied object.</p>"];
      object_lock_retain_until_date: DateTime.t option
        [@ocaml.doc
          "<p>The date and time when you want the copied object's Object Lock to expire.</p>"];
      object_lock_legal_hold_status: ObjectLockLegalHoldStatus.t option
        [@ocaml.doc
          "<p>Specifies whether you want to apply a Legal Hold to the copied object.</p>"]}
    let make ?a_c_l  ~bucket  ?cache_control  ?content_disposition 
      ?content_encoding  ?content_language  ?content_type  ~copy_source 
      ?copy_source_if_match  ?copy_source_if_modified_since 
      ?copy_source_if_none_match  ?copy_source_if_unmodified_since  ?expires 
      ?grant_full_control  ?grant_read  ?grant_read_a_c_p  ?grant_write_a_c_p
       ~key  ?metadata  ?metadata_directive  ?tagging_directive 
      ?server_side_encryption  ?storage_class  ?website_redirect_location 
      ?s_s_e_customer_algorithm  ?s_s_e_customer_key 
      ?s_s_e_customer_key_m_d5  ?s_s_e_k_m_s_key_id 
      ?s_s_e_k_m_s_encryption_context  ?copy_source_s_s_e_customer_algorithm 
      ?copy_source_s_s_e_customer_key  ?copy_source_s_s_e_customer_key_m_d5 
      ?request_payer  ?tagging  ?object_lock_mode 
      ?object_lock_retain_until_date  ?object_lock_legal_hold_status  () =
      {
        a_c_l;
        bucket;
        cache_control;
        content_disposition;
        content_encoding;
        content_language;
        content_type;
        copy_source;
        copy_source_if_match;
        copy_source_if_modified_since;
        copy_source_if_none_match;
        copy_source_if_unmodified_since;
        expires;
        grant_full_control;
        grant_read;
        grant_read_a_c_p;
        grant_write_a_c_p;
        key;
        metadata;
        metadata_directive;
        tagging_directive;
        server_side_encryption;
        storage_class;
        website_redirect_location;
        s_s_e_customer_algorithm;
        s_s_e_customer_key;
        s_s_e_customer_key_m_d5;
        s_s_e_k_m_s_key_id;
        s_s_e_k_m_s_encryption_context;
        copy_source_s_s_e_customer_algorithm;
        copy_source_s_s_e_customer_key;
        copy_source_s_s_e_customer_key_m_d5;
        request_payer;
        tagging;
        object_lock_mode;
        object_lock_retain_until_date;
        object_lock_legal_hold_status
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.object_lock_legal_hold_status
              (fun f ->
                 Headers.Pair
                   ("x-amz-object-lock-legal-hold",
                     (ObjectLockLegalHoldStatus.to_headers f)));
           Util.option_map v.object_lock_retain_until_date
             (fun f ->
                Headers.Pair
                  ("x-amz-object-lock-retain-until-date",
                    (DateTime.to_headers f)));
           Util.option_map v.object_lock_mode
             (fun f ->
                Headers.Pair
                  ("x-amz-object-lock-mode", (ObjectLockMode.to_headers f)));
           Util.option_map v.tagging
             (fun f -> Headers.Pair ("x-amz-tagging", (String.to_headers f)));
           Util.option_map v.request_payer
             (fun f ->
                Headers.Pair
                  ("x-amz-request-payer", (RequestPayer.to_headers f)));
           Util.option_map v.copy_source_s_s_e_customer_key_m_d5
             (fun f ->
                Headers.Pair
                  ("x-amz-copy-source-server-side-encryption-customer-key-MD5",
                    (String.to_headers f)));
           Util.option_map v.copy_source_s_s_e_customer_key
             (fun f ->
                Headers.Pair
                  ("x-amz-copy-source-server-side-encryption-customer-key",
                    (String.to_headers f)));
           Util.option_map v.copy_source_s_s_e_customer_algorithm
             (fun f ->
                Headers.Pair
                  ("x-amz-copy-source-server-side-encryption-customer-algorithm",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_k_m_s_encryption_context
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-context",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_k_m_s_key_id
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-aws-kms-key-id",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-key-MD5",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_key
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-key",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-algorithm",
                    (String.to_headers f)));
           Util.option_map v.website_redirect_location
             (fun f ->
                Headers.Pair
                  ("x-amz-website-redirect-location", (String.to_headers f)));
           Util.option_map v.storage_class
             (fun f ->
                Headers.Pair
                  ("x-amz-storage-class", (StorageClass.to_headers f)));
           Util.option_map v.server_side_encryption
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption",
                    (ServerSideEncryption.to_headers f)));
           Util.option_map v.tagging_directive
             (fun f ->
                Headers.Pair
                  ("x-amz-tagging-directive",
                    (TaggingDirective.to_headers f)));
           Util.option_map v.metadata_directive
             (fun f ->
                Headers.Pair
                  ("x-amz-metadata-directive",
                    (MetadataDirective.to_headers f)));
           Util.option_map v.metadata
             (fun f -> Headers.Pair ("x-amz-meta-", (Metadata.to_headers f)));
           Util.option_map v.grant_write_a_c_p
             (fun f ->
                Headers.Pair ("x-amz-grant-write-acp", (String.to_headers f)));
           Util.option_map v.grant_read_a_c_p
             (fun f ->
                Headers.Pair ("x-amz-grant-read-acp", (String.to_headers f)));
           Util.option_map v.grant_read
             (fun f ->
                Headers.Pair ("x-amz-grant-read", (String.to_headers f)));
           Util.option_map v.grant_full_control
             (fun f ->
                Headers.Pair
                  ("x-amz-grant-full-control", (String.to_headers f)));
           Util.option_map v.expires
             (fun f -> Headers.Pair ("Expires", (DateTime.to_headers f)));
           Util.option_map v.copy_source_if_unmodified_since
             (fun f ->
                Headers.Pair
                  ("x-amz-copy-source-if-unmodified-since",
                    (DateTime.to_headers f)));
           Util.option_map v.copy_source_if_none_match
             (fun f ->
                Headers.Pair
                  ("x-amz-copy-source-if-none-match", (String.to_headers f)));
           Util.option_map v.copy_source_if_modified_since
             (fun f ->
                Headers.Pair
                  ("x-amz-copy-source-if-modified-since",
                    (DateTime.to_headers f)));
           Util.option_map v.copy_source_if_match
             (fun f ->
                Headers.Pair
                  ("x-amz-copy-source-if-match", (String.to_headers f)));
           Some
             (Headers.Pair
                ("x-amz-copy-source", (String.to_headers v.copy_source)));
           Util.option_map v.content_type
             (fun f -> Headers.Pair ("Content-Type", (String.to_headers f)));
           Util.option_map v.content_language
             (fun f ->
                Headers.Pair ("Content-Language", (String.to_headers f)));
           Util.option_map v.content_encoding
             (fun f ->
                Headers.Pair ("Content-Encoding", (String.to_headers f)));
           Util.option_map v.content_disposition
             (fun f ->
                Headers.Pair ("Content-Disposition", (String.to_headers f)));
           Util.option_map v.cache_control
             (fun f -> Headers.Pair ("Cache-Control", (String.to_headers f)));
           Util.option_map v.a_c_l
             (fun f ->
                Headers.Pair ("x-amz-acl", (ObjectCannedACL.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.object_lock_legal_hold_status
              (fun f ->
                 ("object_lock_legal_hold_status",
                   (ObjectLockLegalHoldStatus.to_json f)));
           Util.option_map v.object_lock_retain_until_date
             (fun f ->
                ("object_lock_retain_until_date", (DateTime.to_json f)));
           Util.option_map v.object_lock_mode
             (fun f -> ("object_lock_mode", (ObjectLockMode.to_json f)));
           Util.option_map v.tagging
             (fun f -> ("tagging", (String.to_json f)));
           Util.option_map v.request_payer
             (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.copy_source_s_s_e_customer_key_m_d5
             (fun f ->
                ("copy_source_s_s_e_customer_key_m_d5", (String.to_json f)));
           Util.option_map v.copy_source_s_s_e_customer_key
             (fun f -> ("copy_source_s_s_e_customer_key", (String.to_json f)));
           Util.option_map v.copy_source_s_s_e_customer_algorithm
             (fun f ->
                ("copy_source_s_s_e_customer_algorithm", (String.to_json f)));
           Util.option_map v.s_s_e_k_m_s_encryption_context
             (fun f -> ("s_s_e_k_m_s_encryption_context", (String.to_json f)));
           Util.option_map v.s_s_e_k_m_s_key_id
             (fun f -> ("s_s_e_k_m_s_key_id", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f -> ("s_s_e_customer_key_m_d5", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key
             (fun f -> ("s_s_e_customer_key", (String.to_json f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f -> ("s_s_e_customer_algorithm", (String.to_json f)));
           Util.option_map v.website_redirect_location
             (fun f -> ("website_redirect_location", (String.to_json f)));
           Util.option_map v.storage_class
             (fun f -> ("storage_class", (StorageClass.to_json f)));
           Util.option_map v.server_side_encryption
             (fun f ->
                ("server_side_encryption", (ServerSideEncryption.to_json f)));
           Util.option_map v.tagging_directive
             (fun f -> ("tagging_directive", (TaggingDirective.to_json f)));
           Util.option_map v.metadata_directive
             (fun f -> ("metadata_directive", (MetadataDirective.to_json f)));
           Util.option_map v.metadata
             (fun f -> ("metadata", (Metadata.to_json f)));
           Some ("key", (String.to_json v.key));
           Util.option_map v.grant_write_a_c_p
             (fun f -> ("grant_write_a_c_p", (String.to_json f)));
           Util.option_map v.grant_read_a_c_p
             (fun f -> ("grant_read_a_c_p", (String.to_json f)));
           Util.option_map v.grant_read
             (fun f -> ("grant_read", (String.to_json f)));
           Util.option_map v.grant_full_control
             (fun f -> ("grant_full_control", (String.to_json f)));
           Util.option_map v.expires
             (fun f -> ("expires", (DateTime.to_json f)));
           Util.option_map v.copy_source_if_unmodified_since
             (fun f ->
                ("copy_source_if_unmodified_since", (DateTime.to_json f)));
           Util.option_map v.copy_source_if_none_match
             (fun f -> ("copy_source_if_none_match", (String.to_json f)));
           Util.option_map v.copy_source_if_modified_since
             (fun f ->
                ("copy_source_if_modified_since", (DateTime.to_json f)));
           Util.option_map v.copy_source_if_match
             (fun f -> ("copy_source_if_match", (String.to_json f)));
           Some ("copy_source", (String.to_json v.copy_source));
           Util.option_map v.content_type
             (fun f -> ("content_type", (String.to_json f)));
           Util.option_map v.content_language
             (fun f -> ("content_language", (String.to_json f)));
           Util.option_map v.content_encoding
             (fun f -> ("content_encoding", (String.to_json f)));
           Util.option_map v.content_disposition
             (fun f -> ("content_disposition", (String.to_json f)));
           Util.option_map v.cache_control
             (fun f -> ("cache_control", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket));
           Util.option_map v.a_c_l
             (fun f -> ("a_c_l", (ObjectCannedACL.to_json f)))])
    let parse xml =
      Some
        {
          a_c_l =
            (Util.option_bind (Xml.member "x-amz-acl" xml)
               ObjectCannedACL.parse);
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          cache_control =
            (Util.option_bind (Xml.member "Cache-Control" xml) String.parse);
          content_disposition =
            (Util.option_bind (Xml.member "Content-Disposition" xml)
               String.parse);
          content_encoding =
            (Util.option_bind (Xml.member "Content-Encoding" xml)
               String.parse);
          content_language =
            (Util.option_bind (Xml.member "Content-Language" xml)
               String.parse);
          content_type =
            (Util.option_bind (Xml.member "Content-Type" xml) String.parse);
          copy_source =
            (Xml.required "x-amz-copy-source"
               (Util.option_bind (Xml.member "x-amz-copy-source" xml)
                  String.parse));
          copy_source_if_match =
            (Util.option_bind (Xml.member "x-amz-copy-source-if-match" xml)
               String.parse);
          copy_source_if_modified_since =
            (Util.option_bind
               (Xml.member "x-amz-copy-source-if-modified-since" xml)
               DateTime.parse);
          copy_source_if_none_match =
            (Util.option_bind
               (Xml.member "x-amz-copy-source-if-none-match" xml)
               String.parse);
          copy_source_if_unmodified_since =
            (Util.option_bind
               (Xml.member "x-amz-copy-source-if-unmodified-since" xml)
               DateTime.parse);
          expires =
            (Util.option_bind (Xml.member "Expires" xml) DateTime.parse);
          grant_full_control =
            (Util.option_bind (Xml.member "x-amz-grant-full-control" xml)
               String.parse);
          grant_read =
            (Util.option_bind (Xml.member "x-amz-grant-read" xml)
               String.parse);
          grant_read_a_c_p =
            (Util.option_bind (Xml.member "x-amz-grant-read-acp" xml)
               String.parse);
          grant_write_a_c_p =
            (Util.option_bind (Xml.member "x-amz-grant-write-acp" xml)
               String.parse);
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          metadata =
            (Util.option_bind (Xml.member "x-amz-meta-" xml) Metadata.parse);
          metadata_directive =
            (Util.option_bind (Xml.member "x-amz-metadata-directive" xml)
               MetadataDirective.parse);
          tagging_directive =
            (Util.option_bind (Xml.member "x-amz-tagging-directive" xml)
               TaggingDirective.parse);
          server_side_encryption =
            (Util.option_bind (Xml.member "x-amz-server-side-encryption" xml)
               ServerSideEncryption.parse);
          storage_class =
            (Util.option_bind (Xml.member "x-amz-storage-class" xml)
               StorageClass.parse);
          website_redirect_location =
            (Util.option_bind
               (Xml.member "x-amz-website-redirect-location" xml)
               String.parse);
          s_s_e_customer_algorithm =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-algorithm"
                  xml) String.parse);
          s_s_e_customer_key =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-key" xml)
               String.parse);
          s_s_e_customer_key_m_d5 =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-key-MD5"
                  xml) String.parse);
          s_s_e_k_m_s_key_id =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-aws-kms-key-id" xml)
               String.parse);
          s_s_e_k_m_s_encryption_context =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-context" xml)
               String.parse);
          copy_source_s_s_e_customer_algorithm =
            (Util.option_bind
               (Xml.member
                  "x-amz-copy-source-server-side-encryption-customer-algorithm"
                  xml) String.parse);
          copy_source_s_s_e_customer_key =
            (Util.option_bind
               (Xml.member
                  "x-amz-copy-source-server-side-encryption-customer-key" xml)
               String.parse);
          copy_source_s_s_e_customer_key_m_d5 =
            (Util.option_bind
               (Xml.member
                  "x-amz-copy-source-server-side-encryption-customer-key-MD5"
                  xml) String.parse);
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse);
          tagging =
            (Util.option_bind (Xml.member "x-amz-tagging" xml) String.parse);
          object_lock_mode =
            (Util.option_bind (Xml.member "x-amz-object-lock-mode" xml)
               ObjectLockMode.parse);
          object_lock_retain_until_date =
            (Util.option_bind
               (Xml.member "x-amz-object-lock-retain-until-date" xml)
               DateTime.parse);
          object_lock_legal_hold_status =
            (Util.option_bind (Xml.member "x-amz-object-lock-legal-hold" xml)
               ObjectLockLegalHoldStatus.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((((((((((((((((((((((((([] @
                                               [Util.option_map v.a_c_l
                                                  (fun f ->
                                                     Ezxmlm.make_tag
                                                       "x-amz-acl"
                                                       ([],
                                                         (ObjectCannedACL.to_xml
                                                            f)))])
                                              @
                                              [Some
                                                 (Ezxmlm.make_tag "Bucket"
                                                    ([],
                                                      (String.to_xml v.bucket)))])
                                             @
                                             [Util.option_map v.cache_control
                                                (fun f ->
                                                   Ezxmlm.make_tag
                                                     "Cache-Control"
                                                     ([], (String.to_xml f)))])
                                            @
                                            [Util.option_map
                                               v.content_disposition
                                               (fun f ->
                                                  Ezxmlm.make_tag
                                                    "Content-Disposition"
                                                    ([], (String.to_xml f)))])
                                           @
                                           [Util.option_map
                                              v.content_encoding
                                              (fun f ->
                                                 Ezxmlm.make_tag
                                                   "Content-Encoding"
                                                   ([], (String.to_xml f)))])
                                          @
                                          [Util.option_map v.content_language
                                             (fun f ->
                                                Ezxmlm.make_tag
                                                  "Content-Language"
                                                  ([], (String.to_xml f)))])
                                         @
                                         [Util.option_map v.content_type
                                            (fun f ->
                                               Ezxmlm.make_tag "Content-Type"
                                                 ([], (String.to_xml f)))])
                                        @
                                        [Some
                                           (Ezxmlm.make_tag
                                              "x-amz-copy-source"
                                              ([],
                                                (String.to_xml v.copy_source)))])
                                       @
                                       [Util.option_map
                                          v.copy_source_if_match
                                          (fun f ->
                                             Ezxmlm.make_tag
                                               "x-amz-copy-source-if-match"
                                               ([], (String.to_xml f)))])
                                      @
                                      [Util.option_map
                                         v.copy_source_if_modified_since
                                         (fun f ->
                                            Ezxmlm.make_tag
                                              "x-amz-copy-source-if-modified-since"
                                              ([], (DateTime.to_xml f)))])
                                     @
                                     [Util.option_map
                                        v.copy_source_if_none_match
                                        (fun f ->
                                           Ezxmlm.make_tag
                                             "x-amz-copy-source-if-none-match"
                                             ([], (String.to_xml f)))])
                                    @
                                    [Util.option_map
                                       v.copy_source_if_unmodified_since
                                       (fun f ->
                                          Ezxmlm.make_tag
                                            "x-amz-copy-source-if-unmodified-since"
                                            ([], (DateTime.to_xml f)))])
                                   @
                                   [Util.option_map v.expires
                                      (fun f ->
                                         Ezxmlm.make_tag "Expires"
                                           ([], (DateTime.to_xml f)))])
                                  @
                                  [Util.option_map v.grant_full_control
                                     (fun f ->
                                        Ezxmlm.make_tag
                                          "x-amz-grant-full-control"
                                          ([], (String.to_xml f)))])
                                 @
                                 [Util.option_map v.grant_read
                                    (fun f ->
                                       Ezxmlm.make_tag "x-amz-grant-read"
                                         ([], (String.to_xml f)))])
                                @
                                [Util.option_map v.grant_read_a_c_p
                                   (fun f ->
                                      Ezxmlm.make_tag "x-amz-grant-read-acp"
                                        ([], (String.to_xml f)))])
                               @
                               [Util.option_map v.grant_write_a_c_p
                                  (fun f ->
                                     Ezxmlm.make_tag "x-amz-grant-write-acp"
                                       ([], (String.to_xml f)))])
                              @
                              [Some
                                 (Ezxmlm.make_tag "Key"
                                    ([], (String.to_xml v.key)))])
                             @
                             [Util.option_map v.metadata
                                (fun f ->
                                   Ezxmlm.make_tag "x-amz-meta-"
                                     ([], (Metadata.to_xml f)))])
                            @
                            [Util.option_map v.metadata_directive
                               (fun f ->
                                  Ezxmlm.make_tag "x-amz-metadata-directive"
                                    ([], (MetadataDirective.to_xml f)))])
                           @
                           [Util.option_map v.tagging_directive
                              (fun f ->
                                 Ezxmlm.make_tag "x-amz-tagging-directive"
                                   ([], (TaggingDirective.to_xml f)))])
                          @
                          [Util.option_map v.server_side_encryption
                             (fun f ->
                                Ezxmlm.make_tag
                                  "x-amz-server-side-encryption"
                                  ([], (ServerSideEncryption.to_xml f)))])
                         @
                         [Util.option_map v.storage_class
                            (fun f ->
                               Ezxmlm.make_tag "x-amz-storage-class"
                                 ([], (StorageClass.to_xml f)))])
                        @
                        [Util.option_map v.website_redirect_location
                           (fun f ->
                              Ezxmlm.make_tag
                                "x-amz-website-redirect-location"
                                ([], (String.to_xml f)))])
                       @
                       [Util.option_map v.s_s_e_customer_algorithm
                          (fun f ->
                             Ezxmlm.make_tag
                               "x-amz-server-side-encryption-customer-algorithm"
                               ([], (String.to_xml f)))])
                      @
                      [Util.option_map v.s_s_e_customer_key
                         (fun f ->
                            Ezxmlm.make_tag
                              "x-amz-server-side-encryption-customer-key"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.s_s_e_customer_key_m_d5
                        (fun f ->
                           Ezxmlm.make_tag
                             "x-amz-server-side-encryption-customer-key-MD5"
                             ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.s_s_e_k_m_s_key_id
                       (fun f ->
                          Ezxmlm.make_tag
                            "x-amz-server-side-encryption-aws-kms-key-id"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.s_s_e_k_m_s_encryption_context
                      (fun f ->
                         Ezxmlm.make_tag
                           "x-amz-server-side-encryption-context"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.copy_source_s_s_e_customer_algorithm
                     (fun f ->
                        Ezxmlm.make_tag
                          "x-amz-copy-source-server-side-encryption-customer-algorithm"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.copy_source_s_s_e_customer_key
                    (fun f ->
                       Ezxmlm.make_tag
                         "x-amz-copy-source-server-side-encryption-customer-key"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.copy_source_s_s_e_customer_key_m_d5
                   (fun f ->
                      Ezxmlm.make_tag
                        "x-amz-copy-source-server-side-encryption-customer-key-MD5"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.request_payer
                  (fun f ->
                     Ezxmlm.make_tag "x-amz-request-payer"
                       ([], (RequestPayer.to_xml f)))])
              @
              [Util.option_map v.tagging
                 (fun f ->
                    Ezxmlm.make_tag "x-amz-tagging" ([], (String.to_xml f)))])
             @
             [Util.option_map v.object_lock_mode
                (fun f ->
                   Ezxmlm.make_tag "x-amz-object-lock-mode"
                     ([], (ObjectLockMode.to_xml f)))])
            @
            [Util.option_map v.object_lock_retain_until_date
               (fun f ->
                  Ezxmlm.make_tag "x-amz-object-lock-retain-until-date"
                    ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.object_lock_legal_hold_status
              (fun f ->
                 Ezxmlm.make_tag "x-amz-object-lock-legal-hold"
                   ([], (ObjectLockLegalHoldStatus.to_xml f)))])
  end
module CopyObjectOutput = CopyObjectOutput
type input = CopyObjectRequest.t
type output = CopyObjectOutput.t
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            ((("/" ^ req.CopyObjectRequest.bucket) ^ "/") ^
               req.CopyObjectRequest.key)))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (CopyObjectRequest.to_query req)))) in
  (`PUT, uri, (Headers.render (CopyObjectRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  match let ((`String body) :
          [ `String of string  | `Streaming of Piaf.Body.t ]) = body[@@ocaml.warning
                                                                    "-8"] in
        try
          let xml = Ezxmlm.from_string body in
          let resp =
            match List.hd (snd xml) with
            | `El (_, xs) -> Some xs
            | _ ->
                raise
                  (Failure "Could not find well formed CopyObjectResult.") in
          try
            let open Error in
              Util.or_error (Util.option_bind resp CopyObjectResult.parse)
                (BadResponse
                   {
                     body;
                     message = "Could not find well formed CopyObjectResult."
                   })
          with
          | Xml.RequiredFieldMissing msg ->
              let open Error in
                `Error
                  (BadResponse
                     {
                       body;
                       message =
                         ("Error parsing CopyObjectResult - missing field in body or children: "
                            ^ msg)
                     })
        with
        | Failure msg ->
            let open Error in
              `Error
                (BadResponse
                   { body; message = ("Error parsing xml: " ^ msg) })
  with
  | `Ok payload -> `Ok (CopyObjectOutput.of_headers headers payload)
  | `Error err -> `Error err
let parse_error code err =
  let errors = [] @ Errors_internal.common in
  match Errors_internal.of_string err with
  | Some v ->
      if
        (List.mem v errors) &&
          ((match Errors_internal.to_http_code v with
            | Some x -> x = code
            | None -> true))
      then Some v
      else None
  | None -> None