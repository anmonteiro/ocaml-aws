open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutObjectLegalHoldRequest =
  struct
    type t =
      {
      bucket: String.t
        [@ocaml.doc
          "<p>The bucket name containing the object that you want to place a Legal Hold on. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation using an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"];
      key: String.t
        [@ocaml.doc
          "<p>The key name for the object that you want to place a Legal Hold on.</p>"];
      legal_hold: ObjectLockLegalHold.t option
        [@ocaml.doc
          "<p>Container element for the Legal Hold configuration you want to apply to the specified object.</p>"];
      request_payer: RequestPayer.t option ;
      version_id: String.t option
        [@ocaml.doc
          "<p>The version ID of the object that you want to place a Legal Hold on.</p>"];
      content_m_d5: String.t option
        [@ocaml.doc "<p>The MD5 hash for the request body.</p>"]}
    let make ~bucket  ~key  ?legal_hold  ?request_payer  ?version_id 
      ?content_m_d5  () =
      { bucket; key; legal_hold; request_payer; version_id; content_m_d5 }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f -> Query.Pair ("versionId", (String.to_query f)))])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)));
           Util.option_map v.request_payer
             (fun f ->
                Headers.Pair
                  ("x-amz-request-payer", (RequestPayer.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> ("content_m_d5", (String.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Util.option_map v.request_payer
             (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.legal_hold
             (fun f -> ("legal_hold", (ObjectLockLegalHold.to_json f)));
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
          legal_hold =
            (Util.option_bind (Xml.member "LegalHold" xml)
               ObjectLockLegalHold.parse);
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse);
          version_id =
            (Util.option_bind (Xml.member "versionId" xml) String.parse);
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Some
                   (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
               @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
              @
              [Util.option_map v.legal_hold
                 (fun f ->
                    Ezxmlm.make_tag "LegalHold"
                      ([], (ObjectLockLegalHold.to_xml f)))])
             @
             [Util.option_map v.request_payer
                (fun f ->
                   Ezxmlm.make_tag "x-amz-request-payer"
                     ([], (RequestPayer.to_xml f)))])
            @
            [Util.option_map v.version_id
               (fun f -> Ezxmlm.make_tag "versionId" ([], (String.to_xml f)))])
           @
           [Util.option_map v.content_m_d5
              (fun f -> Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
  end
module PutObjectLegalHoldOutput = PutObjectLegalHoldOutput
type input = PutObjectLegalHoldRequest.t
type output = PutObjectLegalHoldOutput.t
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (((("/" ^ req.PutObjectLegalHoldRequest.bucket) ^ "/") ^
                req.PutObjectLegalHoldRequest.key)
               ^ "?legal-hold")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (PutObjectLegalHoldRequest.to_query req)))) in
  (`PUT, uri, (Headers.render (PutObjectLegalHoldRequest.to_headers req)),
    (match req.PutObjectLegalHoldRequest.legal_hold with
     | Some v ->
         Ezxmlm.to_string
           [Ezxmlm.make_tag "LegalHold" ([], (ObjectLockLegalHold.to_xml v))]
     | None -> ""))
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
            (Failure "Could not find well formed PutObjectLegalHoldOutput.") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp PutObjectLegalHoldOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed PutObjectLegalHoldOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing PutObjectLegalHoldOutput - missing field in body or children: "
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