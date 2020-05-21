open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutBucketRequestPaymentRequest =
  struct
    type t =
      {
      bucket: String.t [@ocaml.doc "<p>The bucket name.</p>"];
      content_m_d5: String.t option
        [@ocaml.doc
          "<p>&gt;The base64-encoded 128-bit MD5 digest of the data. You must use this header as a message integrity check to verify that the request body was not corrupted in transit. For more information, see <a href=\"http://www.ietf.org/rfc/rfc1864.txt\">RFC 1864</a>.</p>"];
      request_payment_configuration: RequestPaymentConfiguration.t
        [@ocaml.doc "<p>Container for Payer.</p>"]}
    let make ~bucket  ?content_m_d5  ~request_payment_configuration  () =
      { bucket; content_m_d5; request_payment_configuration }
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
              ("request_payment_configuration",
                (RequestPaymentConfiguration.to_json
                   v.request_payment_configuration));
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
          request_payment_configuration =
            (Xml.required "RequestPaymentConfiguration"
               (Util.option_bind
                  (Xml.member "RequestPaymentConfiguration" xml)
                  RequestPaymentConfiguration.parse))
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
              (Ezxmlm.make_tag "RequestPaymentConfiguration"
                 ([],
                   (RequestPaymentConfiguration.to_xml
                      v.request_payment_configuration)))])
  end
module Output = Aws.BaseTypes.Unit
type input = PutBucketRequestPaymentRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/" ^ req.PutBucketRequestPaymentRequest.bucket) ^
               "?requestPayment")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (PutBucketRequestPaymentRequest.to_query req)))) in
  (`PUT, uri,
    (Headers.render (PutBucketRequestPaymentRequest.to_headers req)),
    (Ezxmlm.to_string
       [Ezxmlm.make_tag "RequestPaymentConfiguration"
          ([],
            (RequestPaymentConfiguration.to_xml
               req.PutBucketRequestPaymentRequest.request_payment_configuration))]))
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