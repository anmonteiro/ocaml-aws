open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module UploadPartCopyRequest =
  struct
    type t =
      {
      bucket: String.t [@ocaml.doc "<p>The bucket name.</p>"];
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
      copy_source_range: String.t option
        [@ocaml.doc
          "<p>The range of bytes to copy from the source object. The range value must use the form bytes=first-last, where the first and last are the zero-based byte offsets to copy. For example, bytes=0-9 indicates that you want to copy the first 10 bytes of the source. You can copy a range only if the source object is greater than 5 MB.</p>"];
      key: String.t
        [@ocaml.doc
          "<p>Object key for which the multipart upload was initiated.</p>"];
      part_number: Integer.t
        [@ocaml.doc
          "<p>Part number of part being copied. This is a positive integer between 1 and 10,000.</p>"];
      upload_id: String.t
        [@ocaml.doc
          "<p>Upload ID identifying the multipart upload whose part is being copied.</p>"];
      s_s_e_customer_algorithm: String.t option
        [@ocaml.doc
          "<p>Specifies the algorithm to use to when encrypting the object (for example, AES256).</p>"];
      s_s_e_customer_key: String.t option
        [@ocaml.doc
          "<p>Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon S3 does not store the encryption key. The key must be appropriate for use with the algorithm specified in the <code>x-amz-server-side\226\128\139-encryption\226\128\139-customer-algorithm</code> header. This must be the same encryption key specified in the initiate multipart upload request.</p>"];
      s_s_e_customer_key_m_d5: String.t option
        [@ocaml.doc
          "<p>Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure that the encryption key was transmitted without error.</p>"];
      copy_source_s_s_e_customer_algorithm: String.t option
        [@ocaml.doc
          "<p>Specifies the algorithm to use when decrypting the source object (for example, AES256).</p>"];
      copy_source_s_s_e_customer_key: String.t option
        [@ocaml.doc
          "<p>Specifies the customer-provided encryption key for Amazon S3 to use to decrypt the source object. The encryption key provided in this header must be one that was used when the source object was created.</p>"];
      copy_source_s_s_e_customer_key_m_d5: String.t option
        [@ocaml.doc
          "<p>Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure that the encryption key was transmitted without error.</p>"];
      request_payer: RequestPayer.t option }
    let make ~bucket  ~copy_source  ?copy_source_if_match 
      ?copy_source_if_modified_since  ?copy_source_if_none_match 
      ?copy_source_if_unmodified_since  ?copy_source_range  ~key 
      ~part_number  ~upload_id  ?s_s_e_customer_algorithm 
      ?s_s_e_customer_key  ?s_s_e_customer_key_m_d5 
      ?copy_source_s_s_e_customer_algorithm  ?copy_source_s_s_e_customer_key 
      ?copy_source_s_s_e_customer_key_m_d5  ?request_payer  () =
      {
        bucket;
        copy_source;
        copy_source_if_match;
        copy_source_if_modified_since;
        copy_source_if_none_match;
        copy_source_if_unmodified_since;
        copy_source_range;
        key;
        part_number;
        upload_id;
        s_s_e_customer_algorithm;
        s_s_e_customer_key;
        s_s_e_customer_key_m_d5;
        copy_source_s_s_e_customer_algorithm;
        copy_source_s_s_e_customer_key;
        copy_source_s_s_e_customer_key_m_d5;
        request_payer
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("uploadId", (String.to_query v.upload_id)));
           Some (Query.Pair ("partNumber", (Integer.to_query v.part_number)))])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_payer
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
           Util.option_map v.copy_source_range
             (fun f ->
                Headers.Pair
                  ("x-amz-copy-source-range", (String.to_headers f)));
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
                ("x-amz-copy-source", (String.to_headers v.copy_source)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.copy_source_s_s_e_customer_key_m_d5
             (fun f ->
                ("copy_source_s_s_e_customer_key_m_d5", (String.to_json f)));
           Util.option_map v.copy_source_s_s_e_customer_key
             (fun f -> ("copy_source_s_s_e_customer_key", (String.to_json f)));
           Util.option_map v.copy_source_s_s_e_customer_algorithm
             (fun f ->
                ("copy_source_s_s_e_customer_algorithm", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f -> ("s_s_e_customer_key_m_d5", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key
             (fun f -> ("s_s_e_customer_key", (String.to_json f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f -> ("s_s_e_customer_algorithm", (String.to_json f)));
           Some ("upload_id", (String.to_json v.upload_id));
           Some ("part_number", (Integer.to_json v.part_number));
           Some ("key", (String.to_json v.key));
           Util.option_map v.copy_source_range
             (fun f -> ("copy_source_range", (String.to_json f)));
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
           Some ("bucket", (String.to_json v.bucket))])
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
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
          copy_source_range =
            (Util.option_bind (Xml.member "x-amz-copy-source-range" xml)
               String.parse);
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          part_number =
            (Xml.required "partNumber"
               (Util.option_bind (Xml.member "partNumber" xml) Integer.parse));
          upload_id =
            (Xml.required "uploadId"
               (Util.option_bind (Xml.member "uploadId" xml) String.parse));
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
               RequestPayer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((((([] @
                           [Some
                              (Ezxmlm.make_tag "Bucket"
                                 ([], (String.to_xml v.bucket)))])
                          @
                          [Some
                             (Ezxmlm.make_tag "x-amz-copy-source"
                                ([], (String.to_xml v.copy_source)))])
                         @
                         [Util.option_map v.copy_source_if_match
                            (fun f ->
                               Ezxmlm.make_tag "x-amz-copy-source-if-match"
                                 ([], (String.to_xml f)))])
                        @
                        [Util.option_map v.copy_source_if_modified_since
                           (fun f ->
                              Ezxmlm.make_tag
                                "x-amz-copy-source-if-modified-since"
                                ([], (DateTime.to_xml f)))])
                       @
                       [Util.option_map v.copy_source_if_none_match
                          (fun f ->
                             Ezxmlm.make_tag
                               "x-amz-copy-source-if-none-match"
                               ([], (String.to_xml f)))])
                      @
                      [Util.option_map v.copy_source_if_unmodified_since
                         (fun f ->
                            Ezxmlm.make_tag
                              "x-amz-copy-source-if-unmodified-since"
                              ([], (DateTime.to_xml f)))])
                     @
                     [Util.option_map v.copy_source_range
                        (fun f ->
                           Ezxmlm.make_tag "x-amz-copy-source-range"
                             ([], (String.to_xml f)))])
                    @
                    [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
                   @
                   [Some
                      (Ezxmlm.make_tag "partNumber"
                         ([], (Integer.to_xml v.part_number)))])
                  @
                  [Some
                     (Ezxmlm.make_tag "uploadId"
                        ([], (String.to_xml v.upload_id)))])
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
  end
module UploadPartCopyOutput = UploadPartCopyOutput
type input = UploadPartCopyRequest.t
type output = UploadPartCopyOutput.t
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            ((("/" ^ req.UploadPartCopyRequest.bucket) ^ "/") ^
               req.UploadPartCopyRequest.key)))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (UploadPartCopyRequest.to_query req)))) in
  (`PUT, uri, (Headers.render (UploadPartCopyRequest.to_headers req)), "")
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
                raise (Failure "Could not find well formed CopyPartResult.") in
          try
            let open Error in
              Util.or_error (Util.option_bind resp CopyPartResult.parse)
                (BadResponse
                   {
                     body;
                     message = "Could not find well formed CopyPartResult."
                   })
          with
          | Xml.RequiredFieldMissing msg ->
              let open Error in
                `Error
                  (BadResponse
                     {
                       body;
                       message =
                         ("Error parsing CopyPartResult - missing field in body or children: "
                            ^ msg)
                     })
        with
        | Failure msg ->
            let open Error in
              `Error
                (BadResponse
                   { body; message = ("Error parsing xml: " ^ msg) })
  with
  | `Ok payload -> `Ok (UploadPartCopyOutput.of_headers headers payload)
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