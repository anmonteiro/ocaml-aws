open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutObjectAclRequest =
  struct
    type t =
      {
      a_c_l: ObjectCannedACL.t option
        [@ocaml.doc
          "<p>The canned ACL to apply to the object. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#CannedACL\">Canned ACL</a>.</p>"];
      access_control_policy: AccessControlPolicy.t option
        [@ocaml.doc
          "<p>Contains the elements that set the ACL permissions for an object per grantee.</p>"];
      bucket: String.t
        [@ocaml.doc
          "<p>The bucket name that contains the object to which you want to attach the ACL. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation using an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"];
      content_m_d5: String.t option
        [@ocaml.doc
          "<p>The base64-encoded 128-bit MD5 digest of the data. This header must be used as a message integrity check to verify that the request body was not corrupted in transit. For more information, go to <a href=\"http://www.ietf.org/rfc/rfc1864.txt\">RFC 1864.&gt;</a> </p>"];
      grant_full_control: String.t option
        [@ocaml.doc
          "<p>Allows grantee the read, write, read ACP, and write ACP permissions on the bucket.</p>"];
      grant_read: String.t option
        [@ocaml.doc
          "<p>Allows grantee to list the objects in the bucket.</p>"];
      grant_read_a_c_p: String.t option
        [@ocaml.doc "<p>Allows grantee to read the bucket ACL.</p>"];
      grant_write: String.t option
        [@ocaml.doc
          "<p>Allows grantee to create, overwrite, and delete any object in the bucket.</p>"];
      grant_write_a_c_p: String.t option
        [@ocaml.doc
          "<p>Allows grantee to write the ACL for the applicable bucket.</p>"];
      key: String.t
        [@ocaml.doc "<p>Key for which the PUT operation was initiated.</p>"];
      request_payer: RequestPayer.t option ;
      version_id: String.t option
        [@ocaml.doc
          "<p>VersionId used to reference a specific version of the object.</p>"]}
    let make ?a_c_l  ?access_control_policy  ~bucket  ?content_m_d5 
      ?grant_full_control  ?grant_read  ?grant_read_a_c_p  ?grant_write 
      ?grant_write_a_c_p  ~key  ?request_payer  ?version_id  () =
      {
        a_c_l;
        access_control_policy;
        bucket;
        content_m_d5;
        grant_full_control;
        grant_read;
        grant_read_a_c_p;
        grant_write;
        grant_write_a_c_p;
        key;
        request_payer;
        version_id
      }
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
                   ("x-amz-request-payer", (RequestPayer.to_headers f)));
           Util.option_map v.grant_write_a_c_p
             (fun f ->
                Headers.Pair ("x-amz-grant-write-acp", (String.to_headers f)));
           Util.option_map v.grant_write
             (fun f ->
                Headers.Pair ("x-amz-grant-write", (String.to_headers f)));
           Util.option_map v.grant_read_a_c_p
             (fun f ->
                Headers.Pair ("x-amz-grant-read-acp", (String.to_headers f)));
           Util.option_map v.grant_read
             (fun f ->
                Headers.Pair ("x-amz-grant-read", (String.to_headers f)));
           Util.option_map v.grant_full_control
             (fun f ->
                Headers.Pair
                  ("x-amz-grant-full-control", (String.to_headers f)));
           Util.option_map v.content_m_d5
             (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)));
           Util.option_map v.a_c_l
             (fun f ->
                Headers.Pair ("x-amz-acl", (ObjectCannedACL.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f -> ("version_id", (String.to_json f)));
           Util.option_map v.request_payer
             (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Some ("key", (String.to_json v.key));
           Util.option_map v.grant_write_a_c_p
             (fun f -> ("grant_write_a_c_p", (String.to_json f)));
           Util.option_map v.grant_write
             (fun f -> ("grant_write", (String.to_json f)));
           Util.option_map v.grant_read_a_c_p
             (fun f -> ("grant_read_a_c_p", (String.to_json f)));
           Util.option_map v.grant_read
             (fun f -> ("grant_read", (String.to_json f)));
           Util.option_map v.grant_full_control
             (fun f -> ("grant_full_control", (String.to_json f)));
           Util.option_map v.content_m_d5
             (fun f -> ("content_m_d5", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket));
           Util.option_map v.access_control_policy
             (fun f ->
                ("access_control_policy", (AccessControlPolicy.to_json f)));
           Util.option_map v.a_c_l
             (fun f -> ("a_c_l", (ObjectCannedACL.to_json f)))])
    let parse xml =
      Some
        {
          a_c_l =
            (Util.option_bind (Xml.member "x-amz-acl" xml)
               ObjectCannedACL.parse);
          access_control_policy =
            (Util.option_bind (Xml.member "AccessControlPolicy" xml)
               AccessControlPolicy.parse);
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse);
          grant_full_control =
            (Util.option_bind (Xml.member "x-amz-grant-full-control" xml)
               String.parse);
          grant_read =
            (Util.option_bind (Xml.member "x-amz-grant-read" xml)
               String.parse);
          grant_read_a_c_p =
            (Util.option_bind (Xml.member "x-amz-grant-read-acp" xml)
               String.parse);
          grant_write =
            (Util.option_bind (Xml.member "x-amz-grant-write" xml)
               String.parse);
          grant_write_a_c_p =
            (Util.option_bind (Xml.member "x-amz-grant-write-acp" xml)
               String.parse);
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse);
          version_id =
            (Util.option_bind (Xml.member "versionId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((([] @
                      [Util.option_map v.a_c_l
                         (fun f ->
                            Ezxmlm.make_tag "x-amz-acl"
                              ([], (ObjectCannedACL.to_xml f)))])
                     @
                     [Util.option_map v.access_control_policy
                        (fun f ->
                           Ezxmlm.make_tag "AccessControlPolicy"
                             ([], (AccessControlPolicy.to_xml f)))])
                    @
                    [Some
                       (Ezxmlm.make_tag "Bucket"
                          ([], (String.to_xml v.bucket)))])
                   @
                   [Util.option_map v.content_m_d5
                      (fun f ->
                         Ezxmlm.make_tag "Content-MD5"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.grant_full_control
                     (fun f ->
                        Ezxmlm.make_tag "x-amz-grant-full-control"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.grant_read
                    (fun f ->
                       Ezxmlm.make_tag "x-amz-grant-read"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.grant_read_a_c_p
                   (fun f ->
                      Ezxmlm.make_tag "x-amz-grant-read-acp"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.grant_write
                  (fun f ->
                     Ezxmlm.make_tag "x-amz-grant-write"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.grant_write_a_c_p
                 (fun f ->
                    Ezxmlm.make_tag "x-amz-grant-write-acp"
                      ([], (String.to_xml f)))])
             @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
            @
            [Util.option_map v.request_payer
               (fun f ->
                  Ezxmlm.make_tag "x-amz-request-payer"
                    ([], (RequestPayer.to_xml f)))])
           @
           [Util.option_map v.version_id
              (fun f -> Ezxmlm.make_tag "versionId" ([], (String.to_xml f)))])
  end
module PutObjectAclOutput = PutObjectAclOutput
type input = PutObjectAclRequest.t
type output = PutObjectAclOutput.t
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (((("/" ^ req.PutObjectAclRequest.bucket) ^ "/") ^
                req.PutObjectAclRequest.key)
               ^ "?acl")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (PutObjectAclRequest.to_query req)))) in
  (`PUT, uri, (Headers.render (PutObjectAclRequest.to_headers req)),
    (match req.PutObjectAclRequest.access_control_policy with
     | Some v ->
         Ezxmlm.to_string
           [Ezxmlm.make_tag "AccessControlPolicy"
              ([], (AccessControlPolicy.to_xml v))]
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
      | _ -> raise (Failure "Could not find well formed PutObjectAclOutput.") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp PutObjectAclOutput.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed PutObjectAclOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing PutObjectAclOutput - missing field in body or children: "
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