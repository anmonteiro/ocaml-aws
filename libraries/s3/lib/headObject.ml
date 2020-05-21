open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module HeadObjectRequest =
  struct
    type t =
      {
      bucket: String.t
        [@ocaml.doc "<p>The name of the bucket containing the object.</p>"];
      if_match: String.t option
        [@ocaml.doc
          "<p>Return the object only if its entity tag (ETag) is the same as the one specified, otherwise return a 412 (precondition failed).</p>"];
      if_modified_since: DateTime.t option
        [@ocaml.doc
          "<p>Return the object only if it has been modified since the specified time, otherwise return a 304 (not modified).</p>"];
      if_none_match: String.t option
        [@ocaml.doc
          "<p>Return the object only if its entity tag (ETag) is different from the one specified, otherwise return a 304 (not modified).</p>"];
      if_unmodified_since: DateTime.t option
        [@ocaml.doc
          "<p>Return the object only if it has not been modified since the specified time, otherwise return a 412 (precondition failed).</p>"];
      key: String.t [@ocaml.doc "<p>The object key.</p>"];
      range: String.t option
        [@ocaml.doc
          "<p>Downloads the specified range bytes of an object. For more information about the HTTP Range header, see <a href=\"\">http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35</a>.</p>"];
      version_id: String.t option
        [@ocaml.doc
          "<p>VersionId used to reference a specific version of the object.</p>"];
      s_s_e_customer_algorithm: String.t option
        [@ocaml.doc
          "<p>Specifies the algorithm to use to when encrypting the object (for example, AES256).</p>"];
      s_s_e_customer_key: String.t option
        [@ocaml.doc
          "<p>Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon S3 does not store the encryption key. The key must be appropriate for use with the algorithm specified in the <code>x-amz-server-side\226\128\139-encryption\226\128\139-customer-algorithm</code> header.</p>"];
      s_s_e_customer_key_m_d5: String.t option
        [@ocaml.doc
          "<p>Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure that the encryption key was transmitted without error.</p>"];
      request_payer: RequestPayer.t option ;
      part_number: Integer.t option
        [@ocaml.doc
          "<p>Part number of the object being read. This is a positive integer between 1 and 10,000. Effectively performs a 'ranged' HEAD request for the part specified. Useful querying about the size of the part and the number of parts in this object.</p>"]}
    let make ~bucket  ?if_match  ?if_modified_since  ?if_none_match 
      ?if_unmodified_since  ~key  ?range  ?version_id 
      ?s_s_e_customer_algorithm  ?s_s_e_customer_key 
      ?s_s_e_customer_key_m_d5  ?request_payer  ?part_number  () =
      {
        bucket;
        if_match;
        if_modified_since;
        if_none_match;
        if_unmodified_since;
        key;
        range;
        version_id;
        s_s_e_customer_algorithm;
        s_s_e_customer_key;
        s_s_e_customer_key_m_d5;
        request_payer;
        part_number
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.part_number
              (fun f -> Query.Pair ("partNumber", (Integer.to_query f)));
           Util.option_map v.version_id
             (fun f -> Query.Pair ("versionId", (String.to_query f)))])
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
           Util.option_map v.range
             (fun f -> Headers.Pair ("Range", (String.to_headers f)));
           Util.option_map v.if_unmodified_since
             (fun f ->
                Headers.Pair ("If-Unmodified-Since", (DateTime.to_headers f)));
           Util.option_map v.if_none_match
             (fun f -> Headers.Pair ("If-None-Match", (String.to_headers f)));
           Util.option_map v.if_modified_since
             (fun f ->
                Headers.Pair ("If-Modified-Since", (DateTime.to_headers f)));
           Util.option_map v.if_match
             (fun f -> Headers.Pair ("If-Match", (String.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.part_number
              (fun f -> ("part_number", (Integer.to_json f)));
           Util.option_map v.request_payer
             (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f -> ("s_s_e_customer_key_m_d5", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key
             (fun f -> ("s_s_e_customer_key", (String.to_json f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f -> ("s_s_e_customer_algorithm", (String.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Util.option_map v.range (fun f -> ("range", (String.to_json f)));
           Some ("key", (String.to_json v.key));
           Util.option_map v.if_unmodified_since
             (fun f -> ("if_unmodified_since", (DateTime.to_json f)));
           Util.option_map v.if_none_match
             (fun f -> ("if_none_match", (String.to_json f)));
           Util.option_map v.if_modified_since
             (fun f -> ("if_modified_since", (DateTime.to_json f)));
           Util.option_map v.if_match
             (fun f -> ("if_match", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          if_match =
            (Util.option_bind (Xml.member "If-Match" xml) String.parse);
          if_modified_since =
            (Util.option_bind (Xml.member "If-Modified-Since" xml)
               DateTime.parse);
          if_none_match =
            (Util.option_bind (Xml.member "If-None-Match" xml) String.parse);
          if_unmodified_since =
            (Util.option_bind (Xml.member "If-Unmodified-Since" xml)
               DateTime.parse);
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          range = (Util.option_bind (Xml.member "Range" xml) String.parse);
          version_id =
            (Util.option_bind (Xml.member "versionId" xml) String.parse);
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
               RequestPayer.parse);
          part_number =
            (Util.option_bind (Xml.member "partNumber" xml) Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((([] @
                       [Some
                          (Ezxmlm.make_tag "Bucket"
                             ([], (String.to_xml v.bucket)))])
                      @
                      [Util.option_map v.if_match
                         (fun f ->
                            Ezxmlm.make_tag "If-Match"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.if_modified_since
                        (fun f ->
                           Ezxmlm.make_tag "If-Modified-Since"
                             ([], (DateTime.to_xml f)))])
                    @
                    [Util.option_map v.if_none_match
                       (fun f ->
                          Ezxmlm.make_tag "If-None-Match"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.if_unmodified_since
                      (fun f ->
                         Ezxmlm.make_tag "If-Unmodified-Since"
                           ([], (DateTime.to_xml f)))])
                  @
                  [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
                 @
                 [Util.option_map v.range
                    (fun f -> Ezxmlm.make_tag "Range" ([], (String.to_xml f)))])
                @
                [Util.option_map v.version_id
                   (fun f ->
                      Ezxmlm.make_tag "versionId" ([], (String.to_xml f)))])
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
           @
           [Util.option_map v.part_number
              (fun f -> Ezxmlm.make_tag "partNumber" ([], (Integer.to_xml f)))])
  end
module HeadObjectOutput = HeadObjectOutput
type input = HeadObjectRequest.t
type output = HeadObjectOutput.t
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            ((("/" ^ req.HeadObjectRequest.bucket) ^ "/") ^
               req.HeadObjectRequest.key)))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (HeadObjectRequest.to_query req)))) in
  (`HEAD, uri, (Headers.render (HeadObjectRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      match List.hd (snd xml) with
      | `El (_, xs) -> Some xs
      | _ -> raise (Failure "Could not find well formed HeadObjectOutput.") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp HeadObjectOutput.parse)
          (BadResponse
             { body; message = "Could not find well formed HeadObjectOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing HeadObjectOutput - missing field in body or children: "
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