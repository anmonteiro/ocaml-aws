open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListObjectsV2Request =
  struct
    type t =
      {
      bucket: String.t
        [@ocaml.doc
          "<p>Bucket name to list. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation using an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"];
      delimiter: String.t option
        [@ocaml.doc
          "<p>A delimiter is a character you use to group keys.</p>"];
      encoding_type: EncodingType.t option
        [@ocaml.doc
          "<p>Encoding type used by Amazon S3 to encode object keys in the response.</p>"];
      max_keys: Integer.t option
        [@ocaml.doc
          "<p>Sets the maximum number of keys returned in the response. The response might contain fewer keys but will never contain more.</p>"];
      prefix: String.t option
        [@ocaml.doc
          "<p>Limits the response to keys that begin with the specified prefix.</p>"];
      continuation_token: String.t option
        [@ocaml.doc
          "<p>ContinuationToken indicates Amazon S3 that the list is being continued on this bucket with a token. ContinuationToken is obfuscated and is not a real key.</p>"];
      fetch_owner: Boolean.t option
        [@ocaml.doc
          "<p>The owner field is not present in listV2 by default, if you want to return owner field with each key in the result then set the fetch owner field to true.</p>"];
      start_after: String.t option
        [@ocaml.doc
          "<p>StartAfter is where you want Amazon S3 to start listing from. Amazon S3 starts listing after this specified key. StartAfter can be any key in the bucket.</p>"];
      request_payer: RequestPayer.t option
        [@ocaml.doc
          "<p>Confirms that the requester knows that she or he will be charged for the list objects request in V2 style. Bucket owners need not specify this parameter in their requests.</p>"]}
    let make ~bucket  ?delimiter  ?encoding_type  ?max_keys  ?prefix 
      ?continuation_token  ?fetch_owner  ?start_after  ?request_payer  () =
      {
        bucket;
        delimiter;
        encoding_type;
        max_keys;
        prefix;
        continuation_token;
        fetch_owner;
        start_after;
        request_payer
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.start_after
              (fun f -> Query.Pair ("start-after", (String.to_query f)));
           Util.option_map v.fetch_owner
             (fun f -> Query.Pair ("fetch-owner", (Boolean.to_query f)));
           Util.option_map v.continuation_token
             (fun f -> Query.Pair ("continuation-token", (String.to_query f)));
           Util.option_map v.prefix
             (fun f -> Query.Pair ("prefix", (String.to_query f)));
           Util.option_map v.max_keys
             (fun f -> Query.Pair ("max-keys", (Integer.to_query f)));
           Util.option_map v.encoding_type
             (fun f ->
                Query.Pair ("encoding-type", (EncodingType.to_query f)));
           Util.option_map v.delimiter
             (fun f -> Query.Pair ("delimiter", (String.to_query f)))])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-payer", (RequestPayer.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.start_after
             (fun f -> ("start_after", (String.to_json f)));
           Util.option_map v.fetch_owner
             (fun f -> ("fetch_owner", (Boolean.to_json f)));
           Util.option_map v.continuation_token
             (fun f -> ("continuation_token", (String.to_json f)));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)));
           Util.option_map v.max_keys
             (fun f -> ("max_keys", (Integer.to_json f)));
           Util.option_map v.encoding_type
             (fun f -> ("encoding_type", (EncodingType.to_json f)));
           Util.option_map v.delimiter
             (fun f -> ("delimiter", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          delimiter =
            (Util.option_bind (Xml.member "delimiter" xml) String.parse);
          encoding_type =
            (Util.option_bind (Xml.member "encoding-type" xml)
               EncodingType.parse);
          max_keys =
            (Util.option_bind (Xml.member "max-keys" xml) Integer.parse);
          prefix = (Util.option_bind (Xml.member "prefix" xml) String.parse);
          continuation_token =
            (Util.option_bind (Xml.member "continuation-token" xml)
               String.parse);
          fetch_owner =
            (Util.option_bind (Xml.member "fetch-owner" xml) Boolean.parse);
          start_after =
            (Util.option_bind (Xml.member "start-after" xml) String.parse);
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Some
                      (Ezxmlm.make_tag "Bucket"
                         ([], (String.to_xml v.bucket)))])
                  @
                  [Util.option_map v.delimiter
                     (fun f ->
                        Ezxmlm.make_tag "delimiter" ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.encoding_type
                    (fun f ->
                       Ezxmlm.make_tag "encoding-type"
                         ([], (EncodingType.to_xml f)))])
                @
                [Util.option_map v.max_keys
                   (fun f ->
                      Ezxmlm.make_tag "max-keys" ([], (Integer.to_xml f)))])
               @
               [Util.option_map v.prefix
                  (fun f -> Ezxmlm.make_tag "prefix" ([], (String.to_xml f)))])
              @
              [Util.option_map v.continuation_token
                 (fun f ->
                    Ezxmlm.make_tag "continuation-token"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.fetch_owner
                (fun f ->
                   Ezxmlm.make_tag "fetch-owner" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.start_after
               (fun f ->
                  Ezxmlm.make_tag "start-after" ([], (String.to_xml f)))])
           @
           [Util.option_map v.request_payer
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-payer"
                   ([], (RequestPayer.to_xml f)))])
  end
module ListObjectsV2Output = ListObjectsV2Output
type input = ListObjectsV2Request.t
type output = ListObjectsV2Output.t
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/" ^ req.ListObjectsV2Request.bucket) ^ "?list-type=2")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (ListObjectsV2Request.to_query req)))) in
  (`GET, uri, (Headers.render (ListObjectsV2Request.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      match List.hd (snd xml) with
      | `El (_, xs) -> Some xs
      | _ ->
          raise (Failure "Could not find well formed ListObjectsV2Output.") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ListObjectsV2Output.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed ListObjectsV2Output."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListObjectsV2Output - missing field in body or children: "
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