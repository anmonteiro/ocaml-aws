open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module SelectObjectContentRequest =
  struct
    type t =
      {
      bucket: String.t [@ocaml.doc "<p>The S3 bucket.</p>"];
      key: String.t [@ocaml.doc "<p>The object key.</p>"];
      s_s_e_customer_algorithm: String.t option
        [@ocaml.doc
          "<p>The SSE Algorithm used to encrypt the object. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html\">Server-Side Encryption (Using Customer-Provided Encryption Keys</a>. </p>"];
      s_s_e_customer_key: String.t option
        [@ocaml.doc
          "<p>The SSE Customer Key. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html\">Server-Side Encryption (Using Customer-Provided Encryption Keys</a>. </p>"];
      s_s_e_customer_key_m_d5: String.t option
        [@ocaml.doc
          "<p>The SSE Customer Key MD5. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html\">Server-Side Encryption (Using Customer-Provided Encryption Keys</a>. </p>"];
      expression: String.t
        [@ocaml.doc
          "<p>The expression that is used to query the object.</p>"];
      expression_type: ExpressionType.t
        [@ocaml.doc
          "<p>The type of the provided expression (for example, SQL).</p>"];
      request_progress: RequestProgress.t option
        [@ocaml.doc
          "<p>Specifies if periodic request progress information should be enabled.</p>"];
      input_serialization: InputSerialization.t
        [@ocaml.doc
          "<p>Describes the format of the data in the object that is being queried.</p>"];
      output_serialization: OutputSerialization.t
        [@ocaml.doc
          "<p>Describes the format of the data that you want Amazon S3 to return in response.</p>"];
      scan_range: ScanRange.t option
        [@ocaml.doc
          "<p>Specifies the byte range of the object to get the records from. A record is processed when its first byte is contained by the range. This parameter is optional, but when specified, it must not be empty. See RFC 2616, Section 14.35.1 about how to specify the start and end of the range.</p> <p> <code>ScanRange</code>may be used in the following ways:</p> <ul> <li> <p> <code>&lt;scanrange&gt;&lt;start&gt;50&lt;/start&gt;&lt;end&gt;100&lt;/end&gt;&lt;/scanrange&gt;</code> - process only the records starting between the bytes 50 and 100 (inclusive, counting from zero)</p> </li> <li> <p> <code>&lt;scanrange&gt;&lt;start&gt;50&lt;/start&gt;&lt;/scanrange&gt;</code> - process only the records starting after the byte 50</p> </li> <li> <p> <code>&lt;scanrange&gt;&lt;end&gt;50&lt;/end&gt;&lt;/scanrange&gt;</code> - process only the records within the last 50 bytes of the file.</p> </li> </ul>"]}
    [@@ocaml.doc
      "<p>Request to filter the contents of an Amazon S3 object based on a simple Structured Query Language (SQL) statement. In the request, along with the SQL expression, you must specify a data serialization format (JSON or CSV) of the object. Amazon S3 uses this to parse object data into records. It returns only records that match the specified SQL expression. You must also specify the data serialization format for the response. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html\">S3Select API Documentation</a>.</p>"]
    let make ~bucket  ~key  ?s_s_e_customer_algorithm  ?s_s_e_customer_key 
      ?s_s_e_customer_key_m_d5  ~expression  ~expression_type 
      ?request_progress  ~input_serialization  ~output_serialization 
      ?scan_range  () =
      {
        bucket;
        key;
        s_s_e_customer_algorithm;
        s_s_e_customer_key;
        s_s_e_customer_key_m_d5;
        expression;
        expression_type;
        request_progress;
        input_serialization;
        output_serialization;
        scan_range
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.s_s_e_customer_key_m_d5
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
                    (String.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.scan_range
              (fun f -> ("scan_range", (ScanRange.to_json f)));
           Some
             ("output_serialization",
               (OutputSerialization.to_json v.output_serialization));
           Some
             ("input_serialization",
               (InputSerialization.to_json v.input_serialization));
           Util.option_map v.request_progress
             (fun f -> ("request_progress", (RequestProgress.to_json f)));
           Some
             ("expression_type", (ExpressionType.to_json v.expression_type));
           Some ("expression", (String.to_json v.expression));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f -> ("s_s_e_customer_key_m_d5", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key
             (fun f -> ("s_s_e_customer_key", (String.to_json f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f -> ("s_s_e_customer_algorithm", (String.to_json f)));
           Some ("key", (String.to_json v.key));
           Some ("bucket", (String.to_json v.bucket))])
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
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
          expression =
            (Xml.required "Expression"
               (Util.option_bind (Xml.member "Expression" xml) String.parse));
          expression_type =
            (Xml.required "ExpressionType"
               (Util.option_bind (Xml.member "ExpressionType" xml)
                  ExpressionType.parse));
          request_progress =
            (Util.option_bind (Xml.member "RequestProgress" xml)
               RequestProgress.parse);
          input_serialization =
            (Xml.required "InputSerialization"
               (Util.option_bind (Xml.member "InputSerialization" xml)
                  InputSerialization.parse));
          output_serialization =
            (Xml.required "OutputSerialization"
               (Util.option_bind (Xml.member "OutputSerialization" xml)
                  OutputSerialization.parse));
          scan_range =
            (Util.option_bind (Xml.member "ScanRange" xml) ScanRange.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((([] @
                     [Some
                        (Ezxmlm.make_tag "Bucket"
                           ([], (String.to_xml v.bucket)))])
                    @
                    [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
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
                [Some
                   (Ezxmlm.make_tag "Expression"
                      ([], (String.to_xml v.expression)))])
               @
               [Some
                  (Ezxmlm.make_tag "ExpressionType"
                     ([], (ExpressionType.to_xml v.expression_type)))])
              @
              [Util.option_map v.request_progress
                 (fun f ->
                    Ezxmlm.make_tag "RequestProgress"
                      ([], (RequestProgress.to_xml f)))])
             @
             [Some
                (Ezxmlm.make_tag "InputSerialization"
                   ([], (InputSerialization.to_xml v.input_serialization)))])
            @
            [Some
               (Ezxmlm.make_tag "OutputSerialization"
                  ([], (OutputSerialization.to_xml v.output_serialization)))])
           @
           [Util.option_map v.scan_range
              (fun f ->
                 Ezxmlm.make_tag "ScanRange" ([], (ScanRange.to_xml f)))])
  end[@@ocaml.doc
       "<p>Request to filter the contents of an Amazon S3 object based on a simple Structured Query Language (SQL) statement. In the request, along with the SQL expression, you must specify a data serialization format (JSON or CSV) of the object. Amazon S3 uses this to parse object data into records. It returns only records that match the specified SQL expression. You must also specify the data serialization format for the response. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html\">S3Select API Documentation</a>.</p>"]
module SelectObjectContentOutput = SelectObjectContentOutput
type input = SelectObjectContentRequest.t
type output = SelectObjectContentOutput.t
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (((("/" ^ req.SelectObjectContentRequest.bucket) ^ "/") ^
                req.SelectObjectContentRequest.key)
               ^ "?select&select-type=2")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (SelectObjectContentRequest.to_query req)))) in
  (`POST, uri, (Headers.render (SelectObjectContentRequest.to_headers req)),
    "")
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
                  (Failure
                     "Could not find well formed SelectObjectContentEventStream.") in
          try
            let open Error in
              Util.or_error
                (Util.option_bind resp SelectObjectContentEventStream.parse)
                (BadResponse
                   {
                     body;
                     message =
                       "Could not find well formed SelectObjectContentEventStream."
                   })
          with
          | Xml.RequiredFieldMissing msg ->
              let open Error in
                `Error
                  (BadResponse
                     {
                       body;
                       message =
                         ("Error parsing SelectObjectContentEventStream - missing field in body or children: "
                            ^ msg)
                     })
        with
        | Failure msg ->
            let open Error in
              `Error
                (BadResponse
                   { body; message = ("Error parsing xml: " ^ msg) })
  with
  | `Ok payload -> `Ok (SelectObjectContentOutput.of_headers headers payload)
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