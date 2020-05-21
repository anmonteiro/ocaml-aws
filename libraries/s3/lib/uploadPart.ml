open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module UploadPartRequest =
  struct
    type t =
      {
      body: Blob.t option [@ocaml.doc "<p>Object data.</p>"];
      bucket: String.t
        [@ocaml.doc
          "<p>Name of the bucket to which the multipart upload was initiated.</p>"];
      content_length: Long.t option
        [@ocaml.doc
          "<p>Size of the body in bytes. This parameter is useful when the size of the body cannot be determined automatically.</p>"];
      content_m_d5: String.t option
        [@ocaml.doc
          "<p>The base64-encoded 128-bit MD5 digest of the part data. This parameter is auto-populated when using the command from the CLI. This parameter is required if object lock parameters are specified.</p>"];
      key: String.t
        [@ocaml.doc
          "<p>Object key for which the multipart upload was initiated.</p>"];
      part_number: Integer.t
        [@ocaml.doc
          "<p>Part number of part being uploaded. This is a positive integer between 1 and 10,000.</p>"];
      upload_id: String.t
        [@ocaml.doc
          "<p>Upload ID identifying the multipart upload whose part is being uploaded.</p>"];
      s_s_e_customer_algorithm: String.t option
        [@ocaml.doc
          "<p>Specifies the algorithm to use to when encrypting the object (for example, AES256).</p>"];
      s_s_e_customer_key: String.t option
        [@ocaml.doc
          "<p>Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon S3 does not store the encryption key. The key must be appropriate for use with the algorithm specified in the <code>x-amz-server-side\226\128\139-encryption\226\128\139-customer-algorithm header</code>. This must be the same encryption key specified in the initiate multipart upload request.</p>"];
      s_s_e_customer_key_m_d5: String.t option
        [@ocaml.doc
          "<p>Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure that the encryption key was transmitted without error.</p>"];
      request_payer: RequestPayer.t option }
    let make ?body  ~bucket  ?content_length  ?content_m_d5  ~key 
      ~part_number  ~upload_id  ?s_s_e_customer_algorithm 
      ?s_s_e_customer_key  ?s_s_e_customer_key_m_d5  ?request_payer  () =
      {
        body;
        bucket;
        content_length;
        content_m_d5;
        key;
        part_number;
        upload_id;
        s_s_e_customer_algorithm;
        s_s_e_customer_key;
        s_s_e_customer_key_m_d5;
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
           Util.option_map v.content_m_d5
             (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)));
           Util.option_map v.content_length
             (fun f -> Headers.Pair ("Content-Length", (Long.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f -> ("s_s_e_customer_key_m_d5", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key
             (fun f -> ("s_s_e_customer_key", (String.to_json f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f -> ("s_s_e_customer_algorithm", (String.to_json f)));
           Some ("upload_id", (String.to_json v.upload_id));
           Some ("part_number", (Integer.to_json v.part_number));
           Some ("key", (String.to_json v.key));
           Util.option_map v.content_m_d5
             (fun f -> ("content_m_d5", (String.to_json f)));
           Util.option_map v.content_length
             (fun f -> ("content_length", (Long.to_json f)));
           Some ("bucket", (String.to_json v.bucket));
           Util.option_map v.body (fun f -> ("body", (Blob.to_json f)))])
    let parse xml =
      Some
        {
          body = (Util.option_bind (Xml.member "Body" xml) Blob.parse);
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          content_length =
            (Util.option_bind (Xml.member "Content-Length" xml) Long.parse);
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse);
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
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((([] @
                     [Util.option_map v.body
                        (fun f ->
                           Ezxmlm.make_tag "Body" ([], (Blob.to_xml f)))])
                    @
                    [Some
                       (Ezxmlm.make_tag "Bucket"
                          ([], (String.to_xml v.bucket)))])
                   @
                   [Util.option_map v.content_length
                      (fun f ->
                         Ezxmlm.make_tag "Content-Length"
                           ([], (Long.to_xml f)))])
                  @
                  [Util.option_map v.content_m_d5
                     (fun f ->
                        Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
                 @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
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
           [Util.option_map v.request_payer
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-payer"
                   ([], (RequestPayer.to_xml f)))])
  end
module UploadPartOutput = UploadPartOutput
type input = UploadPartRequest.t
type output = UploadPartOutput.t
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            ((("/" ^ req.UploadPartRequest.bucket) ^ "/") ^
               req.UploadPartRequest.key)))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (UploadPartRequest.to_query req)))) in
  (`PUT, uri, (Headers.render (UploadPartRequest.to_headers req)),
    (match req.UploadPartRequest.body with | Some v -> v | None -> ""))
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      match List.hd (snd xml) with
      | `El (_, xs) -> Some xs
      | _ -> raise (Failure "Could not find well formed UploadPartOutput.") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp UploadPartOutput.parse)
          (BadResponse
             { body; message = "Could not find well formed UploadPartOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing UploadPartOutput - missing field in body or children: "
                      ^ msg)
               })
  with
  | Failure msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing xml: " ^ msg) })
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