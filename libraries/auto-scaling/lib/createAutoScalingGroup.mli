(** "<p>Creates an Auto Scaling group with the specified name and attributes.</p> <p>If you exceed your maximum limit of Auto Scaling groups, the call fails. For information about viewing this limit, see <a>DescribeAccountLimits</a>. For information about updating this limit, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-account-limits.html\">Amazon EC2 Auto Scaling Limits</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateAutoScalingGroupType :
sig
  type t =
    {
    auto_scaling_group_name: String.t ;
    launch_configuration_name: String.t option ;
    launch_template: LaunchTemplateSpecification.t option ;
    mixed_instances_policy: MixedInstancesPolicy.t option ;
    instance_id: String.t option ;
    min_size: Integer.t ;
    max_size: Integer.t ;
    desired_capacity: Integer.t option ;
    default_cooldown: Integer.t option ;
    availability_zones: AvailabilityZones.t ;
    load_balancer_names: LoadBalancerNames.t ;
    target_group_a_r_ns: TargetGroupARNs.t ;
    health_check_type: String.t option ;
    health_check_grace_period: Integer.t option ;
    placement_group: String.t option ;
    v_p_c_zone_identifier: String.t option ;
    termination_policies: TerminationPolicies.t ;
    new_instances_protected_from_scale_in: Boolean.t option ;
    lifecycle_hook_specification_list: LifecycleHookSpecifications.t ;
    tags: Tags.t ;
    service_linked_role_a_r_n: String.t option ;
    max_instance_lifetime: Integer.t option }
  val make :
    auto_scaling_group_name:String.t ->
      ?launch_configuration_name:String.t ->
        ?launch_template:LaunchTemplateSpecification.t ->
          ?mixed_instances_policy:MixedInstancesPolicy.t ->
            ?instance_id:String.t ->
              min_size:Integer.t ->
                max_size:Integer.t ->
                  ?desired_capacity:Integer.t ->
                    ?default_cooldown:Integer.t ->
                      ?availability_zones:AvailabilityZones.t ->
                        ?load_balancer_names:LoadBalancerNames.t ->
                          ?target_group_a_r_ns:TargetGroupARNs.t ->
                            ?health_check_type:String.t ->
                              ?health_check_grace_period:Integer.t ->
                                ?placement_group:String.t ->
                                  ?v_p_c_zone_identifier:String.t ->
                                    ?termination_policies:TerminationPolicies.t
                                      ->
                                      ?new_instances_protected_from_scale_in:Boolean.t
                                        ->
                                        ?lifecycle_hook_specification_list:LifecycleHookSpecifications.t
                                          ->
                                          ?tags:Tags.t ->
                                            ?service_linked_role_a_r_n:String.t
                                              ->
                                              ?max_instance_lifetime:Integer.t
                                                -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = CreateAutoScalingGroupType.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error