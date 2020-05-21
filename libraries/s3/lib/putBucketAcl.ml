open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutBucketAclRequest =
  struct
    type t =
      {
      a_c_l: BucketCannedACL.t option
        [@ocaml.doc "<p>The canned ACL to apply to the bucket.</p>"];
      access_control_policy: AccessControlPolicy.t option
        [@ocaml.doc
          "<p>Contains the elements that set the ACL permissions for an object per grantee.</p>"];
      bucket: String.t
        [@ocaml.doc "<p>The bucket to which to apply the ACL.</p>"];
      content_m_d5: String.t option
        [@ocaml.doc
          "<p>The base64-encoded 128-bit MD5 digest of the data. This header must be used as a message integrity check to verify that the request body was not corrupted in transit. For more information, go to <a href=\"http://www.ietf.org/rfc/rfc1864.txt\">RFC 1864.</a> </p>"];
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
          "<p>Allows grantee to write the ACL for the applicable bucket.</p>"]}
    let make ?a_c_l  ?access_control_policy  ~bucket  ?content_m_d5 
      ?grant_full_control  ?grant_read  ?grant_read_a_c_p  ?grant_write 
      ?grant_write_a_c_p  () =
      {
        a_c_l;
        access_control_policy;
        bucket;
        content_m_d5;
        grant_full_control;
        grant_read;
        grant_read_a_c_p;
        grant_write;
        grant_write_a_c_p
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.grant_write_a_c_p
              (fun f ->
                 Headers.Pair
                   ("x-amz-grant-write-acp", (String.to_headers f)));
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
                Headers.Pair ("x-amz-acl", (BucketCannedACL.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.grant_write_a_c_p
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
             (fun f -> ("a_c_l", (BucketCannedACL.to_json f)))])
    let parse xml =
      Some
        {
          a_c_l =
            (Util.option_bind (Xml.member "x-amz-acl" xml)
               BucketCannedACL.parse);
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
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Util.option_map v.a_c_l
                      (fun f ->
                         Ezxmlm.make_tag "x-amz-acl"
                           ([], (BucketCannedACL.to_xml f)))])
                  @
                  [Util.option_map v.access_control_policy
                     (fun f ->
                        Ezxmlm.make_tag "AccessControlPolicy"
                          ([], (AccessControlPolicy.to_xml f)))])
                 @
                 [Some
                    (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
                @
                [Util.option_map v.content_m_d5
                   (fun f ->
                      Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
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
                  Ezxmlm.make_tag "x-amz-grant-write" ([], (String.to_xml f)))])
           @
           [Util.option_map v.grant_write_a_c_p
              (fun f ->
                 Ezxmlm.make_tag "x-amz-grant-write-acp"
                   ([], (String.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = PutBucketAclRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/" ^ req.PutBucketAclRequest.bucket) ^ "?acl")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (PutBucketAclRequest.to_query req)))) in
  (`PUT, uri, (Headers.render (PutBucketAclRequest.to_headers req)),
    (match req.PutBucketAclRequest.access_control_policy with
     | Some v ->
         Ezxmlm.to_string
           [Ezxmlm.make_tag "AccessControlPolicy"
              ([], (AccessControlPolicy.to_xml v))]
     | None -> ""))
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) = `Ok ()
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