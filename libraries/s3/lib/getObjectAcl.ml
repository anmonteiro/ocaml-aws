open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetObjectAclRequest =
  struct
    type t =
      {
      bucket: String.t
        [@ocaml.doc
          "<p>The bucket name that contains the object for which to get the ACL information. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation using an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"];
      key: String.t
        [@ocaml.doc
          "<p>The key of the object for which to get the ACL information.</p>"];
      version_id: String.t option
        [@ocaml.doc
          "<p>VersionId used to reference a specific version of the object.</p>"];
      request_payer: RequestPayer.t option }
    let make ~bucket  ~key  ?version_id  ?request_payer  () =
      { bucket; key; version_id; request_payer }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f -> Query.Pair ("versionId", (String.to_query f)))])
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
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
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
          version_id =
            (Util.option_bind (Xml.member "versionId" xml) String.parse);
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
             @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
            @
            [Util.option_map v.version_id
               (fun f -> Ezxmlm.make_tag "versionId" ([], (String.to_xml f)))])
           @
           [Util.option_map v.request_payer
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-payer"
                   ([], (RequestPayer.to_xml f)))])
  end
module GetObjectAclOutput = GetObjectAclOutput
type input = GetObjectAclRequest.t
type output = GetObjectAclOutput.t
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (((("/" ^ req.GetObjectAclRequest.bucket) ^ "/") ^
                req.GetObjectAclRequest.key)
               ^ "?acl")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (GetObjectAclRequest.to_query req)))) in
  (`GET, uri, (Headers.render (GetObjectAclRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      match List.hd (snd xml) with
      | `El (_, xs) -> Some xs
      | _ -> raise (Failure "Could not find well formed GetObjectAclOutput.") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp GetObjectAclOutput.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed GetObjectAclOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing GetObjectAclOutput - missing field in body or children: "
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