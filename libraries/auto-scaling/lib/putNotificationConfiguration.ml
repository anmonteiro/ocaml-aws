open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutNotificationConfigurationType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      topic_a_r_n: String.t
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the Amazon Simple Notification Service (Amazon SNS) topic.</p>"];
      notification_types: AutoScalingNotificationTypes.t
        [@ocaml.doc
          "<p>The type of event that causes the notification to be sent. For more information about notification types supported by Amazon EC2 Auto Scaling, see <a>DescribeAutoScalingNotificationTypes</a>.</p>"]}
    let make ~auto_scaling_group_name  ~topic_a_r_n  ~notification_types  ()
      = { auto_scaling_group_name; topic_a_r_n; notification_types }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("notification_types",
                (AutoScalingNotificationTypes.to_json v.notification_types));
           Some ("topic_a_r_n", (String.to_json v.topic_a_r_n));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name))])
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          topic_a_r_n =
            (Xml.required "TopicARN"
               (Util.option_bind (Xml.member "TopicARN" xml) String.parse));
          notification_types =
            (Xml.required "NotificationTypes"
               (Util.option_bind (Xml.member "NotificationTypes" xml)
                  AutoScalingNotificationTypes.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "AutoScalingGroupName"
                   ([], (String.to_xml v.auto_scaling_group_name)))])
            @
            [Some
               (Ezxmlm.make_tag "TopicARN"
                  ([], (String.to_xml v.topic_a_r_n)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "NotificationTypes"
                      ([], (AutoScalingNotificationTypes.to_xml [x]))))
              v.notification_types))
  end
module Output = Aws.BaseTypes.Unit
type input = PutNotificationConfigurationType.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "autoscaling"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2011-01-01"]);
         ("Action", ["PutNotificationConfiguration"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (PutNotificationConfigurationType.to_query req))))) in
  (`POST, uri,
    (Headers.render (PutNotificationConfigurationType.to_headers req)), "")
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