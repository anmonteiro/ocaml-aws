open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutBucketAccelerateConfigurationRequest =
  struct
    type t =
      {
      bucket: String.t
        [@ocaml.doc
          "<p>Name of the bucket for which the accelerate configuration is set.</p>"];
      accelerate_configuration: AccelerateConfiguration.t
        [@ocaml.doc
          "<p>Container for setting the transfer acceleration state.</p>"]}
    let make ~bucket  ~accelerate_configuration  () =
      { bucket; accelerate_configuration }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("accelerate_configuration",
                (AccelerateConfiguration.to_json v.accelerate_configuration));
           Some ("bucket", (String.to_json v.bucket))])
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          accelerate_configuration =
            (Xml.required "AccelerateConfiguration"
               (Util.option_bind (Xml.member "AccelerateConfiguration" xml)
                  AccelerateConfiguration.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
           @
           [Some
              (Ezxmlm.make_tag "AccelerateConfiguration"
                 ([],
                   (AccelerateConfiguration.to_xml v.accelerate_configuration)))])
  end
module Output = Aws.BaseTypes.Unit
type input = PutBucketAccelerateConfigurationRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/" ^ req.PutBucketAccelerateConfigurationRequest.bucket) ^
               "?accelerate")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render
               (PutBucketAccelerateConfigurationRequest.to_query req)))) in
  (`PUT, uri,
    (Headers.render (PutBucketAccelerateConfigurationRequest.to_headers req)),
    (Ezxmlm.to_string
       [Ezxmlm.make_tag "AccelerateConfiguration"
          ([],
            (AccelerateConfiguration.to_xml
               req.PutBucketAccelerateConfigurationRequest.accelerate_configuration))]))
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