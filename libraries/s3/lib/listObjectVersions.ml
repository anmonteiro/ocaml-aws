open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListObjectVersionsRequest =
  struct
    type t =
      {
      bucket: String.t
        [@ocaml.doc
          "<p>The bucket name that contains the objects. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation using an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"];
      delimiter: String.t option
        [@ocaml.doc
          "<p>A delimiter is a character that you specify to group keys. All keys that contain the same string between the <code>prefix</code> and the first occurrence of the delimiter are grouped under a single result element in CommonPrefixes. These groups are counted as one result against the max-keys limitation. These keys are not returned elsewhere in the response.</p>"];
      encoding_type: EncodingType.t option ;
      key_marker: String.t option
        [@ocaml.doc
          "<p>Specifies the key to start with when listing objects in a bucket.</p>"];
      max_keys: Integer.t option
        [@ocaml.doc
          "<p>Sets the maximum number of keys returned in the response. The response might contain fewer keys but will never contain more. If additional keys satisfy the search criteria, but were not returned because max-keys was exceeded, the response contains &lt;isTruncated&gt;true&lt;/isTruncated&gt;. To return the additional keys, see key-marker and version-id-marker.</p>"];
      prefix: String.t option
        [@ocaml.doc
          "<p>Use this parameter to select only those keys that begin with the specified prefix. You can use prefixes to separate a bucket into different groupings of keys. (You can think of using prefix to make groups in the same way you'd use a folder in a file system.) You can use prefix with delimiter to roll up numerous objects into a single result under CommonPrefixes. </p>"];
      version_id_marker: String.t option
        [@ocaml.doc
          "<p>Specifies the object version you want to start listing from.</p>"]}
    let make ~bucket  ?delimiter  ?encoding_type  ?key_marker  ?max_keys 
      ?prefix  ?version_id_marker  () =
      {
        bucket;
        delimiter;
        encoding_type;
        key_marker;
        max_keys;
        prefix;
        version_id_marker
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.version_id_marker
              (fun f -> Query.Pair ("version-id-marker", (String.to_query f)));
           Util.option_map v.prefix
             (fun f -> Query.Pair ("prefix", (String.to_query f)));
           Util.option_map v.max_keys
             (fun f -> Query.Pair ("max-keys", (Integer.to_query f)));
           Util.option_map v.key_marker
             (fun f -> Query.Pair ("key-marker", (String.to_query f)));
           Util.option_map v.encoding_type
             (fun f ->
                Query.Pair ("encoding-type", (EncodingType.to_query f)));
           Util.option_map v.delimiter
             (fun f -> Query.Pair ("delimiter", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.version_id_marker
              (fun f -> ("version_id_marker", (String.to_json f)));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)));
           Util.option_map v.max_keys
             (fun f -> ("max_keys", (Integer.to_json f)));
           Util.option_map v.key_marker
             (fun f -> ("key_marker", (String.to_json f)));
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
          key_marker =
            (Util.option_bind (Xml.member "key-marker" xml) String.parse);
          max_keys =
            (Util.option_bind (Xml.member "max-keys" xml) Integer.parse);
          prefix = (Util.option_bind (Xml.member "prefix" xml) String.parse);
          version_id_marker =
            (Util.option_bind (Xml.member "version-id-marker" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Some
                    (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
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
              [Util.option_map v.key_marker
                 (fun f ->
                    Ezxmlm.make_tag "key-marker" ([], (String.to_xml f)))])
             @
             [Util.option_map v.max_keys
                (fun f -> Ezxmlm.make_tag "max-keys" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.prefix
               (fun f -> Ezxmlm.make_tag "prefix" ([], (String.to_xml f)))])
           @
           [Util.option_map v.version_id_marker
              (fun f ->
                 Ezxmlm.make_tag "version-id-marker" ([], (String.to_xml f)))])
  end
module ListObjectVersionsOutput = ListObjectVersionsOutput
type input = ListObjectVersionsRequest.t
type output = ListObjectVersionsOutput.t
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/" ^ req.ListObjectVersionsRequest.bucket) ^ "?versions")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (ListObjectVersionsRequest.to_query req)))) in
  (`GET, uri, (Headers.render (ListObjectVersionsRequest.to_headers req)),
    "")
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
          raise
            (Failure "Could not find well formed ListObjectVersionsOutput.") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ListObjectVersionsOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ListObjectVersionsOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListObjectVersionsOutput - missing field in body or children: "
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