open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateLaunchConfigurationType =
  struct
    type t =
      {
      launch_configuration_name: String.t
        [@ocaml.doc
          "<p>The name of the launch configuration. This name must be unique per Region per account.</p>"];
      image_id: String.t option
        [@ocaml.doc
          "<p>The ID of the Amazon Machine Image (AMI) that was assigned during registration. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html\">Finding an AMI</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.</p> <p>If you do not specify <code>InstanceId</code>, you must specify <code>ImageId</code>.</p>"];
      key_name: String.t option
        [@ocaml.doc
          "<p>The name of the key pair. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html\">Amazon EC2 Key Pairs</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.</p>"];
      security_groups: SecurityGroups.t
        [@ocaml.doc
          "<p>A list that contains the security groups to assign to the instances in the Auto Scaling group.</p> <p>[EC2-VPC] Specify the security group IDs. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_SecurityGroups.html\">Security Groups for Your VPC</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p> <p>[EC2-Classic] Specify either the security group names or the security group IDs. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-network-security.html\">Amazon EC2 Security Groups</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.</p>"];
      classic_link_v_p_c_id: String.t option
        [@ocaml.doc
          "<p>The ID of a ClassicLink-enabled VPC to link your EC2-Classic instances to. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/vpc-classiclink.html\">ClassicLink</a> in the <i>Amazon EC2 User Guide for Linux Instances</i> and <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-in-vpc.html#as-ClassicLink\">Linking EC2-Classic Instances to a VPC</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p> <p>This parameter can only be used if you are launching EC2-Classic instances.</p>"];
      classic_link_v_p_c_security_groups: ClassicLinkVPCSecurityGroups.t
        [@ocaml.doc
          "<p>The IDs of one or more security groups for the specified ClassicLink-enabled VPC. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/vpc-classiclink.html\">ClassicLink</a> in the <i>Amazon EC2 User Guide for Linux Instances</i> and <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-in-vpc.html#as-ClassicLink\">Linking EC2-Classic Instances to a VPC</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p> <p>If you specify the <code>ClassicLinkVPCId</code> parameter, you must specify this parameter.</p>"];
      user_data: String.t option
        [@ocaml.doc
          "<p>The Base64-encoded user data to make available to the launched EC2 instances. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html\">Instance Metadata and User Data</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.</p>"];
      instance_id: String.t option
        [@ocaml.doc
          "<p>The ID of the instance to use to create the launch configuration. The new launch configuration derives attributes from the instance, except for the block device mapping.</p> <p>To create a launch configuration with a block device mapping or override any other instance attributes, specify them as part of the same request.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-lc-with-instanceID.html\">Create a Launch Configuration Using an EC2 Instance</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p> <p>If you do not specify <code>InstanceId</code>, you must specify both <code>ImageId</code> and <code>InstanceType</code>.</p>"];
      instance_type: String.t option
        [@ocaml.doc
          "<p>Specifies the instance type of the EC2 instance.</p> <p>For information about available instance types, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html#AvailableInstanceTypes\">Available Instance Types</a> in the <i>Amazon EC2 User Guide for Linux Instances.</i> </p> <p>If you do not specify <code>InstanceId</code>, you must specify <code>InstanceType</code>.</p>"];
      kernel_id: String.t option
        [@ocaml.doc "<p>The ID of the kernel associated with the AMI.</p>"];
      ramdisk_id: String.t option
        [@ocaml.doc "<p>The ID of the RAM disk to select.</p>"];
      block_device_mappings: BlockDeviceMappings.t
        [@ocaml.doc
          "<p>A block device mapping, which specifies the block devices for the instance. You can specify virtual devices and EBS volumes. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/block-device-mapping-concepts.html\">Block Device Mapping</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.</p>"];
      instance_monitoring: InstanceMonitoring.t option
        [@ocaml.doc
          "<p>Controls whether instances in this group are launched with detailed (<code>true</code>) or basic (<code>false</code>) monitoring.</p> <p>The default value is <code>true</code> (enabled).</p> <important> <p>When detailed monitoring is enabled, Amazon CloudWatch generates metrics every minute and your account is charged a fee. When you disable detailed monitoring, CloudWatch generates metrics every 5 minutes. For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/latest/userguide/as-instance-monitoring.html#enable-as-instance-metrics\">Configure Monitoring for Auto Scaling Instances</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p> </important>"];
      spot_price: String.t option
        [@ocaml.doc
          "<p>The maximum hourly price to be paid for any Spot Instance launched to fulfill the request. Spot Instances are launched when the price you specify exceeds the current Spot price. For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-launch-spot-instances.html\">Launching Spot Instances in Your Auto Scaling Group</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p> <note> <p>When you change your maximum price by creating a new launch configuration, running instances will continue to run as long as the maximum price for those running instances is higher than the current Spot price.</p> </note>"];
      iam_instance_profile: String.t option
        [@ocaml.doc
          "<p>The name or the Amazon Resource Name (ARN) of the instance profile associated with the IAM role for the instance. The instance profile contains the IAM role.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/us-iam-role.html\">IAM Role for Applications That Run on Amazon EC2 Instances</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"];
      ebs_optimized: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the launch configuration is optimized for EBS I/O (<code>true</code>) or not (<code>false</code>). The optimization provides dedicated throughput to Amazon EBS and an optimized configuration stack to provide optimal I/O performance. This optimization is not available with all instance types. Additional fees are incurred when you enable EBS optimization for an instance type that is not EBS-optimized by default. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSOptimized.html\">Amazon EBS-Optimized Instances</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.</p> <p>The default value is <code>false</code>.</p>"];
      associate_public_ip_address: Boolean.t option
        [@ocaml.doc
          "<p>For Auto Scaling groups that are running in a virtual private cloud (VPC), specifies whether to assign a public IP address to the group's instances. If you specify <code>true</code>, each instance in the Auto Scaling group receives a unique public IP address. For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-in-vpc.html\">Launching Auto Scaling Instances in a VPC</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p> <p>If you specify this parameter, you must specify at least one subnet for <code>VPCZoneIdentifier</code> when you create your group.</p> <note> <p>If the instance is launched into a default subnet, the default is to assign a public IP address, unless you disabled the option to assign a public IP address on the subnet. If the instance is launched into a nondefault subnet, the default is not to assign a public IP address, unless you enabled the option to assign a public IP address on the subnet.</p> </note>"];
      placement_tenancy: String.t option
        [@ocaml.doc
          "<p>The tenancy of the instance. An instance with <code>dedicated</code> tenancy runs on isolated, single-tenant hardware and can only be launched into a VPC.</p> <p>To launch dedicated instances into a shared tenancy VPC (a VPC with the instance placement tenancy attribute set to <code>default</code>), you must set the value of this parameter to <code>dedicated</code>.</p> <p>If you specify <code>PlacementTenancy</code>, you must specify at least one subnet for <code>VPCZoneIdentifier</code> when you create your group.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-in-vpc.html#as-vpc-tenancy\">Instance Placement Tenancy</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p> <p>Valid Values: <code>default</code> | <code>dedicated</code> </p>"]}
    let make ~launch_configuration_name  ?image_id  ?key_name 
      ?(security_groups= [])  ?classic_link_v_p_c_id 
      ?(classic_link_v_p_c_security_groups= [])  ?user_data  ?instance_id 
      ?instance_type  ?kernel_id  ?ramdisk_id  ?(block_device_mappings= []) 
      ?instance_monitoring  ?spot_price  ?iam_instance_profile 
      ?ebs_optimized  ?associate_public_ip_address  ?placement_tenancy  () =
      {
        launch_configuration_name;
        image_id;
        key_name;
        security_groups;
        classic_link_v_p_c_id;
        classic_link_v_p_c_security_groups;
        user_data;
        instance_id;
        instance_type;
        kernel_id;
        ramdisk_id;
        block_device_mappings;
        instance_monitoring;
        spot_price;
        iam_instance_profile;
        ebs_optimized;
        associate_public_ip_address;
        placement_tenancy
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.placement_tenancy
              (fun f -> ("placement_tenancy", (String.to_json f)));
           Util.option_map v.associate_public_ip_address
             (fun f -> ("associate_public_ip_address", (Boolean.to_json f)));
           Util.option_map v.ebs_optimized
             (fun f -> ("ebs_optimized", (Boolean.to_json f)));
           Util.option_map v.iam_instance_profile
             (fun f -> ("iam_instance_profile", (String.to_json f)));
           Util.option_map v.spot_price
             (fun f -> ("spot_price", (String.to_json f)));
           Util.option_map v.instance_monitoring
             (fun f ->
                ("instance_monitoring", (InstanceMonitoring.to_json f)));
           Some
             ("block_device_mappings",
               (BlockDeviceMappings.to_json v.block_device_mappings));
           Util.option_map v.ramdisk_id
             (fun f -> ("ramdisk_id", (String.to_json f)));
           Util.option_map v.kernel_id
             (fun f -> ("kernel_id", (String.to_json f)));
           Util.option_map v.instance_type
             (fun f -> ("instance_type", (String.to_json f)));
           Util.option_map v.instance_id
             (fun f -> ("instance_id", (String.to_json f)));
           Util.option_map v.user_data
             (fun f -> ("user_data", (String.to_json f)));
           Some
             ("classic_link_v_p_c_security_groups",
               (ClassicLinkVPCSecurityGroups.to_json
                  v.classic_link_v_p_c_security_groups));
           Util.option_map v.classic_link_v_p_c_id
             (fun f -> ("classic_link_v_p_c_id", (String.to_json f)));
           Some
             ("security_groups", (SecurityGroups.to_json v.security_groups));
           Util.option_map v.key_name
             (fun f -> ("key_name", (String.to_json f)));
           Util.option_map v.image_id
             (fun f -> ("image_id", (String.to_json f)));
           Some
             ("launch_configuration_name",
               (String.to_json v.launch_configuration_name))])
    let parse xml =
      Some
        {
          launch_configuration_name =
            (Xml.required "LaunchConfigurationName"
               (Util.option_bind (Xml.member "LaunchConfigurationName" xml)
                  String.parse));
          image_id =
            (Util.option_bind (Xml.member "ImageId" xml) String.parse);
          key_name =
            (Util.option_bind (Xml.member "KeyName" xml) String.parse);
          security_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "SecurityGroups" xml)
                  SecurityGroups.parse));
          classic_link_v_p_c_id =
            (Util.option_bind (Xml.member "ClassicLinkVPCId" xml)
               String.parse);
          classic_link_v_p_c_security_groups =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "ClassicLinkVPCSecurityGroups" xml)
                  ClassicLinkVPCSecurityGroups.parse));
          user_data =
            (Util.option_bind (Xml.member "UserData" xml) String.parse);
          instance_id =
            (Util.option_bind (Xml.member "InstanceId" xml) String.parse);
          instance_type =
            (Util.option_bind (Xml.member "InstanceType" xml) String.parse);
          kernel_id =
            (Util.option_bind (Xml.member "KernelId" xml) String.parse);
          ramdisk_id =
            (Util.option_bind (Xml.member "RamdiskId" xml) String.parse);
          block_device_mappings =
            (Util.of_option []
               (Util.option_bind (Xml.member "BlockDeviceMappings" xml)
                  BlockDeviceMappings.parse));
          instance_monitoring =
            (Util.option_bind (Xml.member "InstanceMonitoring" xml)
               InstanceMonitoring.parse);
          spot_price =
            (Util.option_bind (Xml.member "SpotPrice" xml) String.parse);
          iam_instance_profile =
            (Util.option_bind (Xml.member "IamInstanceProfile" xml)
               String.parse);
          ebs_optimized =
            (Util.option_bind (Xml.member "EbsOptimized" xml) Boolean.parse);
          associate_public_ip_address =
            (Util.option_bind (Xml.member "AssociatePublicIpAddress" xml)
               Boolean.parse);
          placement_tenancy =
            (Util.option_bind (Xml.member "PlacementTenancy" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((((((([] @
                            [Some
                               (Ezxmlm.make_tag "LaunchConfigurationName"
                                  ([],
                                    (String.to_xml
                                       v.launch_configuration_name)))])
                           @
                           [Util.option_map v.image_id
                              (fun f ->
                                 Ezxmlm.make_tag "ImageId"
                                   ([], (String.to_xml f)))])
                          @
                          [Util.option_map v.key_name
                             (fun f ->
                                Ezxmlm.make_tag "KeyName"
                                  ([], (String.to_xml f)))])
                         @
                         (List.map
                            (fun x ->
                               Some
                                 (Ezxmlm.make_tag "SecurityGroups"
                                    ([], (SecurityGroups.to_xml [x]))))
                            v.security_groups))
                        @
                        [Util.option_map v.classic_link_v_p_c_id
                           (fun f ->
                              Ezxmlm.make_tag "ClassicLinkVPCId"
                                ([], (String.to_xml f)))])
                       @
                       (List.map
                          (fun x ->
                             Some
                               (Ezxmlm.make_tag
                                  "ClassicLinkVPCSecurityGroups"
                                  ([],
                                    (ClassicLinkVPCSecurityGroups.to_xml [x]))))
                          v.classic_link_v_p_c_security_groups))
                      @
                      [Util.option_map v.user_data
                         (fun f ->
                            Ezxmlm.make_tag "UserData"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.instance_id
                        (fun f ->
                           Ezxmlm.make_tag "InstanceId"
                             ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.instance_type
                       (fun f ->
                          Ezxmlm.make_tag "InstanceType"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.kernel_id
                      (fun f ->
                         Ezxmlm.make_tag "KernelId" ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.ramdisk_id
                     (fun f ->
                        Ezxmlm.make_tag "RamdiskId" ([], (String.to_xml f)))])
                 @
                 (List.map
                    (fun x ->
                       Some
                         (Ezxmlm.make_tag "BlockDeviceMappings"
                            ([], (BlockDeviceMappings.to_xml [x]))))
                    v.block_device_mappings))
                @
                [Util.option_map v.instance_monitoring
                   (fun f ->
                      Ezxmlm.make_tag "InstanceMonitoring"
                        ([], (InstanceMonitoring.to_xml f)))])
               @
               [Util.option_map v.spot_price
                  (fun f ->
                     Ezxmlm.make_tag "SpotPrice" ([], (String.to_xml f)))])
              @
              [Util.option_map v.iam_instance_profile
                 (fun f ->
                    Ezxmlm.make_tag "IamInstanceProfile"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.ebs_optimized
                (fun f ->
                   Ezxmlm.make_tag "EbsOptimized" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.associate_public_ip_address
               (fun f ->
                  Ezxmlm.make_tag "AssociatePublicIpAddress"
                    ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.placement_tenancy
              (fun f ->
                 Ezxmlm.make_tag "PlacementTenancy" ([], (String.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = CreateLaunchConfigurationType.t
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
         ("Action", ["CreateLaunchConfiguration"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateLaunchConfigurationType.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateLaunchConfigurationType.to_headers req)), "")
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