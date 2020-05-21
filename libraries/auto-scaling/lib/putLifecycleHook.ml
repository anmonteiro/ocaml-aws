open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutLifecycleHookType =
  struct
    type t =
      {
      lifecycle_hook_name: String.t
        [@ocaml.doc "<p>The name of the lifecycle hook.</p>"];
      auto_scaling_group_name: String.t
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      lifecycle_transition: String.t option
        [@ocaml.doc
          "<p>The instance state to which you want to attach the lifecycle hook. The valid values are:</p> <ul> <li> <p>autoscaling:EC2_INSTANCE_LAUNCHING</p> </li> <li> <p>autoscaling:EC2_INSTANCE_TERMINATING</p> </li> </ul> <p>Conditional: This parameter is required for new lifecycle hooks, but optional when updating existing hooks.</p>"];
      role_a_r_n: String.t option
        [@ocaml.doc
          "<p>The ARN of the IAM role that allows the Auto Scaling group to publish to the specified notification target, for example, an Amazon SNS topic or an Amazon SQS queue.</p> <p>Conditional: This parameter is required for new lifecycle hooks, but optional when updating existing hooks.</p>"];
      notification_target_a_r_n: String.t option
        [@ocaml.doc
          "<p>The ARN of the notification target that Amazon EC2 Auto Scaling uses to notify you when an instance is in the transition state for the lifecycle hook. This target can be either an SQS queue or an SNS topic.</p> <p>If you specify an empty string, this overrides the current ARN.</p> <p>This operation uses the JSON format when sending notifications to an Amazon SQS queue, and an email key-value pair format when sending notifications to an Amazon SNS topic.</p> <p>When you specify a notification target, Amazon EC2 Auto Scaling sends it a test message. Test messages contain the following additional key-value pair: <code>\"Event\": \"autoscaling:TEST_NOTIFICATION\"</code>.</p>"];
      notification_metadata: String.t option
        [@ocaml.doc
          "<p>Additional information that you want to include any time Amazon EC2 Auto Scaling sends a message to the notification target.</p>"];
      heartbeat_timeout: Integer.t option
        [@ocaml.doc
          "<p>The maximum time, in seconds, that can elapse before the lifecycle hook times out. The range is from <code>30</code> to <code>7200</code> seconds. The default value is <code>3600</code> seconds (1 hour).</p> <p>If the lifecycle hook times out, Amazon EC2 Auto Scaling performs the action that you specified in the <code>DefaultResult</code> parameter. You can prevent the lifecycle hook from timing out by calling <a>RecordLifecycleActionHeartbeat</a>.</p>"];
      default_result: String.t option
        [@ocaml.doc
          "<p>Defines the action the Auto Scaling group should take when the lifecycle hook timeout elapses or if an unexpected failure occurs. This parameter can be either <code>CONTINUE</code> or <code>ABANDON</code>. The default value is <code>ABANDON</code>.</p>"]}
    let make ~lifecycle_hook_name  ~auto_scaling_group_name 
      ?lifecycle_transition  ?role_a_r_n  ?notification_target_a_r_n 
      ?notification_metadata  ?heartbeat_timeout  ?default_result  () =
      {
        lifecycle_hook_name;
        auto_scaling_group_name;
        lifecycle_transition;
        role_a_r_n;
        notification_target_a_r_n;
        notification_metadata;
        heartbeat_timeout;
        default_result
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.default_result
              (fun f -> ("default_result", (String.to_json f)));
           Util.option_map v.heartbeat_timeout
             (fun f -> ("heartbeat_timeout", (Integer.to_json f)));
           Util.option_map v.notification_metadata
             (fun f -> ("notification_metadata", (String.to_json f)));
           Util.option_map v.notification_target_a_r_n
             (fun f -> ("notification_target_a_r_n", (String.to_json f)));
           Util.option_map v.role_a_r_n
             (fun f -> ("role_a_r_n", (String.to_json f)));
           Util.option_map v.lifecycle_transition
             (fun f -> ("lifecycle_transition", (String.to_json f)));
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
          lifecycle_transition =
            (Util.option_bind (Xml.member "LifecycleTransition" xml)
               String.parse);
          role_a_r_n =
            (Util.option_bind (Xml.member "RoleARN" xml) String.parse);
          notification_target_a_r_n =
            (Util.option_bind (Xml.member "NotificationTargetARN" xml)
               String.parse);
          notification_metadata =
            (Util.option_bind (Xml.member "NotificationMetadata" xml)
               String.parse);
          heartbeat_timeout =
            (Util.option_bind (Xml.member "HeartbeatTimeout" xml)
               Integer.parse);
          default_result =
            (Util.option_bind (Xml.member "DefaultResult" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((([] @
                  [Some
                     (Ezxmlm.make_tag "LifecycleHookName"
                        ([], (String.to_xml v.lifecycle_hook_name)))])
                 @
                 [Some
                    (Ezxmlm.make_tag "AutoScalingGroupName"
                       ([], (String.to_xml v.auto_scaling_group_name)))])
                @
                [Util.option_map v.lifecycle_transition
                   (fun f ->
                      Ezxmlm.make_tag "LifecycleTransition"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.role_a_r_n
                  (fun f -> Ezxmlm.make_tag "RoleARN" ([], (String.to_xml f)))])
              @
              [Util.option_map v.notification_target_a_r_n
                 (fun f ->
                    Ezxmlm.make_tag "NotificationTargetARN"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.notification_metadata
                (fun f ->
                   Ezxmlm.make_tag "NotificationMetadata"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.heartbeat_timeout
               (fun f ->
                  Ezxmlm.make_tag "HeartbeatTimeout" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.default_result
              (fun f ->
                 Ezxmlm.make_tag "DefaultResult" ([], (String.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = PutLifecycleHookType.t
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
         [("Version", ["2011-01-01"]); ("Action", ["PutLifecycleHook"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (PutLifecycleHookType.to_query req))))) in
  (`POST, uri, (Headers.render (PutLifecycleHookType.to_headers req)), "")
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