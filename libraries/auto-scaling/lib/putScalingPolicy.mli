(** "<p>Creates or updates a scaling policy for an Auto Scaling group. To update an existing scaling policy, use the existing policy name and set the parameters to change. Any existing parameter not changed in an update to an existing policy is not changed in this update request.</p> <p>For more information about using scaling policies to scale your Auto Scaling group automatically, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-scale-based-on-demand.html\">Dynamic Scaling</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PutScalingPolicyType :
sig
  type t =
    {
    auto_scaling_group_name: String.t ;
    policy_name: String.t ;
    policy_type: String.t option ;
    adjustment_type: String.t option ;
    min_adjustment_step: Integer.t option ;
    min_adjustment_magnitude: Integer.t option ;
    scaling_adjustment: Integer.t option ;
    cooldown: Integer.t option ;
    metric_aggregation_type: String.t option ;
    step_adjustments: StepAdjustments.t ;
    estimated_instance_warmup: Integer.t option ;
    target_tracking_configuration: TargetTrackingConfiguration.t option }
  val make :
    auto_scaling_group_name:String.t ->
      policy_name:String.t ->
        ?policy_type:String.t ->
          ?adjustment_type:String.t ->
            ?min_adjustment_step:Integer.t ->
              ?min_adjustment_magnitude:Integer.t ->
                ?scaling_adjustment:Integer.t ->
                  ?cooldown:Integer.t ->
                    ?metric_aggregation_type:String.t ->
                      ?step_adjustments:StepAdjustments.t ->
                        ?estimated_instance_warmup:Integer.t ->
                          ?target_tracking_configuration:TargetTrackingConfiguration.t
                            -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module PolicyARNType = PolicyARNType
type input = PutScalingPolicyType.t
type output = PolicyARNType.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error