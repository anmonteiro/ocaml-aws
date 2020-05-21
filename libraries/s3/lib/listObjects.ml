open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListObjectsRequest =
  struct
    type t =
      {
      bucket: String.t
        [@ocaml.doc "<p>The name of the bucket containing the objects.</p>"];
      delimiter: String.t option
        [@ocaml.doc
          "<p>A delimiter is a character you use to group keys.</p>"];
      encoding_type: EncodingType.t option ;
      marker: String.t option
        [@ocaml.doc
          "<p>Specifies the key to start with when listing objects in a bucket.</p>"];
      max_keys: Integer.t option
        [@ocaml.doc
          "<p>Sets the maximum number of keys returned in the response. The response might contain fewer keys but will never contain more.</p>"];
      prefix: String.t option
        [@ocaml.doc
          "<p>Limits the response to keys that begin with the specified prefix.</p>"];
      request_payer: RequestPayer.t option
        [@ocaml.doc
          "<p>Confirms that the requester knows that she or he will be charged for the list objects request. Bucket owners need not specify this parameter in their requests.</p>"]}
    let make ~bucket  ?delimiter  ?encoding_type  ?marker  ?max_keys  ?prefix
       ?request_payer  () =
      {
        bucket;
        delimiter;
        encoding_type;
        marker;
        max_keys;
        prefix;
        request_payer
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.prefix
              (fun f -> Query.Pair ("prefix", (String.to_query f)));
           Util.option_map v.max_keys
             (fun f -> Query.Pair ("max-keys", (Integer.to_query f)));
           Util.option_map v.marker
             (fun f -> Query.Pair ("marker", (String.to_query f)));
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
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)));
           Util.option_map v.max_keys
             (fun f -> ("max_keys", (Integer.to_json f)));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)));
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
          marker = (Util.option_bind (Xml.member "marker" xml) String.parse);
          max_keys =
            (Util.option_bind (Xml.member "max-keys" xml) Integer.parse);
          prefix = (Util.option_bind (Xml.member "prefix" xml) String.parse);
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse)
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
              [Util.option_map v.marker
                 (fun f -> Ezxmlm.make_tag "marker" ([], (String.to_xml f)))])
             @
             [Util.option_map v.max_keys
                (fun f -> Ezxmlm.make_tag "max-keys" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.prefix
               (fun f -> Ezxmlm.make_tag "prefix" ([], (String.to_xml f)))])
           @
           [Util.option_map v.request_payer
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-payer"
                   ([], (RequestPayer.to_xml f)))])
  end
module ListObjectsOutput = ListObjectsOutput
type input = ListObjectsRequest.t
type output = ListObjectsOutput.t
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            ("/" ^ req.ListObjectsRequest.bucket)))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (ListObjectsRequest.to_query req)))) in
  (`GET, uri, (Headers.render (ListObjectsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      match List.hd (snd xml) with
      | `El (_, xs) -> Some xs
      | _ -> raise (Failure "Could not find well formed ListObjectsOutput.") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ListObjectsOutput.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed ListObjectsOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListObjectsOutput - missing field in body or children: "
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