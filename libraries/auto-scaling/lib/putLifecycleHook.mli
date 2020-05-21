(** "<p>Creates or updates a lifecycle hook for the specified Auto Scaling group.</p> <p>A lifecycle hook tells Amazon EC2 Auto Scaling to perform an action on an instance when the instance launches (before it is put into service) or as the instance terminates (before it is fully terminated).</p> <p>This step is a part of the procedure for adding a lifecycle hook to an Auto Scaling group:</p> <ol> <li> <p>(Optional) Create a Lambda function and a rule that allows CloudWatch Events to invoke your Lambda function when Amazon EC2 Auto Scaling launches or terminates instances.</p> </li> <li> <p>(Optional) Create a notification target and an IAM role. The target can be either an Amazon SQS queue or an Amazon SNS topic. The role allows Amazon EC2 Auto Scaling to publish lifecycle notifications to the target.</p> </li> <li> <p> <b>Create the lifecycle hook. Specify whether the hook is used when the instances launch or terminate.</b> </p> </li> <li> <p>If you need more time, record the lifecycle action heartbeat to keep the instance in a pending state using <a>RecordLifecycleActionHeartbeat</a>.</p> </li> <li> <p>If you finish before the timeout period ends, complete the lifecycle action using <a>CompleteLifecycleAction</a>.</p> </li> </ol> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/lifecycle-hooks.html\">Amazon EC2 Auto Scaling Lifecycle Hooks</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p> <p>If you exceed your maximum limit of lifecycle hooks, which by default is 50 per Auto Scaling group, the call fails.</p> <p>You can view the lifecycle hooks for an Auto Scaling group using <a>DescribeLifecycleHooks</a>. If you are no longer using a lifecycle hook, you can delete it using <a>DeleteLifecycleHook</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PutLifecycleHookType :
sig
  type t =
    {
    lifecycle_hook_name: String.t ;
    auto_scaling_group_name: String.t ;
    lifecycle_transition: String.t option ;
    role_a_r_n: String.t option ;
    notification_target_a_r_n: String.t option ;
    notification_metadata: String.t option ;
    heartbeat_timeout: Integer.t option ;
    default_result: String.t option }
  val make :
    lifecycle_hook_name:String.t ->
      auto_scaling_group_name:String.t ->
        ?lifecycle_transition:String.t ->
          ?role_a_r_n:String.t ->
            ?notification_target_a_r_n:String.t ->
              ?notification_metadata:String.t ->
                ?heartbeat_timeout:Integer.t ->
                  ?default_result:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = PutLifecycleHookType.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error