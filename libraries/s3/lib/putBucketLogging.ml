open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutBucketLoggingRequest =
  struct
    type t =
      {
      bucket: String.t
        [@ocaml.doc
          "<p>The name of the bucket for which to set the logging parameters.</p>"];
      bucket_logging_status: BucketLoggingStatus.t
        [@ocaml.doc "<p>Container for logging status information.</p>"];
      content_m_d5: String.t option
        [@ocaml.doc
          "<p>The MD5 hash of the <code>PutBucketLogging</code> request body.</p>"]}
    let make ~bucket  ~bucket_logging_status  ?content_m_d5  () =
      { bucket; bucket_logging_status; content_m_d5 }
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
             ("bucket_logging_status",
               (BucketLoggingStatus.to_json v.bucket_logging_status));
           Some ("bucket", (String.to_json v.bucket))])
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          bucket_logging_status =
            (Xml.required "BucketLoggingStatus"
               (Util.option_bind (Xml.member "BucketLoggingStatus" xml)
                  BucketLoggingStatus.parse));
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
            @
            [Some
               (Ezxmlm.make_tag "BucketLoggingStatus"
                  ([], (BucketLoggingStatus.to_xml v.bucket_logging_status)))])
           @
           [Util.option_map v.content_m_d5
              (fun f -> Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = PutBucketLoggingRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/" ^ req.PutBucketLoggingRequest.bucket) ^ "?logging")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (PutBucketLoggingRequest.to_query req)))) in
  (`PUT, uri, (Headers.render (PutBucketLoggingRequest.to_headers req)),
    (Ezxmlm.to_string
       [Ezxmlm.make_tag "BucketLoggingStatus"
          ([],
            (BucketLoggingStatus.to_xml
               req.PutBucketLoggingRequest.bucket_logging_status))]))
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