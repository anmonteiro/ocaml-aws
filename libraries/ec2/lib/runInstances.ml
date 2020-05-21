open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RunInstancesRequest =
  struct
    type t =
      {
      block_device_mappings: BlockDeviceMappingRequestList.t
        [@ocaml.doc "<p>The block device mapping entries.</p>"];
      image_id: String.t option
        [@ocaml.doc
          "<p>The ID of the AMI. An AMI ID is required to launch an instance and must be specified here or in a launch template.</p>"];
      instance_type: InstanceType.t option
        [@ocaml.doc
          "<p>The instance type. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html\">Instance Types</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p> <p>Default: <code>m1.small</code> </p>"];
      ipv6_address_count: Integer.t option
        [@ocaml.doc
          "<p>[EC2-VPC] The number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet. You cannot specify this option and the option to assign specific IPv6 addresses in the same request. You can specify this option if you've specified a minimum number of instances to launch.</p> <p>You cannot specify this option and the network interfaces option in the same request.</p>"];
      ipv6_addresses: InstanceIpv6AddressList.t
        [@ocaml.doc
          "<p>[EC2-VPC] The IPv6 addresses from the range of the subnet to associate with the primary network interface. You cannot specify this option and the option to assign a number of IPv6 addresses in the same request. You cannot specify this option if you've specified a minimum number of instances to launch.</p> <p>You cannot specify this option and the network interfaces option in the same request.</p>"];
      kernel_id: String.t option
        [@ocaml.doc
          "<p>The ID of the kernel.</p> <important> <p>We recommend that you use PV-GRUB instead of kernels and RAM disks. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/UserProvidedkernels.html\"> PV-GRUB</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p> </important>"];
      key_name: String.t option
        [@ocaml.doc
          "<p>The name of the key pair. You can create a key pair using <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateKeyPair.html\">CreateKeyPair</a> or <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ImportKeyPair.html\">ImportKeyPair</a>.</p> <important> <p>If you do not specify a key pair, you can't connect to the instance unless you choose an AMI that is configured to allow users another way to log in.</p> </important>"];
      max_count: Integer.t
        [@ocaml.doc
          "<p>The maximum number of instances to launch. If you specify more instances than Amazon EC2 can launch in the target Availability Zone, Amazon EC2 launches the largest possible number of instances above <code>MinCount</code>.</p> <p>Constraints: Between 1 and the maximum number you're allowed for the specified instance type. For more information about the default limits, and how to request an increase, see <a href=\"http://aws.amazon.com/ec2/faqs/#How_many_instances_can_I_run_in_Amazon_EC2\">How many instances can I run in Amazon EC2</a> in the Amazon EC2 FAQ.</p>"];
      min_count: Integer.t
        [@ocaml.doc
          "<p>The minimum number of instances to launch. If you specify a minimum that is more instances than Amazon EC2 can launch in the target Availability Zone, Amazon EC2 launches no instances.</p> <p>Constraints: Between 1 and the maximum number you're allowed for the specified instance type. For more information about the default limits, and how to request an increase, see <a href=\"http://aws.amazon.com/ec2/faqs/#How_many_instances_can_I_run_in_Amazon_EC2\">How many instances can I run in Amazon EC2</a> in the Amazon EC2 General FAQ.</p>"];
      monitoring: RunInstancesMonitoringEnabled.t option
        [@ocaml.doc
          "<p>Specifies whether detailed monitoring is enabled for the instance.</p>"];
      placement: Placement.t option
        [@ocaml.doc "<p>The placement for the instance.</p>"];
      ramdisk_id: String.t option
        [@ocaml.doc
          "<p>The ID of the RAM disk to select. Some kernels require additional drivers at launch. Check the kernel requirements for information about whether you need to specify a RAM disk. To find kernel requirements, go to the AWS Resource Center and search for the kernel ID.</p> <important> <p>We recommend that you use PV-GRUB instead of kernels and RAM disks. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/UserProvidedkernels.html\"> PV-GRUB</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p> </important>"];
      security_group_ids: SecurityGroupIdStringList.t
        [@ocaml.doc
          "<p>The IDs of the security groups. You can create a security group using <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateSecurityGroup.html\">CreateSecurityGroup</a>.</p> <p>If you specify a network interface, you must specify any security groups as part of the network interface.</p>"];
      security_groups: SecurityGroupStringList.t
        [@ocaml.doc
          "<p>[EC2-Classic, default VPC] The names of the security groups. For a nondefault VPC, you must use security group IDs instead.</p> <p>If you specify a network interface, you must specify any security groups as part of the network interface.</p> <p>Default: Amazon EC2 uses the default security group.</p>"];
      subnet_id: String.t option
        [@ocaml.doc
          "<p>[EC2-VPC] The ID of the subnet to launch the instance into.</p> <p>If you specify a network interface, you must specify any subnets as part of the network interface.</p>"];
      user_data: String.t option
        [@ocaml.doc
          "<p>The user data to make available to the instance. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html\">Running Commands on Your Linux Instance at Launch</a> (Linux) and <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/ec2-instance-metadata.html#instancedata-add-user-data\">Adding User Data</a> (Windows). If you are using a command line tool, base64-encoding is performed for you, and you can load the text from a file. Otherwise, you must provide base64-encoded text. User data is limited to 16 KB.</p>"];
      additional_info: String.t option [@ocaml.doc "<p>Reserved.</p>"];
      client_token: String.t option
        [@ocaml.doc
          "<p>Unique, case-sensitive identifier you provide to ensure the idempotency of the request. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html\">Ensuring Idempotency</a>.</p> <p>Constraints: Maximum 64 ASCII characters</p>"];
      disable_api_termination: Boolean.t option
        [@ocaml.doc
          "<p>If you set this parameter to <code>true</code>, you can't terminate the instance using the Amazon EC2 console, CLI, or API; otherwise, you can. To change this attribute after launch, use <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ModifyInstanceAttribute.html\">ModifyInstanceAttribute</a>. Alternatively, if you set <code>InstanceInitiatedShutdownBehavior</code> to <code>terminate</code>, you can terminate the instance by running the shutdown command from the instance.</p> <p>Default: <code>false</code> </p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      ebs_optimized: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether the instance is optimized for Amazon EBS I/O. This optimization provides dedicated throughput to Amazon EBS and an optimized configuration stack to provide optimal Amazon EBS I/O performance. This optimization isn't available with all instance types. Additional usage charges apply when using an EBS-optimized instance.</p> <p>Default: <code>false</code> </p>"];
      iam_instance_profile: IamInstanceProfileSpecification.t option
        [@ocaml.doc "<p>The IAM instance profile.</p>"];
      instance_initiated_shutdown_behavior: ShutdownBehavior.t option
        [@ocaml.doc
          "<p>Indicates whether an instance stops or terminates when you initiate shutdown from the instance (using the operating system command for system shutdown).</p> <p>Default: <code>stop</code> </p>"];
      network_interfaces: InstanceNetworkInterfaceSpecificationList.t
        [@ocaml.doc
          "<p>The network interfaces to associate with the instance. If you specify a network interface, you must specify any security groups and subnets as part of the network interface.</p>"];
      private_ip_address: String.t option
        [@ocaml.doc
          "<p>[EC2-VPC] The primary IPv4 address. You must specify a value from the IPv4 address range of the subnet.</p> <p>Only one private IP address can be designated as primary. You can't specify this option if you've specified the option to designate a private IP address as the primary IP address in a network interface specification. You cannot specify this option if you're launching more than one instance in the request.</p> <p>You cannot specify this option and the network interfaces option in the same request.</p>"];
      elastic_gpu_specification: ElasticGpuSpecifications.t
        [@ocaml.doc
          "<p>An elastic GPU to associate with the instance. An Elastic GPU is a GPU resource that you can attach to your Windows instance to accelerate the graphics performance of your applications. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/elastic-graphics.html\"> Amazon EC2 Elastic GPUs</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>"];
      elastic_inference_accelerators: ElasticInferenceAccelerators.t
        [@ocaml.doc
          "<p>An elastic inference accelerator to associate with the instance. Elastic inference accelerators are a resource you can attach to your Amazon EC2 instances to accelerate your Deep Learning (DL) inference workloads.</p>"];
      tag_specifications: TagSpecificationList.t
        [@ocaml.doc
          "<p>The tags to apply to the resources during launch. You can only tag instances and volumes on launch. The specified tags are applied to all instances or volumes that are created during launch. To tag a resource after it has been created, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateTags.html\">CreateTags</a>.</p>"];
      launch_template: LaunchTemplateSpecification.t option
        [@ocaml.doc
          "<p>The launch template to use to launch the instances. Any parameters that you specify in <a>RunInstances</a> override the same parameters in the launch template. You can specify either the name or ID of a launch template, but not both.</p>"];
      instance_market_options: InstanceMarketOptionsRequest.t option
        [@ocaml.doc
          "<p>The market (purchasing) option for the instances.</p> <p>For <a>RunInstances</a>, persistent Spot Instance requests are only supported when <b>InstanceInterruptionBehavior</b> is set to either <code>hibernate</code> or <code>stop</code>.</p>"];
      credit_specification: CreditSpecificationRequest.t option
        [@ocaml.doc
          "<p>The credit option for CPU usage of the burstable performance instance. Valid values are <code>standard</code> and <code>unlimited</code>. To change this attribute after launch, use <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ModifyInstanceCreditSpecification.html\"> ModifyInstanceCreditSpecification</a>. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances.html\">Burstable Performance Instances</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p> <p>Default: <code>standard</code> (T2 instances) or <code>unlimited</code> (T3/T3a instances)</p>"];
      cpu_options: CpuOptionsRequest.t option
        [@ocaml.doc
          "<p>The CPU options for the instance. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-optimize-cpu.html\">Optimizing CPU Options</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>"];
      capacity_reservation_specification:
        CapacityReservationSpecification.t option
        [@ocaml.doc
          "<p>Information about the Capacity Reservation targeting option. If you do not specify this parameter, the instance's Capacity Reservation preference defaults to <code>open</code>, which enables it to run in any open Capacity Reservation that has matching attributes (instance type, platform, Availability Zone).</p>"];
      hibernation_options: HibernationOptionsRequest.t option
        [@ocaml.doc
          "<p>Indicates whether an instance is enabled for hibernation. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Hibernate.html\">Hibernate Your Instance</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>"];
      license_specifications: LicenseSpecificationListRequest.t
        [@ocaml.doc "<p>The license configurations.</p>"];
      metadata_options: InstanceMetadataOptionsRequest.t option
        [@ocaml.doc
          "<p>The metadata options for the instance. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html\">Instance Metadata and User Data</a>.</p>"]}
    let make ?(block_device_mappings= [])  ?image_id  ?instance_type 
      ?ipv6_address_count  ?(ipv6_addresses= [])  ?kernel_id  ?key_name 
      ~max_count  ~min_count  ?monitoring  ?placement  ?ramdisk_id 
      ?(security_group_ids= [])  ?(security_groups= [])  ?subnet_id 
      ?user_data  ?additional_info  ?client_token  ?disable_api_termination 
      ?dry_run  ?ebs_optimized  ?iam_instance_profile 
      ?instance_initiated_shutdown_behavior  ?(network_interfaces= []) 
      ?private_ip_address  ?(elastic_gpu_specification= []) 
      ?(elastic_inference_accelerators= [])  ?(tag_specifications= []) 
      ?launch_template  ?instance_market_options  ?credit_specification 
      ?cpu_options  ?capacity_reservation_specification  ?hibernation_options
       ?(license_specifications= [])  ?metadata_options  () =
      {
        block_device_mappings;
        image_id;
        instance_type;
        ipv6_address_count;
        ipv6_addresses;
        kernel_id;
        key_name;
        max_count;
        min_count;
        monitoring;
        placement;
        ramdisk_id;
        security_group_ids;
        security_groups;
        subnet_id;
        user_data;
        additional_info;
        client_token;
        disable_api_termination;
        dry_run;
        ebs_optimized;
        iam_instance_profile;
        instance_initiated_shutdown_behavior;
        network_interfaces;
        private_ip_address;
        elastic_gpu_specification;
        elastic_inference_accelerators;
        tag_specifications;
        launch_template;
        instance_market_options;
        credit_specification;
        cpu_options;
        capacity_reservation_specification;
        hibernation_options;
        license_specifications;
        metadata_options
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.metadata_options
              (fun f ->
                 Query.Pair
                   ("MetadataOptions",
                     (InstanceMetadataOptionsRequest.to_query f)));
           Some
             (Query.Pair
                ("LicenseSpecification",
                  (LicenseSpecificationListRequest.to_query
                     v.license_specifications)));
           Util.option_map v.hibernation_options
             (fun f ->
                Query.Pair
                  ("HibernationOptions",
                    (HibernationOptionsRequest.to_query f)));
           Util.option_map v.capacity_reservation_specification
             (fun f ->
                Query.Pair
                  ("CapacityReservationSpecification",
                    (CapacityReservationSpecification.to_query f)));
           Util.option_map v.cpu_options
             (fun f ->
                Query.Pair ("CpuOptions", (CpuOptionsRequest.to_query f)));
           Util.option_map v.credit_specification
             (fun f ->
                Query.Pair
                  ("CreditSpecification",
                    (CreditSpecificationRequest.to_query f)));
           Util.option_map v.instance_market_options
             (fun f ->
                Query.Pair
                  ("InstanceMarketOptions",
                    (InstanceMarketOptionsRequest.to_query f)));
           Util.option_map v.launch_template
             (fun f ->
                Query.Pair
                  ("LaunchTemplate",
                    (LaunchTemplateSpecification.to_query f)));
           Some
             (Query.Pair
                ("TagSpecification",
                  (TagSpecificationList.to_query v.tag_specifications)));
           Some
             (Query.Pair
                ("ElasticInferenceAccelerator",
                  (ElasticInferenceAccelerators.to_query
                     v.elastic_inference_accelerators)));
           Some
             (Query.Pair
                ("ElasticGpuSpecification",
                  (ElasticGpuSpecifications.to_query
                     v.elastic_gpu_specification)));
           Util.option_map v.private_ip_address
             (fun f -> Query.Pair ("PrivateIpAddress", (String.to_query f)));
           Some
             (Query.Pair
                ("NetworkInterface",
                  (InstanceNetworkInterfaceSpecificationList.to_query
                     v.network_interfaces)));
           Util.option_map v.instance_initiated_shutdown_behavior
             (fun f ->
                Query.Pair
                  ("InstanceInitiatedShutdownBehavior",
                    (ShutdownBehavior.to_query f)));
           Util.option_map v.iam_instance_profile
             (fun f ->
                Query.Pair
                  ("IamInstanceProfile",
                    (IamInstanceProfileSpecification.to_query f)));
           Util.option_map v.ebs_optimized
             (fun f -> Query.Pair ("EbsOptimized", (Boolean.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.disable_api_termination
             (fun f ->
                Query.Pair ("DisableApiTermination", (Boolean.to_query f)));
           Util.option_map v.client_token
             (fun f -> Query.Pair ("ClientToken", (String.to_query f)));
           Util.option_map v.additional_info
             (fun f -> Query.Pair ("AdditionalInfo", (String.to_query f)));
           Util.option_map v.user_data
             (fun f -> Query.Pair ("UserData", (String.to_query f)));
           Util.option_map v.subnet_id
             (fun f -> Query.Pair ("SubnetId", (String.to_query f)));
           Some
             (Query.Pair
                ("SecurityGroup",
                  (SecurityGroupStringList.to_query v.security_groups)));
           Some
             (Query.Pair
                ("SecurityGroupId",
                  (SecurityGroupIdStringList.to_query v.security_group_ids)));
           Util.option_map v.ramdisk_id
             (fun f -> Query.Pair ("RamdiskId", (String.to_query f)));
           Util.option_map v.placement
             (fun f -> Query.Pair ("Placement", (Placement.to_query f)));
           Util.option_map v.monitoring
             (fun f ->
                Query.Pair
                  ("Monitoring", (RunInstancesMonitoringEnabled.to_query f)));
           Some (Query.Pair ("MinCount", (Integer.to_query v.min_count)));
           Some (Query.Pair ("MaxCount", (Integer.to_query v.max_count)));
           Util.option_map v.key_name
             (fun f -> Query.Pair ("KeyName", (String.to_query f)));
           Util.option_map v.kernel_id
             (fun f -> Query.Pair ("KernelId", (String.to_query f)));
           Some
             (Query.Pair
                ("Ipv6Address",
                  (InstanceIpv6AddressList.to_query v.ipv6_addresses)));
           Util.option_map v.ipv6_address_count
             (fun f -> Query.Pair ("Ipv6AddressCount", (Integer.to_query f)));
           Util.option_map v.instance_type
             (fun f -> Query.Pair ("InstanceType", (InstanceType.to_query f)));
           Util.option_map v.image_id
             (fun f -> Query.Pair ("ImageId", (String.to_query f)));
           Some
             (Query.Pair
                ("BlockDeviceMapping",
                  (BlockDeviceMappingRequestList.to_query
                     v.block_device_mappings)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.metadata_options
              (fun f ->
                 ("metadata_options",
                   (InstanceMetadataOptionsRequest.to_json f)));
           Some
             ("license_specifications",
               (LicenseSpecificationListRequest.to_json
                  v.license_specifications));
           Util.option_map v.hibernation_options
             (fun f ->
                ("hibernation_options",
                  (HibernationOptionsRequest.to_json f)));
           Util.option_map v.capacity_reservation_specification
             (fun f ->
                ("capacity_reservation_specification",
                  (CapacityReservationSpecification.to_json f)));
           Util.option_map v.cpu_options
             (fun f -> ("cpu_options", (CpuOptionsRequest.to_json f)));
           Util.option_map v.credit_specification
             (fun f ->
                ("credit_specification",
                  (CreditSpecificationRequest.to_json f)));
           Util.option_map v.instance_market_options
             (fun f ->
                ("instance_market_options",
                  (InstanceMarketOptionsRequest.to_json f)));
           Util.option_map v.launch_template
             (fun f ->
                ("launch_template", (LaunchTemplateSpecification.to_json f)));
           Some
             ("tag_specifications",
               (TagSpecificationList.to_json v.tag_specifications));
           Some
             ("elastic_inference_accelerators",
               (ElasticInferenceAccelerators.to_json
                  v.elastic_inference_accelerators));
           Some
             ("elastic_gpu_specification",
               (ElasticGpuSpecifications.to_json v.elastic_gpu_specification));
           Util.option_map v.private_ip_address
             (fun f -> ("private_ip_address", (String.to_json f)));
           Some
             ("network_interfaces",
               (InstanceNetworkInterfaceSpecificationList.to_json
                  v.network_interfaces));
           Util.option_map v.instance_initiated_shutdown_behavior
             (fun f ->
                ("instance_initiated_shutdown_behavior",
                  (ShutdownBehavior.to_json f)));
           Util.option_map v.iam_instance_profile
             (fun f ->
                ("iam_instance_profile",
                  (IamInstanceProfileSpecification.to_json f)));
           Util.option_map v.ebs_optimized
             (fun f -> ("ebs_optimized", (Boolean.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.disable_api_termination
             (fun f -> ("disable_api_termination", (Boolean.to_json f)));
           Util.option_map v.client_token
             (fun f -> ("client_token", (String.to_json f)));
           Util.option_map v.additional_info
             (fun f -> ("additional_info", (String.to_json f)));
           Util.option_map v.user_data
             (fun f -> ("user_data", (String.to_json f)));
           Util.option_map v.subnet_id
             (fun f -> ("subnet_id", (String.to_json f)));
           Some
             ("security_groups",
               (SecurityGroupStringList.to_json v.security_groups));
           Some
             ("security_group_ids",
               (SecurityGroupIdStringList.to_json v.security_group_ids));
           Util.option_map v.ramdisk_id
             (fun f -> ("ramdisk_id", (String.to_json f)));
           Util.option_map v.placement
             (fun f -> ("placement", (Placement.to_json f)));
           Util.option_map v.monitoring
             (fun f ->
                ("monitoring", (RunInstancesMonitoringEnabled.to_json f)));
           Some ("min_count", (Integer.to_json v.min_count));
           Some ("max_count", (Integer.to_json v.max_count));
           Util.option_map v.key_name
             (fun f -> ("key_name", (String.to_json f)));
           Util.option_map v.kernel_id
             (fun f -> ("kernel_id", (String.to_json f)));
           Some
             ("ipv6_addresses",
               (InstanceIpv6AddressList.to_json v.ipv6_addresses));
           Util.option_map v.ipv6_address_count
             (fun f -> ("ipv6_address_count", (Integer.to_json f)));
           Util.option_map v.instance_type
             (fun f -> ("instance_type", (InstanceType.to_json f)));
           Util.option_map v.image_id
             (fun f -> ("image_id", (String.to_json f)));
           Some
             ("block_device_mappings",
               (BlockDeviceMappingRequestList.to_json v.block_device_mappings))])
    let parse xml =
      Some
        {
          block_device_mappings =
            (Util.of_option []
               (Util.option_bind (Xml.member "BlockDeviceMapping" xml)
                  BlockDeviceMappingRequestList.parse));
          image_id =
            (Util.option_bind (Xml.member "ImageId" xml) String.parse);
          instance_type =
            (Util.option_bind (Xml.member "InstanceType" xml)
               InstanceType.parse);
          ipv6_address_count =
            (Util.option_bind (Xml.member "Ipv6AddressCount" xml)
               Integer.parse);
          ipv6_addresses =
            (Util.of_option []
               (Util.option_bind (Xml.member "Ipv6Address" xml)
                  InstanceIpv6AddressList.parse));
          kernel_id =
            (Util.option_bind (Xml.member "KernelId" xml) String.parse);
          key_name =
            (Util.option_bind (Xml.member "KeyName" xml) String.parse);
          max_count =
            (Xml.required "MaxCount"
               (Util.option_bind (Xml.member "MaxCount" xml) Integer.parse));
          min_count =
            (Xml.required "MinCount"
               (Util.option_bind (Xml.member "MinCount" xml) Integer.parse));
          monitoring =
            (Util.option_bind (Xml.member "Monitoring" xml)
               RunInstancesMonitoringEnabled.parse);
          placement =
            (Util.option_bind (Xml.member "Placement" xml) Placement.parse);
          ramdisk_id =
            (Util.option_bind (Xml.member "RamdiskId" xml) String.parse);
          security_group_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "SecurityGroupId" xml)
                  SecurityGroupIdStringList.parse));
          security_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "SecurityGroup" xml)
                  SecurityGroupStringList.parse));
          subnet_id =
            (Util.option_bind (Xml.member "SubnetId" xml) String.parse);
          user_data =
            (Util.option_bind (Xml.member "UserData" xml) String.parse);
          additional_info =
            (Util.option_bind (Xml.member "additionalInfo" xml) String.parse);
          client_token =
            (Util.option_bind (Xml.member "clientToken" xml) String.parse);
          disable_api_termination =
            (Util.option_bind (Xml.member "disableApiTermination" xml)
               Boolean.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          ebs_optimized =
            (Util.option_bind (Xml.member "ebsOptimized" xml) Boolean.parse);
          iam_instance_profile =
            (Util.option_bind (Xml.member "iamInstanceProfile" xml)
               IamInstanceProfileSpecification.parse);
          instance_initiated_shutdown_behavior =
            (Util.option_bind
               (Xml.member "instanceInitiatedShutdownBehavior" xml)
               ShutdownBehavior.parse);
          network_interfaces =
            (Util.of_option []
               (Util.option_bind (Xml.member "networkInterface" xml)
                  InstanceNetworkInterfaceSpecificationList.parse));
          private_ip_address =
            (Util.option_bind (Xml.member "privateIpAddress" xml)
               String.parse);
          elastic_gpu_specification =
            (Util.of_option []
               (Util.option_bind (Xml.member "ElasticGpuSpecification" xml)
                  ElasticGpuSpecifications.parse));
          elastic_inference_accelerators =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "ElasticInferenceAccelerator" xml)
                  ElasticInferenceAccelerators.parse));
          tag_specifications =
            (Util.of_option []
               (Util.option_bind (Xml.member "TagSpecification" xml)
                  TagSpecificationList.parse));
          launch_template =
            (Util.option_bind (Xml.member "LaunchTemplate" xml)
               LaunchTemplateSpecification.parse);
          instance_market_options =
            (Util.option_bind (Xml.member "InstanceMarketOptions" xml)
               InstanceMarketOptionsRequest.parse);
          credit_specification =
            (Util.option_bind (Xml.member "CreditSpecification" xml)
               CreditSpecificationRequest.parse);
          cpu_options =
            (Util.option_bind (Xml.member "CpuOptions" xml)
               CpuOptionsRequest.parse);
          capacity_reservation_specification =
            (Util.option_bind
               (Xml.member "CapacityReservationSpecification" xml)
               CapacityReservationSpecification.parse);
          hibernation_options =
            (Util.option_bind (Xml.member "HibernationOptions" xml)
               HibernationOptionsRequest.parse);
          license_specifications =
            (Util.of_option []
               (Util.option_bind (Xml.member "LicenseSpecification" xml)
                  LicenseSpecificationListRequest.parse));
          metadata_options =
            (Util.option_bind (Xml.member "MetadataOptions" xml)
               InstanceMetadataOptionsRequest.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((((((((((((((((((((((((([] @
                                              (List.map
                                                 (fun x ->
                                                    Some
                                                      (Ezxmlm.make_tag
                                                         "BlockDeviceMapping"
                                                         ([],
                                                           (BlockDeviceMappingRequestList.to_xml
                                                              [x]))))
                                                 v.block_device_mappings))
                                             @
                                             [Util.option_map v.image_id
                                                (fun f ->
                                                   Ezxmlm.make_tag "ImageId"
                                                     ([], (String.to_xml f)))])
                                            @
                                            [Util.option_map v.instance_type
                                               (fun f ->
                                                  Ezxmlm.make_tag
                                                    "InstanceType"
                                                    ([],
                                                      (InstanceType.to_xml f)))])
                                           @
                                           [Util.option_map
                                              v.ipv6_address_count
                                              (fun f ->
                                                 Ezxmlm.make_tag
                                                   "Ipv6AddressCount"
                                                   ([], (Integer.to_xml f)))])
                                          @
                                          (List.map
                                             (fun x ->
                                                Some
                                                  (Ezxmlm.make_tag
                                                     "Ipv6Address"
                                                     ([],
                                                       (InstanceIpv6AddressList.to_xml
                                                          [x]))))
                                             v.ipv6_addresses))
                                         @
                                         [Util.option_map v.kernel_id
                                            (fun f ->
                                               Ezxmlm.make_tag "KernelId"
                                                 ([], (String.to_xml f)))])
                                        @
                                        [Util.option_map v.key_name
                                           (fun f ->
                                              Ezxmlm.make_tag "KeyName"
                                                ([], (String.to_xml f)))])
                                       @
                                       [Some
                                          (Ezxmlm.make_tag "MaxCount"
                                             ([],
                                               (Integer.to_xml v.max_count)))])
                                      @
                                      [Some
                                         (Ezxmlm.make_tag "MinCount"
                                            ([],
                                              (Integer.to_xml v.min_count)))])
                                     @
                                     [Util.option_map v.monitoring
                                        (fun f ->
                                           Ezxmlm.make_tag "Monitoring"
                                             ([],
                                               (RunInstancesMonitoringEnabled.to_xml
                                                  f)))])
                                    @
                                    [Util.option_map v.placement
                                       (fun f ->
                                          Ezxmlm.make_tag "Placement"
                                            ([], (Placement.to_xml f)))])
                                   @
                                   [Util.option_map v.ramdisk_id
                                      (fun f ->
                                         Ezxmlm.make_tag "RamdiskId"
                                           ([], (String.to_xml f)))])
                                  @
                                  (List.map
                                     (fun x ->
                                        Some
                                          (Ezxmlm.make_tag "SecurityGroupId"
                                             ([],
                                               (SecurityGroupIdStringList.to_xml
                                                  [x]))))
                                     v.security_group_ids))
                                 @
                                 (List.map
                                    (fun x ->
                                       Some
                                         (Ezxmlm.make_tag "SecurityGroup"
                                            ([],
                                              (SecurityGroupStringList.to_xml
                                                 [x])))) v.security_groups))
                                @
                                [Util.option_map v.subnet_id
                                   (fun f ->
                                      Ezxmlm.make_tag "SubnetId"
                                        ([], (String.to_xml f)))])
                               @
                               [Util.option_map v.user_data
                                  (fun f ->
                                     Ezxmlm.make_tag "UserData"
                                       ([], (String.to_xml f)))])
                              @
                              [Util.option_map v.additional_info
                                 (fun f ->
                                    Ezxmlm.make_tag "additionalInfo"
                                      ([], (String.to_xml f)))])
                             @
                             [Util.option_map v.client_token
                                (fun f ->
                                   Ezxmlm.make_tag "clientToken"
                                     ([], (String.to_xml f)))])
                            @
                            [Util.option_map v.disable_api_termination
                               (fun f ->
                                  Ezxmlm.make_tag "disableApiTermination"
                                    ([], (Boolean.to_xml f)))])
                           @
                           [Util.option_map v.dry_run
                              (fun f ->
                                 Ezxmlm.make_tag "dryRun"
                                   ([], (Boolean.to_xml f)))])
                          @
                          [Util.option_map v.ebs_optimized
                             (fun f ->
                                Ezxmlm.make_tag "ebsOptimized"
                                  ([], (Boolean.to_xml f)))])
                         @
                         [Util.option_map v.iam_instance_profile
                            (fun f ->
                               Ezxmlm.make_tag "iamInstanceProfile"
                                 ([],
                                   (IamInstanceProfileSpecification.to_xml f)))])
                        @
                        [Util.option_map
                           v.instance_initiated_shutdown_behavior
                           (fun f ->
                              Ezxmlm.make_tag
                                "instanceInitiatedShutdownBehavior"
                                ([], (ShutdownBehavior.to_xml f)))])
                       @
                       (List.map
                          (fun x ->
                             Some
                               (Ezxmlm.make_tag "networkInterface"
                                  ([],
                                    (InstanceNetworkInterfaceSpecificationList.to_xml
                                       [x])))) v.network_interfaces))
                      @
                      [Util.option_map v.private_ip_address
                         (fun f ->
                            Ezxmlm.make_tag "privateIpAddress"
                              ([], (String.to_xml f)))])
                     @
                     (List.map
                        (fun x ->
                           Some
                             (Ezxmlm.make_tag "ElasticGpuSpecification"
                                ([], (ElasticGpuSpecifications.to_xml [x]))))
                        v.elastic_gpu_specification))
                    @
                    (List.map
                       (fun x ->
                          Some
                            (Ezxmlm.make_tag "ElasticInferenceAccelerator"
                               ([],
                                 (ElasticInferenceAccelerators.to_xml [x]))))
                       v.elastic_inference_accelerators))
                   @
                   (List.map
                      (fun x ->
                         Some
                           (Ezxmlm.make_tag "TagSpecification"
                              ([], (TagSpecificationList.to_xml [x]))))
                      v.tag_specifications))
                  @
                  [Util.option_map v.launch_template
                     (fun f ->
                        Ezxmlm.make_tag "LaunchTemplate"
                          ([], (LaunchTemplateSpecification.to_xml f)))])
                 @
                 [Util.option_map v.instance_market_options
                    (fun f ->
                       Ezxmlm.make_tag "InstanceMarketOptions"
                         ([], (InstanceMarketOptionsRequest.to_xml f)))])
                @
                [Util.option_map v.credit_specification
                   (fun f ->
                      Ezxmlm.make_tag "CreditSpecification"
                        ([], (CreditSpecificationRequest.to_xml f)))])
               @
               [Util.option_map v.cpu_options
                  (fun f ->
                     Ezxmlm.make_tag "CpuOptions"
                       ([], (CpuOptionsRequest.to_xml f)))])
              @
              [Util.option_map v.capacity_reservation_specification
                 (fun f ->
                    Ezxmlm.make_tag "CapacityReservationSpecification"
                      ([], (CapacityReservationSpecification.to_xml f)))])
             @
             [Util.option_map v.hibernation_options
                (fun f ->
                   Ezxmlm.make_tag "HibernationOptions"
                     ([], (HibernationOptionsRequest.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "LicenseSpecification"
                       ([], (LicenseSpecificationListRequest.to_xml [x]))))
               v.license_specifications))
           @
           [Util.option_map v.metadata_options
              (fun f ->
                 Ezxmlm.make_tag "MetadataOptions"
                   ([], (InstanceMetadataOptionsRequest.to_xml f)))])
  end
module Reservation = Reservation
type input = RunInstancesRequest.t
type output = Reservation.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["RunInstances"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (RunInstancesRequest.to_query req))))) in
  (`POST, uri, (Headers.render (RunInstancesRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "RunInstancesResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp Reservation.parse)
          (BadResponse
             { body; message = "Could not find well formed Reservation." })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing Reservation - missing field in body or children: "
                      ^ msg)
               })
  with
  | Failure msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing xml: " ^ msg) })
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