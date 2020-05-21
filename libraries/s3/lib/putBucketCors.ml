open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutBucketCorsRequest =
  struct
    type t =
      {
      bucket: String.t
        [@ocaml.doc
          "<p>Specifies the bucket impacted by the <code>cors</code>configuration.</p>"];
      c_o_r_s_configuration: CORSConfiguration.t
        [@ocaml.doc
          "<p>Describes the cross-origin access configuration for objects in an Amazon S3 bucket. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev//cors.html\">Enabling Cross-Origin Resource Sharing</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"];
      content_m_d5: String.t option
        [@ocaml.doc
          "<p>The base64-encoded 128-bit MD5 digest of the data. This header must be used as a message integrity check to verify that the request body was not corrupted in transit. For more information, go to <a href=\"http://www.ietf.org/rfc/rfc1864.txt\">RFC 1864.</a> </p>"]}
    let make ~bucket  ~c_o_r_s_configuration  ?content_m_d5  () =
      { bucket; c_o_r_s_configuration; content_m_d5 }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> ("content_m_d5", (String.to_json f)));
           Some
             ("c_o_r_s_configuration",
               (CORSConfiguration.to_json v.c_o_r_s_configuration));
           Some ("bucket", (String.to_json v.bucket))])
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          c_o_r_s_configuration =
            (Xml.required "CORSConfiguration"
               (Util.option_bind (Xml.member "CORSConfiguration" xml)
                  CORSConfiguration.parse));
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
            @
            [Some
               (Ezxmlm.make_tag "CORSConfiguration"
                  ([], (CORSConfiguration.to_xml v.c_o_r_s_configuration)))])
           @
           [Util.option_map v.content_m_d5
              (fun f -> Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = PutBucketCorsRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/" ^ req.PutBucketCorsRequest.bucket) ^ "?cors")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (PutBucketCorsRequest.to_query req)))) in
  (`PUT, uri, (Headers.render (PutBucketCorsRequest.to_headers req)),
    (Ezxmlm.to_string
       [Ezxmlm.make_tag "CORSConfiguration"
          ([],
            (CORSConfiguration.to_xml
               req.PutBucketCorsRequest.c_o_r_s_configuration))]))
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