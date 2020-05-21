open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutObjectRetentionRequest =
  struct
    type t =
      {
      bucket: String.t
        [@ocaml.doc
          "<p>The bucket name that contains the object you want to apply this Object Retention configuration to. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation using an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"];
      key: String.t
        [@ocaml.doc
          "<p>The key name for the object that you want to apply this Object Retention configuration to.</p>"];
      retention: ObjectLockRetention.t option
        [@ocaml.doc
          "<p>The container element for the Object Retention configuration.</p>"];
      request_payer: RequestPayer.t option ;
      version_id: String.t option
        [@ocaml.doc
          "<p>The version ID for the object that you want to apply this Object Retention configuration to.</p>"];
      bypass_governance_retention: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether this operation should bypass Governance-mode restrictions.</p>"];
      content_m_d5: String.t option
        [@ocaml.doc "<p>The MD5 hash for the request body.</p>"]}
    let make ~bucket  ~key  ?retention  ?request_payer  ?version_id 
      ?bypass_governance_retention  ?content_m_d5  () =
      {
        bucket;
        key;
        retention;
        request_payer;
        version_id;
        bypass_governance_retention;
        content_m_d5
      }
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
           Util.option_map v.bypass_governance_retention
             (fun f ->
                Headers.Pair
                  ("x-amz-bypass-governance-retention",
                    (Boolean.to_headers f)));
           Util.option_map v.request_payer
             (fun f ->
                Headers.Pair
                  ("x-amz-request-payer", (RequestPayer.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> ("content_m_d5", (String.to_json f)));
           Util.option_map v.bypass_governance_retention
             (fun f -> ("bypass_governance_retention", (Boolean.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Util.option_map v.request_payer
             (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.retention
             (fun f -> ("retention", (ObjectLockRetention.to_json f)));
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
          retention =
            (Util.option_bind (Xml.member "Retention" xml)
               ObjectLockRetention.parse);
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse);
          version_id =
            (Util.option_bind (Xml.member "versionId" xml) String.parse);
          bypass_governance_retention =
            (Util.option_bind
               (Xml.member "x-amz-bypass-governance-retention" xml)
               Boolean.parse);
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Some
                    (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
                @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
               @
               [Util.option_map v.retention
                  (fun f ->
                     Ezxmlm.make_tag "Retention"
                       ([], (ObjectLockRetention.to_xml f)))])
              @
              [Util.option_map v.request_payer
                 (fun f ->
                    Ezxmlm.make_tag "x-amz-request-payer"
                      ([], (RequestPayer.to_xml f)))])
             @
             [Util.option_map v.version_id
                (fun f -> Ezxmlm.make_tag "versionId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.bypass_governance_retention
               (fun f ->
                  Ezxmlm.make_tag "x-amz-bypass-governance-retention"
                    ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.content_m_d5
              (fun f -> Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
  end
module PutObjectRetentionOutput = PutObjectRetentionOutput
type input = PutObjectRetentionRequest.t
type output = PutObjectRetentionOutput.t
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (((("/" ^ req.PutObjectRetentionRequest.bucket) ^ "/") ^
                req.PutObjectRetentionRequest.key)
               ^ "?retention")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (PutObjectRetentionRequest.to_query req)))) in
  (`PUT, uri, (Headers.render (PutObjectRetentionRequest.to_headers req)),
    (match req.PutObjectRetentionRequest.retention with
     | Some v ->
         Ezxmlm.to_string
           [Ezxmlm.make_tag "Retention" ([], (ObjectLockRetention.to_xml v))]
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
            (Failure "Could not find well formed PutObjectRetentionOutput.") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp PutObjectRetentionOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed PutObjectRetentionOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing PutObjectRetentionOutput - missing field in body or children: "
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