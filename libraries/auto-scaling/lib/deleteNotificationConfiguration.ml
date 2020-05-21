open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteNotificationConfigurationType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      topic_a_r_n: String.t
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the Amazon Simple Notification Service (Amazon SNS) topic.</p>"]}
    let make ~auto_scaling_group_name  ~topic_a_r_n  () =
      { auto_scaling_group_name; topic_a_r_n }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("topic_a_r_n", (String.to_json v.topic_a_r_n));
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
               (Util.option_bind (Xml.member "TopicARN" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "AutoScalingGroupName"
                  ([], (String.to_xml v.auto_scaling_group_name)))])
           @
           [Some
              (Ezxmlm.make_tag "TopicARN" ([], (String.to_xml v.topic_a_r_n)))])
  end
module Output = Aws.BaseTypes.Unit
type input = DeleteNotificationConfigurationType.t
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
         ("Action", ["DeleteNotificationConfiguration"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DeleteNotificationConfigurationType.to_query req))))) in
  (`POST, uri,
    (Headers.render (DeleteNotificationConfigurationType.to_headers req)),
    "")
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