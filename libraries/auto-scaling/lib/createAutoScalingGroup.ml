open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateAutoScalingGroupType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t
        [@ocaml.doc
          "<p>The name of the Auto Scaling group. This name must be unique per Region per account.</p>"];
      launch_configuration_name: String.t option
        [@ocaml.doc
          "<p>The name of the launch configuration.</p> <p>If you do not specify <code>LaunchConfigurationName</code>, you must specify one of the following parameters: <code>InstanceId</code>, <code>LaunchTemplate</code>, or <code>MixedInstancesPolicy</code>.</p>"];
      launch_template: LaunchTemplateSpecification.t option
        [@ocaml.doc
          "<p>The launch template to use to launch instances.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_LaunchTemplateSpecification.html\">LaunchTemplateSpecification</a> in the <i>Amazon EC2 Auto Scaling API Reference</i>.</p> <p>If you do not specify <code>LaunchTemplate</code>, you must specify one of the following parameters: <code>InstanceId</code>, <code>LaunchConfigurationName</code>, or <code>MixedInstancesPolicy</code>.</p>"];
      mixed_instances_policy: MixedInstancesPolicy.t option
        [@ocaml.doc
          "<p>An embedded object that specifies a mixed instances policy. The required parameters must be specified. If optional parameters are unspecified, their default values are used.</p> <p>The policy includes parameters that not only define the distribution of On-Demand Instances and Spot Instances, the maximum price to pay for Spot Instances, and how the Auto Scaling group allocates instance types to fulfill On-Demand and Spot capacity, but also the parameters that specify the instance configuration information\226\128\148the launch template and instance types.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_MixedInstancesPolicy.html\">MixedInstancesPolicy</a> in the <i>Amazon EC2 Auto Scaling API Reference</i> and <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-purchase-options.html\">Auto Scaling Groups with Multiple Instance Types and Purchase Options</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p> <p>You must specify one of the following parameters in your request: <code>LaunchConfigurationName</code>, <code>LaunchTemplate</code>, <code>InstanceId</code>, or <code>MixedInstancesPolicy</code>.</p>"];
      instance_id: String.t option
        [@ocaml.doc
          "<p>The ID of the instance used to create a launch configuration for the group.</p> <p>When you specify an ID of an instance, Amazon EC2 Auto Scaling creates a new launch configuration and associates it with the group. This launch configuration derives its attributes from the specified instance, except for the block device mapping.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-asg-from-instance.html\">Create an Auto Scaling Group Using an EC2 Instance</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p> <p>You must specify one of the following parameters in your request: <code>LaunchConfigurationName</code>, <code>LaunchTemplate</code>, <code>InstanceId</code>, or <code>MixedInstancesPolicy</code>.</p>"];
      min_size: Integer.t
        [@ocaml.doc "<p>The minimum size of the group.</p>"];
      max_size: Integer.t
        [@ocaml.doc "<p>The maximum size of the group.</p>"];
      desired_capacity: Integer.t option
        [@ocaml.doc
          "<p>The number of Amazon EC2 instances that the Auto Scaling group attempts to maintain. This number must be greater than or equal to the minimum size of the group and less than or equal to the maximum size of the group. If you do not specify a desired capacity, the default is the minimum size of the group.</p>"];
      default_cooldown: Integer.t option
        [@ocaml.doc
          "<p>The amount of time, in seconds, after a scaling activity completes before another scaling activity can start. The default value is <code>300</code>.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/Cooldown.html\">Scaling Cooldowns</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"];
      availability_zones: AvailabilityZones.t
        [@ocaml.doc
          "<p>One or more Availability Zones for the group. This parameter is optional if you specify one or more subnets for <code>VPCZoneIdentifier</code>.</p> <p>Conditional: If your account supports EC2-Classic and VPC, this parameter is required to launch instances into EC2-Classic.</p>"];
      load_balancer_names: LoadBalancerNames.t
        [@ocaml.doc
          "<p>A list of Classic Load Balancers associated with this Auto Scaling group. For Application Load Balancers and Network Load Balancers, specify a list of target groups using the <code>TargetGroupARNs</code> property instead.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/autoscaling-load-balancer.html\">Using a Load Balancer with an Auto Scaling Group</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"];
      target_group_a_r_ns: TargetGroupARNs.t
        [@ocaml.doc
          "<p>The Amazon Resource Names (ARN) of the target groups to associate with the Auto Scaling group. Instances are registered as targets in a target group, and traffic is routed to the target group.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/autoscaling-load-balancer.html\">Using a Load Balancer with an Auto Scaling Group</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"];
      health_check_type: String.t option
        [@ocaml.doc
          "<p>The service to use for the health checks. The valid values are <code>EC2</code> and <code>ELB</code>. The default value is <code>EC2</code>. If you configure an Auto Scaling group to use ELB health checks, it considers the instance unhealthy if it fails either the EC2 status checks or the load balancer health checks.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/healthcheck.html\">Health Checks for Auto Scaling Instances</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"];
      health_check_grace_period: Integer.t option
        [@ocaml.doc
          "<p>The amount of time, in seconds, that Amazon EC2 Auto Scaling waits before checking the health status of an EC2 instance that has come into service. During this time, any health check failures for the instance are ignored. The default value is <code>0</code>.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/healthcheck.html#health-check-grace-period\">Health Check Grace Period</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p> <p>Conditional: This parameter is required if you are adding an <code>ELB</code> health check.</p>"];
      placement_group: String.t option
        [@ocaml.doc
          "<p>The name of the placement group into which to launch your instances, if any. A placement group is a logical grouping of instances within a single Availability Zone. You cannot specify multiple Availability Zones and a placement group. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html\">Placement Groups</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.</p>"];
      v_p_c_zone_identifier: String.t option
        [@ocaml.doc
          "<p>A comma-separated list of subnet IDs for your virtual private cloud (VPC).</p> <p>If you specify <code>VPCZoneIdentifier</code> with <code>AvailabilityZones</code>, the subnets that you specify for this parameter must reside in those Availability Zones.</p> <p>Conditional: If your account supports EC2-Classic and VPC, this parameter is required to launch instances into a VPC.</p>"];
      termination_policies: TerminationPolicies.t
        [@ocaml.doc
          "<p>One or more termination policies used to select the instance to terminate. These policies are executed in the order that they are listed.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-instance-termination.html\">Controlling Which Instances Auto Scaling Terminates During Scale In</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"];
      new_instances_protected_from_scale_in: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether newly launched instances are protected from termination by Amazon EC2 Auto Scaling when scaling in.</p> <p>For more information about preventing instances from terminating on scale in, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-instance-termination.html#instance-protection\">Instance Protection</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"];
      lifecycle_hook_specification_list: LifecycleHookSpecifications.t
        [@ocaml.doc "<p>One or more lifecycle hooks.</p>"];
      tags: Tags.t
        [@ocaml.doc
          "<p>One or more tags.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/autoscaling-tagging.html\">Tagging Auto Scaling Groups and Instances</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"];
      service_linked_role_a_r_n: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the service-linked role that the Auto Scaling group uses to call other AWS services on your behalf. By default, Amazon EC2 Auto Scaling uses a service-linked role named AWSServiceRoleForAutoScaling, which it creates if it does not exist. For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/autoscaling-service-linked-role.html\">Service-Linked Roles</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"];
      max_instance_lifetime: Integer.t option
        [@ocaml.doc
          "<p>The maximum amount of time, in seconds, that an instance can be in service.</p> <p>Valid Range: Minimum value of 604800.</p>"]}
    let make ~auto_scaling_group_name  ?launch_configuration_name 
      ?launch_template  ?mixed_instances_policy  ?instance_id  ~min_size 
      ~max_size  ?desired_capacity  ?default_cooldown  ?(availability_zones=
      [])  ?(load_balancer_names= [])  ?(target_group_a_r_ns= []) 
      ?health_check_type  ?health_check_grace_period  ?placement_group 
      ?v_p_c_zone_identifier  ?(termination_policies= []) 
      ?new_instances_protected_from_scale_in 
      ?(lifecycle_hook_specification_list= [])  ?(tags= []) 
      ?service_linked_role_a_r_n  ?max_instance_lifetime  () =
      {
        auto_scaling_group_name;
        launch_configuration_name;
        launch_template;
        mixed_instances_policy;
        instance_id;
        min_size;
        max_size;
        desired_capacity;
        default_cooldown;
        availability_zones;
        load_balancer_names;
        target_group_a_r_ns;
        health_check_type;
        health_check_grace_period;
        placement_group;
        v_p_c_zone_identifier;
        termination_policies;
        new_instances_protected_from_scale_in;
        lifecycle_hook_specification_list;
        tags;
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
           Some ("tags", (Tags.to_json v.tags));
           Some
             ("lifecycle_hook_specification_list",
               (LifecycleHookSpecifications.to_json
                  v.lifecycle_hook_specification_list));
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
             ("target_group_a_r_ns",
               (TargetGroupARNs.to_json v.target_group_a_r_ns));
           Some
             ("load_balancer_names",
               (LoadBalancerNames.to_json v.load_balancer_names));
           Some
             ("availability_zones",
               (AvailabilityZones.to_json v.availability_zones));
           Util.option_map v.default_cooldown
             (fun f -> ("default_cooldown", (Integer.to_json f)));
           Util.option_map v.desired_capacity
             (fun f -> ("desired_capacity", (Integer.to_json f)));
           Some ("max_size", (Integer.to_json v.max_size));
           Some ("min_size", (Integer.to_json v.min_size));
           Util.option_map v.instance_id
             (fun f -> ("instance_id", (String.to_json f)));
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
          instance_id =
            (Util.option_bind (Xml.member "InstanceId" xml) String.parse);
          min_size =
            (Xml.required "MinSize"
               (Util.option_bind (Xml.member "MinSize" xml) Integer.parse));
          max_size =
            (Xml.required "MaxSize"
               (Util.option_bind (Xml.member "MaxSize" xml) Integer.parse));
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
          load_balancer_names =
            (Util.of_option []
               (Util.option_bind (Xml.member "LoadBalancerNames" xml)
                  LoadBalancerNames.parse));
          target_group_a_r_ns =
            (Util.of_option []
               (Util.option_bind (Xml.member "TargetGroupARNs" xml)
                  TargetGroupARNs.parse));
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
          lifecycle_hook_specification_list =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "LifecycleHookSpecificationList" xml)
                  LifecycleHookSpecifications.parse));
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) Tags.parse));
          service_linked_role_a_r_n =
            (Util.option_bind (Xml.member "ServiceLinkedRoleARN" xml)
               String.parse);
          max_instance_lifetime =
            (Util.option_bind (Xml.member "MaxInstanceLifetime" xml)
               Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((((((((((([] @
                                [Some
                                   (Ezxmlm.make_tag "AutoScalingGroupName"
                                      ([],
                                        (String.to_xml
                                           v.auto_scaling_group_name)))])
                               @
                               [Util.option_map v.launch_configuration_name
                                  (fun f ->
                                     Ezxmlm.make_tag
                                       "LaunchConfigurationName"
                                       ([], (String.to_xml f)))])
                              @
                              [Util.option_map v.launch_template
                                 (fun f ->
                                    Ezxmlm.make_tag "LaunchTemplate"
                                      ([],
                                        (LaunchTemplateSpecification.to_xml f)))])
                             @
                             [Util.option_map v.mixed_instances_policy
                                (fun f ->
                                   Ezxmlm.make_tag "MixedInstancesPolicy"
                                     ([], (MixedInstancesPolicy.to_xml f)))])
                            @
                            [Util.option_map v.instance_id
                               (fun f ->
                                  Ezxmlm.make_tag "InstanceId"
                                    ([], (String.to_xml f)))])
                           @
                           [Some
                              (Ezxmlm.make_tag "MinSize"
                                 ([], (Integer.to_xml v.min_size)))])
                          @
                          [Some
                             (Ezxmlm.make_tag "MaxSize"
                                ([], (Integer.to_xml v.max_size)))])
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
                      (List.map
                         (fun x ->
                            Some
                              (Ezxmlm.make_tag "LoadBalancerNames"
                                 ([], (LoadBalancerNames.to_xml [x]))))
                         v.load_balancer_names))
                     @
                     (List.map
                        (fun x ->
                           Some
                             (Ezxmlm.make_tag "TargetGroupARNs"
                                ([], (TargetGroupARNs.to_xml [x]))))
                        v.target_group_a_r_ns))
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
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "LifecycleHookSpecificationList"
                         ([], (LifecycleHookSpecifications.to_xml [x]))))
                 v.lifecycle_hook_specification_list))
             @
             (List.map
                (fun x ->
                   Some (Ezxmlm.make_tag "Tags" ([], (Tags.to_xml [x]))))
                v.tags))
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
type input = CreateAutoScalingGroupType.t
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
         ("Action", ["CreateAutoScalingGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateAutoScalingGroupType.to_query req))))) in
  (`POST, uri, (Headers.render (CreateAutoScalingGroupType.to_headers req)),
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