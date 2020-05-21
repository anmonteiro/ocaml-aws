open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutBucketAnalyticsConfigurationRequest =
  struct
    type t =
      {
      bucket: String.t
        [@ocaml.doc
          "<p>The name of the bucket to which an analytics configuration is stored.</p>"];
      id: String.t
        [@ocaml.doc
          "<p>The ID that identifies the analytics configuration.</p>"];
      analytics_configuration: AnalyticsConfiguration.t
        [@ocaml.doc
          "<p>The configuration and any analyses for the analytics filter.</p>"]}
    let make ~bucket  ~id  ~analytics_configuration  () =
      { bucket; id; analytics_configuration }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("id", (String.to_query v.id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("analytics_configuration",
                (AnalyticsConfiguration.to_json v.analytics_configuration));
           Some ("id", (String.to_json v.id));
           Some ("bucket", (String.to_json v.bucket))])
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          id =
            (Xml.required "id"
               (Util.option_bind (Xml.member "id" xml) String.parse));
          analytics_configuration =
            (Xml.required "AnalyticsConfiguration"
               (Util.option_bind (Xml.member "AnalyticsConfiguration" xml)
                  AnalyticsConfiguration.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
            @ [Some (Ezxmlm.make_tag "id" ([], (String.to_xml v.id)))])
           @
           [Some
              (Ezxmlm.make_tag "AnalyticsConfiguration"
                 ([],
                   (AnalyticsConfiguration.to_xml v.analytics_configuration)))])
  end
module Output = Aws.BaseTypes.Unit
type input = PutBucketAnalyticsConfigurationRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/" ^ req.PutBucketAnalyticsConfigurationRequest.bucket) ^
               "?analytics")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render
               (PutBucketAnalyticsConfigurationRequest.to_query req)))) in
  (`PUT, uri,
    (Headers.render (PutBucketAnalyticsConfigurationRequest.to_headers req)),
    (Ezxmlm.to_string
       [Ezxmlm.make_tag "AnalyticsConfiguration"
          ([],
            (AnalyticsConfiguration.to_xml
               req.PutBucketAnalyticsConfigurationRequest.analytics_configuration))]))
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