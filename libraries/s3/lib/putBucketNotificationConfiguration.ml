open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutBucketNotificationConfigurationRequest =
  struct
    type t =
      {
      bucket: String.t [@ocaml.doc "<p>The name of the bucket.</p>"];
      notification_configuration: NotificationConfiguration.t }
    let make ~bucket  ~notification_configuration  () =
      { bucket; notification_configuration }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("notification_configuration",
                (NotificationConfiguration.to_json
                   v.notification_configuration));
           Some ("bucket", (String.to_json v.bucket))])
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          notification_configuration =
            (Xml.required "NotificationConfiguration"
               (Util.option_bind (Xml.member "NotificationConfiguration" xml)
                  NotificationConfiguration.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
           @
           [Some
              (Ezxmlm.make_tag "NotificationConfiguration"
                 ([],
                   (NotificationConfiguration.to_xml
                      v.notification_configuration)))])
  end
module Output = Aws.BaseTypes.Unit
type input = PutBucketNotificationConfigurationRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/" ^ req.PutBucketNotificationConfigurationRequest.bucket) ^
               "?notification")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render
               (PutBucketNotificationConfigurationRequest.to_query req)))) in
  (`PUT, uri,
    (Headers.render
       (PutBucketNotificationConfigurationRequest.to_headers req)),
    (Ezxmlm.to_string
       [Ezxmlm.make_tag "NotificationConfiguration"
          ([],
            (NotificationConfiguration.to_xml
               req.PutBucketNotificationConfigurationRequest.notification_configuration))]))
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