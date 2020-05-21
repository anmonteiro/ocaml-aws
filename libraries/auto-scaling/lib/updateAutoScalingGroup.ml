open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module UpdateAutoScalingGroupType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      launch_configuration_name: String.t option
        [@ocaml.doc
          "<p>The name of the launch configuration. If you specify <code>LaunchConfigurationName</code> in your update request, you can't specify <code>LaunchTemplate</code> or <code>MixedInstancesPolicy</code>.</p>"];
      launch_template: LaunchTemplateSpecification.t option
        [@ocaml.doc
          "<p>The launch template and version to use to specify the updates. If you specify <code>LaunchTemplate</code> in your update request, you can't specify <code>LaunchConfigurationName</code> or <code>MixedInstancesPolicy</code>.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_LaunchTemplateSpecification.html\">LaunchTemplateSpecification</a> in the <i>Amazon EC2 Auto Scaling API Reference</i>.</p>"];
      mixed_instances_policy: MixedInstancesPolicy.t option
        [@ocaml.doc
          "<p>An embedded object that specifies a mixed instances policy.</p> <p>In your call to <code>UpdateAutoScalingGroup</code>, you can make changes to the policy that is specified. All optional parameters are left unchanged if not specified.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_MixedInstancesPolicy.html\">MixedInstancesPolicy</a> in the <i>Amazon EC2 Auto Scaling API Reference</i> and <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-purchase-options.html\">Auto Scaling Groups with Multiple Instance Types and Purchase Options</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"];
      min_size: Integer.t option
        [@ocaml.doc "<p>The minimum size of the Auto Scaling group.</p>"];
      max_size: Integer.t option
        [@ocaml.doc "<p>The maximum size of the Auto Scaling group.</p>"];
      desired_capacity: Integer.t option
        [@ocaml.doc
          "<p>The number of EC2 instances that should be running in the Auto Scaling group. This number must be greater than or equal to the minimum size of the group and less than or equal to the maximum size of the group.</p>"];
      default_cooldown: Integer.t option
        [@ocaml.doc
          "<p>The amount of time, in seconds, after a scaling activity completes before another scaling activity can start. The default value is <code>300</code>. This cooldown period is not used when a scaling-specific cooldown is specified.</p> <p>Cooldown periods are not supported for target tracking scaling policies, step scaling policies, or scheduled scaling. For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/Cooldown.html\">Scaling Cooldowns</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"];
      availability_zones: AvailabilityZones.t
        [@ocaml.doc "<p>One or more Availability Zones for the group.</p>"];
      health_check_type: String.t option
        [@ocaml.doc
          "<p>The service to use for the health checks. The valid values are <code>EC2</code> and <code>ELB</code>. If you configure an Auto Scaling group to use ELB health checks, it considers the instance unhealthy if it fails either the EC2 status checks or the load balancer health checks.</p>"];
      health_check_grace_period: Integer.t option
        [@ocaml.doc
          "<p>The amount of time, in seconds, that Amazon EC2 Auto Scaling waits before checking the health status of an EC2 instance that has come into service. The default value is <code>0</code>.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/healthcheck.html#health-check-grace-period\">Health Check Grace Period</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p> <p>Conditional: This parameter is required if you are adding an <code>ELB</code> health check.</p>"];
      placement_group: String.t option
        [@ocaml.doc
          "<p>The name of the placement group into which to launch your instances, if any. A placement group is a logical grouping of instances within a single Availability Zone. You cannot specify multiple Availability Zones and a placement group. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html\">Placement Groups</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.</p>"];
      v_p_c_zone_identifier: String.t option
        [@ocaml.doc
          "<p>A comma-separated list of subnet IDs for virtual private cloud (VPC).</p> <p>If you specify <code>VPCZoneIdentifier</code> with <code>AvailabilityZones</code>, the subnets that you specify for this parameter must reside in those Availability Zones.</p>"];
      termination_policies: TerminationPolicies.t
        [@ocaml.doc
          "<p>A standalone termination policy or a list of termination policies used to select the instance to terminate. The policies are executed in the order that they are listed.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-instance-termination.html\">Controlling Which Instances Auto Scaling Terminates During Scale In</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"];
      new_instances_protected_from_scale_in: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether newly launched instances are protected from termination by Amazon EC2 Auto Scaling when scaling in.</p> <p>For more information about preventing instances from terminating on scale in, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-instance-termination.html#instance-protection\">Instance Protection</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"];
      service_linked_role_a_r_n: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the service-linked role that the Auto Scaling group uses to call other AWS services on your behalf. For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/autoscaling-service-linked-role.html\">Service-Linked Roles</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"];
      max_instance_lifetime: Integer.t option
        [@ocaml.doc
          "<p>The maximum amount of time, in seconds, that an instance can be in service.</p> <p>Valid Range: Minimum value of 604800.</p>"]}
    let make ~auto_scaling_group_name  ?launch_configuration_name 
      ?launch_template  ?mixed_instances_policy  ?min_size  ?max_size 
      ?desired_capacity  ?default_cooldown  ?(availability_zones= []) 
      ?health_check_type  ?health_check_grace_period  ?placement_group 
      ?v_p_c_zone_identifier  ?(termination_policies= []) 
      ?new_instances_protected_from_scale_in  ?service_linked_role_a_r_n 
      ?max_instance_lifetime  () =
      {
        auto_scaling_group_name;
        launch_configuration_name;
        launch_template;
        mixed_instances_policy;
        min_size;
        max_size;
        desired_capacity;
        default_cooldown;
        availability_zones;
        health_check_type;
        health_check_grace_period;
        placement_group;
        v_p_c_zone_identifier;
        termination_policies;
        new_instances_protected_from_scale_in;
        service_linked_role_a_r_n;
        max_instance_lifetime
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_instance_lifetime
              (fun f -> ("max_instance_lifetime", (Integer.to_json f)));
           Util.option_map v.service_linked_role_a_r_n
             (fun f -> ("service_linked_role_a_r_n", (String.to_json f)));
           Util.option_map v.new_instances_protected_from_scale_in
             (fun f ->
                ("new_instances_protected_from_scale_in",
                  (Boolean.to_json f)));
           Some
             ("termination_policies",
               (TerminationPolicies.to_json v.termination_policies));
           Util.option_map v.v_p_c_zone_identifier
             (fun f -> ("v_p_c_zone_identifier", (String.to_json f)));
           Util.option_map v.placement_group
             (fun f -> ("placement_group", (String.to_json f)));
           Util.option_map v.health_check_grace_period
             (fun f -> ("health_check_grace_period", (Integer.to_json f)));
           Util.option_map v.health_check_type
             (fun f -> ("health_check_type", (String.to_json f)));
           Some
             ("availability_zones",
               (AvailabilityZones.to_json v.availability_zones));
           Util.option_map v.default_cooldown
             (fun f -> ("default_cooldown", (Integer.to_json f)));
           Util.option_map v.desired_capacity
             (fun f -> ("desired_capacity", (Integer.to_json f)));
           Util.option_map v.max_size
             (fun f -> ("max_size", (Integer.to_json f)));
           Util.option_map v.min_size
             (fun f -> ("min_size", (Integer.to_json f)));
           Util.option_map v.mixed_instances_policy
             (fun f ->
                ("mixed_instances_policy", (MixedInstancesPolicy.to_json f)));
           Util.option_map v.launch_template
             (fun f ->
                ("launch_template", (LaunchTemplateSpecification.to_json f)));
           Util.option_map v.launch_configuration_name
             (fun f -> ("launch_configuration_name", (String.to_json f)));
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
          launch_configuration_name =
            (Util.option_bind (Xml.member "LaunchConfigurationName" xml)
               String.parse);
          launch_template =
            (Util.option_bind (Xml.member "LaunchTemplate" xml)
               LaunchTemplateSpecification.parse);
          mixed_instances_policy =
            (Util.option_bind (Xml.member "MixedInstancesPolicy" xml)
               MixedInstancesPolicy.parse);
          min_size =
            (Util.option_bind (Xml.member "MinSize" xml) Integer.parse);
          max_size =
            (Util.option_bind (Xml.member "MaxSize" xml) Integer.parse);
          desired_capacity =
            (Util.option_bind (Xml.member "DesiredCapacity" xml)
               Integer.parse);
          default_cooldown =
            (Util.option_bind (Xml.member "DefaultCooldown" xml)
               Integer.parse);
          availability_zones =
            (Util.of_option []
               (Util.option_bind (Xml.member "AvailabilityZones" xml)
                  AvailabilityZones.parse));
          health_check_type =
            (Util.option_bind (Xml.member "HealthCheckType" xml) String.parse);
          health_check_grace_period =
            (Util.option_bind (Xml.member "HealthCheckGracePeriod" xml)
               Integer.parse);
          placement_group =
            (Util.option_bind (Xml.member "PlacementGroup" xml) String.parse);
          v_p_c_zone_identifier =
            (Util.option_bind (Xml.member "VPCZoneIdentifier" xml)
               String.parse);
          termination_policies =
            (Util.of_option []
               (Util.option_bind (Xml.member "TerminationPolicies" xml)
                  TerminationPolicies.parse));
          new_instances_protected_from_scale_in =
            (Util.option_bind
               (Xml.member "NewInstancesProtectedFromScaleIn" xml)
               Boolean.parse);
          service_linked_role_a_r_n =
            (Util.option_bind (Xml.member "ServiceLinkedRoleARN" xml)
               String.parse);
          max_instance_lifetime =
            (Util.option_bind (Xml.member "MaxInstanceLifetime" xml)
               Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((((([] @
                           [Some
                              (Ezxmlm.make_tag "AutoScalingGroupName"
                                 ([],
                                   (String.to_xml v.auto_scaling_group_name)))])
                          @
                          [Util.option_map v.launch_configuration_name
                             (fun f ->
                                Ezxmlm.make_tag "LaunchConfigurationName"
                                  ([], (String.to_xml f)))])
                         @
                         [Util.option_map v.launch_template
                            (fun f ->
                               Ezxmlm.make_tag "LaunchTemplate"
                                 ([], (LaunchTemplateSpecification.to_xml f)))])
                        @
                        [Util.option_map v.mixed_instances_policy
                           (fun f ->
                              Ezxmlm.make_tag "MixedInstancesPolicy"
                                ([], (MixedInstancesPolicy.to_xml f)))])
                       @
                       [Util.option_map v.min_size
                          (fun f ->
                             Ezxmlm.make_tag "MinSize"
                               ([], (Integer.to_xml f)))])
                      @
                      [Util.option_map v.max_size
                         (fun f ->
                            Ezxmlm.make_tag "MaxSize"
                              ([], (Integer.to_xml f)))])
                     @
                     [Util.option_map v.desired_capacity
                        (fun f ->
                           Ezxmlm.make_tag "DesiredCapacity"
                             ([], (Integer.to_xml f)))])
                    @
                    [Util.option_map v.default_cooldown
                       (fun f ->
                          Ezxmlm.make_tag "DefaultCooldown"
                            ([], (Integer.to_xml f)))])
                   @
                   (List.map
                      (fun x ->
                         Some
                           (Ezxmlm.make_tag "AvailabilityZones"
                              ([], (AvailabilityZones.to_xml [x]))))
                      v.availability_zones))
                  @
                  [Util.option_map v.health_check_type
                     (fun f ->
                        Ezxmlm.make_tag "HealthCheckType"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.health_check_grace_period
                    (fun f ->
                       Ezxmlm.make_tag "HealthCheckGracePeriod"
                         ([], (Integer.to_xml f)))])
                @
                [Util.option_map v.placement_group
                   (fun f ->
                      Ezxmlm.make_tag "PlacementGroup"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.v_p_c_zone_identifier
                  (fun f ->
                     Ezxmlm.make_tag "VPCZoneIdentifier"
                       ([], (String.to_xml f)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "TerminationPolicies"
                         ([], (TerminationPolicies.to_xml [x]))))
                 v.termination_policies))
             @
             [Util.option_map v.new_instances_protected_from_scale_in
                (fun f ->
                   Ezxmlm.make_tag "NewInstancesProtectedFromScaleIn"
                     ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.service_linked_role_a_r_n
               (fun f ->
                  Ezxmlm.make_tag "ServiceLinkedRoleARN"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_instance_lifetime
              (fun f ->
                 Ezxmlm.make_tag "MaxInstanceLifetime"
                   ([], (Integer.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = UpdateAutoScalingGroupType.t
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
         ("Action", ["UpdateAutoScalingGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (UpdateAutoScalingGroupType.to_query req))))) in
  (`POST, uri, (Headers.render (UpdateAutoScalingGroupType.to_headers req)),
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