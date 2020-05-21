open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateBucketRequest =
  struct
    type t =
      {
      a_c_l: BucketCannedACL.t option
        [@ocaml.doc "<p>The canned ACL to apply to the bucket.</p>"];
      bucket: String.t
        [@ocaml.doc "<p>The name of the bucket to create.</p>"];
      create_bucket_configuration: CreateBucketConfiguration.t option
        [@ocaml.doc "<p>The configuration information for the bucket.</p>"];
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
      object_lock_enabled_for_bucket: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether you want S3 Object Lock to be enabled for the new bucket.</p>"]}
    let make ?a_c_l  ~bucket  ?create_bucket_configuration 
      ?grant_full_control  ?grant_read  ?grant_read_a_c_p  ?grant_write 
      ?grant_write_a_c_p  ?object_lock_enabled_for_bucket  () =
      {
        a_c_l;
        bucket;
        create_bucket_configuration;
        grant_full_control;
        grant_read;
        grant_read_a_c_p;
        grant_write;
        grant_write_a_c_p;
        object_lock_enabled_for_bucket
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.object_lock_enabled_for_bucket
              (fun f ->
                 Headers.Pair
                   ("x-amz-bucket-object-lock-enabled",
                     (Boolean.to_headers f)));
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
           Util.option_map v.a_c_l
             (fun f ->
                Headers.Pair ("x-amz-acl", (BucketCannedACL.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.object_lock_enabled_for_bucket
              (fun f ->
                 ("object_lock_enabled_for_bucket", (Boolean.to_json f)));
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
           Util.option_map v.create_bucket_configuration
             (fun f ->
                ("create_bucket_configuration",
                  (CreateBucketConfiguration.to_json f)));
           Some ("bucket", (String.to_json v.bucket));
           Util.option_map v.a_c_l
             (fun f -> ("a_c_l", (BucketCannedACL.to_json f)))])
    let parse xml =
      Some
        {
          a_c_l =
            (Util.option_bind (Xml.member "x-amz-acl" xml)
               BucketCannedACL.parse);
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          create_bucket_configuration =
            (Util.option_bind (Xml.member "CreateBucketConfiguration" xml)
               CreateBucketConfiguration.parse);
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
          object_lock_enabled_for_bucket =
            (Util.option_bind
               (Xml.member "x-amz-bucket-object-lock-enabled" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Util.option_map v.a_c_l
                      (fun f ->
                         Ezxmlm.make_tag "x-amz-acl"
                           ([], (BucketCannedACL.to_xml f)))])
                  @
                  [Some
                     (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
                 @
                 [Util.option_map v.create_bucket_configuration
                    (fun f ->
                       Ezxmlm.make_tag "CreateBucketConfiguration"
                         ([], (CreateBucketConfiguration.to_xml f)))])
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
           @
           [Util.option_map v.object_lock_enabled_for_bucket
              (fun f ->
                 Ezxmlm.make_tag "x-amz-bucket-object-lock-enabled"
                   ([], (Boolean.to_xml f)))])
  end
module CreateBucketOutput = CreateBucketOutput
type input = CreateBucketRequest.t
type output = CreateBucketOutput.t
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            ("/" ^ req.CreateBucketRequest.bucket)))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (CreateBucketRequest.to_query req)))) in
  (`PUT, uri, (Headers.render (CreateBucketRequest.to_headers req)),
    (match req.CreateBucketRequest.create_bucket_configuration with
     | Some v ->
         Ezxmlm.to_string
           [Ezxmlm.make_tag "CreateBucketConfiguration"
              ([], (CreateBucketConfiguration.to_xml v))]
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
      | _ -> raise (Failure "Could not find well formed CreateBucketOutput.") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateBucketOutput.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed CreateBucketOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateBucketOutput - missing field in body or children: "
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