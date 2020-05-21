(** "<p>Updates the configuration for the specified Auto Scaling group.</p> <p>To update an Auto Scaling group, specify the name of the group and the parameter that you want to change. Any parameters that you don't specify are not changed by this update request. The new settings take effect on any scaling activities after this call returns. </p> <p>If you associate a new launch configuration or template with an Auto Scaling group, all new instances will get the updated configuration. Existing instances continue to run with the configuration that they were originally launched with. When you update a group to specify a mixed instances policy instead of a launch configuration or template, existing instances may be replaced to match the new purchasing options that you specified in the policy. For example, if the group currently has 100% On-Demand capacity and the policy specifies 50% Spot capacity, this means that half of your instances will be gradually terminated and relaunched as Spot Instances. When replacing instances, Amazon EC2 Auto Scaling launches new instances before terminating the old ones, so that updating your group does not compromise the performance or availability of your application.</p> <p>Note the following about changing <code>DesiredCapacity</code>, <code>MaxSize</code>, or <code>MinSize</code>:</p> <ul> <li> <p>If a scale-in event occurs as a result of a new <code>DesiredCapacity</code> value that is lower than the current size of the group, the Auto Scaling group uses its termination policy to determine which instances to terminate.</p> </li> <li> <p>If you specify a new value for <code>MinSize</code> without specifying a value for <code>DesiredCapacity</code>, and the new <code>MinSize</code> is larger than the current size of the group, this sets the group's <code>DesiredCapacity</code> to the new <code>MinSize</code> value.</p> </li> <li> <p>If you specify a new value for <code>MaxSize</code> without specifying a value for <code>DesiredCapacity</code>, and the new <code>MaxSize</code> is smaller than the current size of the group, this sets the group's <code>DesiredCapacity</code> to the new <code>MaxSize</code> value.</p> </li> </ul> <p>To see which parameters have been set, use <a>DescribeAutoScalingGroups</a>. You can also view the scaling policies for an Auto Scaling group using <a>DescribePolicies</a>. If the group has scaling policies, you can update them using <a>PutScalingPolicy</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module UpdateAutoScalingGroupType :
sig
  type t =
    {
    auto_scaling_group_name: String.t ;
    launch_configuration_name: String.t option ;
    launch_template: LaunchTemplateSpecification.t option ;
    mixed_instances_policy: MixedInstancesPolicy.t option ;
    min_size: Integer.t option ;
    max_size: Integer.t option ;
    desired_capacity: Integer.t option ;
    default_cooldown: Integer.t option ;
    availability_zones: AvailabilityZones.t ;
    health_check_type: String.t option ;
    health_check_grace_period: Integer.t option ;
    placement_group: String.t option ;
    v_p_c_zone_identifier: String.t option ;
    termination_policies: TerminationPolicies.t ;
    new_instances_protected_from_scale_in: Boolean.t option ;
    service_linked_role_a_r_n: String.t option ;
    max_instance_lifetime: Integer.t option }
  val make :
    auto_scaling_group_name:String.t ->
      ?launch_configuration_name:String.t ->
        ?launch_template:LaunchTemplateSpecification.t ->
          ?mixed_instances_policy:MixedInstancesPolicy.t ->
            ?min_size:Integer.t ->
              ?max_size:Integer.t ->
                ?desired_capacity:Integer.t ->
                  ?default_cooldown:Integer.t ->
                    ?availability_zones:AvailabilityZones.t ->
                      ?health_check_type:String.t ->
                        ?health_check_grace_period:Integer.t ->
                          ?placement_group:String.t ->
                            ?v_p_c_zone_identifier:String.t ->
                              ?termination_policies:TerminationPolicies.t ->
                                ?new_instances_protected_from_scale_in:Boolean.t
                                  ->
                                  ?service_linked_role_a_r_n:String.t ->
                                    ?max_instance_lifetime:Integer.t ->
                                      unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = UpdateAutoScalingGroupType.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error