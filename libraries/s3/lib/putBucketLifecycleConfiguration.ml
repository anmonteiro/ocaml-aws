open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutBucketLifecycleConfigurationRequest =
  struct
    type t =
      {
      bucket: String.t
        [@ocaml.doc
          "<p>The name of the bucket for which to set the configuration.</p>"];
      lifecycle_configuration: BucketLifecycleConfiguration.t option
        [@ocaml.doc
          "<p>Container for lifecycle rules. You can add as many as 1,000 rules.</p>"]}
    let make ~bucket  ?lifecycle_configuration  () =
      { bucket; lifecycle_configuration }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.lifecycle_configuration
              (fun f ->
                 ("lifecycle_configuration",
                   (BucketLifecycleConfiguration.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          lifecycle_configuration =
            (Util.option_bind (Xml.member "LifecycleConfiguration" xml)
               BucketLifecycleConfiguration.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
           @
           [Util.option_map v.lifecycle_configuration
              (fun f ->
                 Ezxmlm.make_tag "LifecycleConfiguration"
                   ([], (BucketLifecycleConfiguration.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = PutBucketLifecycleConfigurationRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/" ^ req.PutBucketLifecycleConfigurationRequest.bucket) ^
               "?lifecycle")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render
               (PutBucketLifecycleConfigurationRequest.to_query req)))) in
  (`PUT, uri,
    (Headers.render (PutBucketLifecycleConfigurationRequest.to_headers req)),
    (match req.PutBucketLifecycleConfigurationRequest.lifecycle_configuration
     with
     | Some v ->
         Ezxmlm.to_string
           [Ezxmlm.make_tag "LifecycleConfiguration"
              ([], (BucketLifecycleConfiguration.to_xml v))]
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