open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutBucketEncryptionRequest =
  struct
    type t =
      {
      bucket: String.t
        [@ocaml.doc
          "<p>Specifies default encryption for a bucket using server-side encryption with Amazon S3-managed keys (SSE-S3) or customer master keys stored in AWS KMS (SSE-KMS). For information about the Amazon S3 default encryption feature, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-encryption.html\">Amazon S3 Default Bucket Encryption</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"];
      content_m_d5: String.t option
        [@ocaml.doc
          "<p>The base64-encoded 128-bit MD5 digest of the server-side encryption configuration. This parameter is auto-populated when using the command from the CLI.</p>"];
      server_side_encryption_configuration:
        ServerSideEncryptionConfiguration.t }
    let make ~bucket  ?content_m_d5  ~server_side_encryption_configuration 
      () = { bucket; content_m_d5; server_side_encryption_configuration }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("server_side_encryption_configuration",
                (ServerSideEncryptionConfiguration.to_json
                   v.server_side_encryption_configuration));
           Util.option_map v.content_m_d5
             (fun f -> ("content_m_d5", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse);
          server_side_encryption_configuration =
            (Xml.required "ServerSideEncryptionConfiguration"
               (Util.option_bind
                  (Xml.member "ServerSideEncryptionConfiguration" xml)
                  ServerSideEncryptionConfiguration.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
            @
            [Util.option_map v.content_m_d5
               (fun f ->
                  Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "ServerSideEncryptionConfiguration"
                 ([],
                   (ServerSideEncryptionConfiguration.to_xml
                      v.server_side_encryption_configuration)))])
  end
module Output = Aws.BaseTypes.Unit
type input = PutBucketEncryptionRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/" ^ req.PutBucketEncryptionRequest.bucket) ^ "?encryption")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (PutBucketEncryptionRequest.to_query req)))) in
  (`PUT, uri, (Headers.render (PutBucketEncryptionRequest.to_headers req)),
    (Ezxmlm.to_string
       [Ezxmlm.make_tag "ServerSideEncryptionConfiguration"
          ([],
            (ServerSideEncryptionConfiguration.to_xml
               req.PutBucketEncryptionRequest.server_side_encryption_configuration))]))
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