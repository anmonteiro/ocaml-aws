open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteScheduledActionType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      scheduled_action_name: String.t
        [@ocaml.doc "<p>The name of the action to delete.</p>"]}
    let make ~auto_scaling_group_name  ~scheduled_action_name  () =
      { auto_scaling_group_name; scheduled_action_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("scheduled_action_name",
                (String.to_json v.scheduled_action_name));
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
          scheduled_action_name =
            (Xml.required "ScheduledActionName"
               (Util.option_bind (Xml.member "ScheduledActionName" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "AutoScalingGroupName"
                  ([], (String.to_xml v.auto_scaling_group_name)))])
           @
           [Some
              (Ezxmlm.make_tag "ScheduledActionName"
                 ([], (String.to_xml v.scheduled_action_name)))])
  end
module Output = Aws.BaseTypes.Unit
type input = DeleteScheduledActionType.t
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
         [("Version", ["2011-01-01"]); ("Action", ["DeleteScheduledAction"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteScheduledActionType.to_query req))))) in
  (`POST, uri, (Headers.render (DeleteScheduledActionType.to_headers req)),
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