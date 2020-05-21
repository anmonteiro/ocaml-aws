open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CompleteLifecycleActionType =
  struct
    type t =
      {
      lifecycle_hook_name: String.t
        [@ocaml.doc "<p>The name of the lifecycle hook.</p>"];
      auto_scaling_group_name: String.t
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      lifecycle_action_token: String.t option
        [@ocaml.doc
          "<p>A universally unique identifier (UUID) that identifies a specific lifecycle action associated with an instance. Amazon EC2 Auto Scaling sends this token to the notification target you specified when you created the lifecycle hook.</p>"];
      lifecycle_action_result: String.t
        [@ocaml.doc
          "<p>The action for the group to take. This parameter can be either <code>CONTINUE</code> or <code>ABANDON</code>.</p>"];
      instance_id: String.t option
        [@ocaml.doc "<p>The ID of the instance.</p>"]}
    let make ~lifecycle_hook_name  ~auto_scaling_group_name 
      ?lifecycle_action_token  ~lifecycle_action_result  ?instance_id  () =
      {
        lifecycle_hook_name;
        auto_scaling_group_name;
        lifecycle_action_token;
        lifecycle_action_result;
        instance_id
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.instance_id
              (fun f -> ("instance_id", (String.to_json f)));
           Some
             ("lifecycle_action_result",
               (String.to_json v.lifecycle_action_result));
           Util.option_map v.lifecycle_action_token
             (fun f -> ("lifecycle_action_token", (String.to_json f)));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name));
           Some
             ("lifecycle_hook_name", (String.to_json v.lifecycle_hook_name))])
    let parse xml =
      Some
        {
          lifecycle_hook_name =
            (Xml.required "LifecycleHookName"
               (Util.option_bind (Xml.member "LifecycleHookName" xml)
                  String.parse));
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          lifecycle_action_token =
            (Util.option_bind (Xml.member "LifecycleActionToken" xml)
               String.parse);
          lifecycle_action_result =
            (Xml.required "LifecycleActionResult"
               (Util.option_bind (Xml.member "LifecycleActionResult" xml)
                  String.parse));
          instance_id =
            (Util.option_bind (Xml.member "InstanceId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "LifecycleHookName"
                     ([], (String.to_xml v.lifecycle_hook_name)))])
              @
              [Some
                 (Ezxmlm.make_tag "AutoScalingGroupName"
                    ([], (String.to_xml v.auto_scaling_group_name)))])
             @
             [Util.option_map v.lifecycle_action_token
                (fun f ->
                   Ezxmlm.make_tag "LifecycleActionToken"
                     ([], (String.to_xml f)))])
            @
            [Some
               (Ezxmlm.make_tag "LifecycleActionResult"
                  ([], (String.to_xml v.lifecycle_action_result)))])
           @
           [Util.option_map v.instance_id
              (fun f -> Ezxmlm.make_tag "InstanceId" ([], (String.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = CompleteLifecycleActionType.t
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
         ("Action", ["CompleteLifecycleAction"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CompleteLifecycleActionType.to_query req))))) in
  (`POST, uri, (Headers.render (CompleteLifecycleActionType.to_headers req)),
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