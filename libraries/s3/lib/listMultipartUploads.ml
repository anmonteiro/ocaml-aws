open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListMultipartUploadsRequest =
  struct
    type t =
      {
      bucket: String.t
        [@ocaml.doc
          "<p>Name of the bucket to which the multipart upload was initiated. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation using an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"];
      delimiter: String.t option
        [@ocaml.doc
          "<p>Character you use to group keys.</p> <p>All keys that contain the same string between the prefix, if specified, and the first occurrence of the delimiter after the prefix are grouped under a single result element, <code>CommonPrefixes</code>. If you don't specify the prefix parameter, then the substring starts at the beginning of the key. The keys that are grouped under <code>CommonPrefixes</code> result element are not returned elsewhere in the response.</p>"];
      encoding_type: EncodingType.t option ;
      key_marker: String.t option
        [@ocaml.doc
          "<p>Together with upload-id-marker, this parameter specifies the multipart upload after which listing should begin.</p> <p>If <code>upload-id-marker</code> is not specified, only the keys lexicographically greater than the specified <code>key-marker</code> will be included in the list.</p> <p>If <code>upload-id-marker</code> is specified, any multipart uploads for a key equal to the <code>key-marker</code> might also be included, provided those multipart uploads have upload IDs lexicographically greater than the specified <code>upload-id-marker</code>.</p>"];
      max_uploads: Integer.t option
        [@ocaml.doc
          "<p>Sets the maximum number of multipart uploads, from 1 to 1,000, to return in the response body. 1,000 is the maximum number of uploads that can be returned in a response.</p>"];
      prefix: String.t option
        [@ocaml.doc
          "<p>Lists in-progress uploads only for those keys that begin with the specified prefix. You can use prefixes to separate a bucket into different grouping of keys. (You can think of using prefix to make groups in the same way you'd use a folder in a file system.)</p>"];
      upload_id_marker: String.t option
        [@ocaml.doc
          "<p>Together with key-marker, specifies the multipart upload after which listing should begin. If key-marker is not specified, the upload-id-marker parameter is ignored. Otherwise, any multipart uploads for a key equal to the key-marker might be included in the list only if they have an upload ID lexicographically greater than the specified <code>upload-id-marker</code>.</p>"]}
    let make ~bucket  ?delimiter  ?encoding_type  ?key_marker  ?max_uploads 
      ?prefix  ?upload_id_marker  () =
      {
        bucket;
        delimiter;
        encoding_type;
        key_marker;
        max_uploads;
        prefix;
        upload_id_marker
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.upload_id_marker
              (fun f -> Query.Pair ("upload-id-marker", (String.to_query f)));
           Util.option_map v.prefix
             (fun f -> Query.Pair ("prefix", (String.to_query f)));
           Util.option_map v.max_uploads
             (fun f -> Query.Pair ("max-uploads", (Integer.to_query f)));
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
           [Util.option_map v.upload_id_marker
              (fun f -> ("upload_id_marker", (String.to_json f)));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)));
           Util.option_map v.max_uploads
             (fun f -> ("max_uploads", (Integer.to_json f)));
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
          max_uploads =
            (Util.option_bind (Xml.member "max-uploads" xml) Integer.parse);
          prefix = (Util.option_bind (Xml.member "prefix" xml) String.parse);
          upload_id_marker =
            (Util.option_bind (Xml.member "upload-id-marker" xml)
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
             [Util.option_map v.max_uploads
                (fun f ->
                   Ezxmlm.make_tag "max-uploads" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.prefix
               (fun f -> Ezxmlm.make_tag "prefix" ([], (String.to_xml f)))])
           @
           [Util.option_map v.upload_id_marker
              (fun f ->
                 Ezxmlm.make_tag "upload-id-marker" ([], (String.to_xml f)))])
  end
module ListMultipartUploadsOutput = ListMultipartUploadsOutput
type input = ListMultipartUploadsRequest.t
type output = ListMultipartUploadsOutput.t
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/" ^ req.ListMultipartUploadsRequest.bucket) ^ "?uploads")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (ListMultipartUploadsRequest.to_query req)))) in
  (`GET, uri, (Headers.render (ListMultipartUploadsRequest.to_headers req)),
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
            (Failure "Could not find well formed ListMultipartUploadsOutput.") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ListMultipartUploadsOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ListMultipartUploadsOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListMultipartUploadsOutput - missing field in body or children: "
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