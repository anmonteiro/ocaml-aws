open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyInstanceAttributeRequest =
  struct
    type t =
      {
      source_dest_check: AttributeBooleanValue.t option
        [@ocaml.doc
          "<p>Specifies whether source/destination checking is enabled. A value of <code>true</code> means that checking is enabled, and <code>false</code> means that checking is disabled. This value must be <code>false</code> for a NAT instance to perform NAT.</p>"];
      attribute: InstanceAttributeName.t option
        [@ocaml.doc "<p>The name of the attribute.</p>"];
      block_device_mappings: InstanceBlockDeviceMappingSpecificationList.t
        [@ocaml.doc
          "<p>Modifies the <code>DeleteOnTermination</code> attribute for volumes that are currently attached. The volume must be owned by the caller. If no value is specified for <code>DeleteOnTermination</code>, the default is <code>true</code> and the volume is deleted when the instance is terminated.</p> <p>To add instance store volumes to an Amazon EBS-backed instance, you must add them when you launch the instance. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/block-device-mapping-concepts.html#Using_OverridingAMIBDM\">Updating the Block Device Mapping when Launching an Instance</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>"];
      disable_api_termination: AttributeBooleanValue.t option
        [@ocaml.doc
          "<p>If the value is <code>true</code>, you can't terminate the instance using the Amazon EC2 console, CLI, or API; otherwise, you can. You cannot use this parameter for Spot Instances.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      ebs_optimized: AttributeBooleanValue.t option
        [@ocaml.doc
          "<p>Specifies whether the instance is optimized for Amazon EBS I/O. This optimization provides dedicated throughput to Amazon EBS and an optimized configuration stack to provide optimal EBS I/O performance. This optimization isn't available with all instance types. Additional usage charges apply when using an EBS Optimized instance.</p>"];
      ena_support: AttributeBooleanValue.t option
        [@ocaml.doc
          "<p>Set to <code>true</code> to enable enhanced networking with ENA for the instance.</p> <p>This option is supported only for HVM instances. Specifying this option with a PV instance can make it unreachable.</p>"];
      groups: GroupIdStringList.t
        [@ocaml.doc
          "<p>[EC2-VPC] Changes the security groups of the instance. You must specify at least one security group, even if it's just the default security group for the VPC. You must specify the security group ID, not the security group name.</p>"];
      instance_id: String.t [@ocaml.doc "<p>The ID of the instance.</p>"];
      instance_initiated_shutdown_behavior: AttributeValue.t option
        [@ocaml.doc
          "<p>Specifies whether an instance stops or terminates when you initiate shutdown from the instance (using the operating system command for system shutdown).</p>"];
      instance_type: AttributeValue.t option
        [@ocaml.doc
          "<p>Changes the instance type to the specified value. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html\">Instance Types</a>. If the instance type is not valid, the error returned is <code>InvalidInstanceAttributeValue</code>.</p>"];
      kernel: AttributeValue.t option
        [@ocaml.doc
          "<p>Changes the instance's kernel to the specified value. We recommend that you use PV-GRUB instead of kernels and RAM disks. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/UserProvidedKernels.html\">PV-GRUB</a>.</p>"];
      ramdisk: AttributeValue.t option
        [@ocaml.doc
          "<p>Changes the instance's RAM disk to the specified value. We recommend that you use PV-GRUB instead of kernels and RAM disks. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/UserProvidedKernels.html\">PV-GRUB</a>.</p>"];
      sriov_net_support: AttributeValue.t option
        [@ocaml.doc
          "<p>Set to <code>simple</code> to enable enhanced networking with the Intel 82599 Virtual Function interface for the instance.</p> <p>There is no way to disable enhanced networking with the Intel 82599 Virtual Function interface at this time.</p> <p>This option is supported only for HVM instances. Specifying this option with a PV instance can make it unreachable.</p>"];
      user_data: BlobAttributeValue.t option
        [@ocaml.doc
          "<p>Changes the instance's user data to the specified value. If you are using an AWS SDK or command line tool, base64-encoding is performed for you, and you can load the text from a file. Otherwise, you must provide base64-encoded text.</p>"];
      value: String.t option
        [@ocaml.doc
          "<p>A new value for the attribute. Use only with the <code>kernel</code>, <code>ramdisk</code>, <code>userData</code>, <code>disableApiTermination</code>, or <code>instanceInitiatedShutdownBehavior</code> attribute.</p>"]}
    let make ?source_dest_check  ?attribute  ?(block_device_mappings= []) 
      ?disable_api_termination  ?dry_run  ?ebs_optimized  ?ena_support 
      ?(groups= [])  ~instance_id  ?instance_initiated_shutdown_behavior 
      ?instance_type  ?kernel  ?ramdisk  ?sriov_net_support  ?user_data 
      ?value  () =
      {
        source_dest_check;
        attribute;
        block_device_mappings;
        disable_api_termination;
        dry_run;
        ebs_optimized;
        ena_support;
        groups;
        instance_id;
        instance_initiated_shutdown_behavior;
        instance_type;
        kernel;
        ramdisk;
        sriov_net_support;
        user_data;
        value
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.value
              (fun f -> Query.Pair ("Value", (String.to_query f)));
           Util.option_map v.user_data
             (fun f ->
                Query.Pair ("UserData", (BlobAttributeValue.to_query f)));
           Util.option_map v.sriov_net_support
             (fun f ->
                Query.Pair ("SriovNetSupport", (AttributeValue.to_query f)));
           Util.option_map v.ramdisk
             (fun f -> Query.Pair ("Ramdisk", (AttributeValue.to_query f)));
           Util.option_map v.kernel
             (fun f -> Query.Pair ("Kernel", (AttributeValue.to_query f)));
           Util.option_map v.instance_type
             (fun f ->
                Query.Pair ("InstanceType", (AttributeValue.to_query f)));
           Util.option_map v.instance_initiated_shutdown_behavior
             (fun f ->
                Query.Pair
                  ("InstanceInitiatedShutdownBehavior",
                    (AttributeValue.to_query f)));
           Some (Query.Pair ("InstanceId", (String.to_query v.instance_id)));
           Some
             (Query.Pair ("GroupId", (GroupIdStringList.to_query v.groups)));
           Util.option_map v.ena_support
             (fun f ->
                Query.Pair ("EnaSupport", (AttributeBooleanValue.to_query f)));
           Util.option_map v.ebs_optimized
             (fun f ->
                Query.Pair
                  ("EbsOptimized", (AttributeBooleanValue.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.disable_api_termination
             (fun f ->
                Query.Pair
                  ("DisableApiTermination",
                    (AttributeBooleanValue.to_query f)));
           Some
             (Query.Pair
                ("BlockDeviceMapping",
                  (InstanceBlockDeviceMappingSpecificationList.to_query
                     v.block_device_mappings)));
           Util.option_map v.attribute
             (fun f ->
                Query.Pair ("Attribute", (InstanceAttributeName.to_query f)));
           Util.option_map v.source_dest_check
             (fun f ->
                Query.Pair
                  ("SourceDestCheck", (AttributeBooleanValue.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.value (fun f -> ("value", (String.to_json f)));
           Util.option_map v.user_data
             (fun f -> ("user_data", (BlobAttributeValue.to_json f)));
           Util.option_map v.sriov_net_support
             (fun f -> ("sriov_net_support", (AttributeValue.to_json f)));
           Util.option_map v.ramdisk
             (fun f -> ("ramdisk", (AttributeValue.to_json f)));
           Util.option_map v.kernel
             (fun f -> ("kernel", (AttributeValue.to_json f)));
           Util.option_map v.instance_type
             (fun f -> ("instance_type", (AttributeValue.to_json f)));
           Util.option_map v.instance_initiated_shutdown_behavior
             (fun f ->
                ("instance_initiated_shutdown_behavior",
                  (AttributeValue.to_json f)));
           Some ("instance_id", (String.to_json v.instance_id));
           Some ("groups", (GroupIdStringList.to_json v.groups));
           Util.option_map v.ena_support
             (fun f -> ("ena_support", (AttributeBooleanValue.to_json f)));
           Util.option_map v.ebs_optimized
             (fun f -> ("ebs_optimized", (AttributeBooleanValue.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.disable_api_termination
             (fun f ->
                ("disable_api_termination",
                  (AttributeBooleanValue.to_json f)));
           Some
             ("block_device_mappings",
               (InstanceBlockDeviceMappingSpecificationList.to_json
                  v.block_device_mappings));
           Util.option_map v.attribute
             (fun f -> ("attribute", (InstanceAttributeName.to_json f)));
           Util.option_map v.source_dest_check
             (fun f ->
                ("source_dest_check", (AttributeBooleanValue.to_json f)))])
    let parse xml =
      Some
        {
          source_dest_check =
            (Util.option_bind (Xml.member "SourceDestCheck" xml)
               AttributeBooleanValue.parse);
          attribute =
            (Util.option_bind (Xml.member "attribute" xml)
               InstanceAttributeName.parse);
          block_device_mappings =
            (Util.of_option []
               (Util.option_bind (Xml.member "blockDeviceMapping" xml)
                  InstanceBlockDeviceMappingSpecificationList.parse));
          disable_api_termination =
            (Util.option_bind (Xml.member "disableApiTermination" xml)
               AttributeBooleanValue.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          ebs_optimized =
            (Util.option_bind (Xml.member "ebsOptimized" xml)
               AttributeBooleanValue.parse);
          ena_support =
            (Util.option_bind (Xml.member "enaSupport" xml)
               AttributeBooleanValue.parse);
          groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "GroupId" xml)
                  GroupIdStringList.parse));
          instance_id =
            (Xml.required "instanceId"
               (Util.option_bind (Xml.member "instanceId" xml) String.parse));
          instance_initiated_shutdown_behavior =
            (Util.option_bind
               (Xml.member "instanceInitiatedShutdownBehavior" xml)
               AttributeValue.parse);
          instance_type =
            (Util.option_bind (Xml.member "instanceType" xml)
               AttributeValue.parse);
          kernel =
            (Util.option_bind (Xml.member "kernel" xml) AttributeValue.parse);
          ramdisk =
            (Util.option_bind (Xml.member "ramdisk" xml) AttributeValue.parse);
          sriov_net_support =
            (Util.option_bind (Xml.member "sriovNetSupport" xml)
               AttributeValue.parse);
          user_data =
            (Util.option_bind (Xml.member "userData" xml)
               BlobAttributeValue.parse);
          value = (Util.option_bind (Xml.member "value" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((((([] @
                          [Util.option_map v.source_dest_check
                             (fun f ->
                                Ezxmlm.make_tag "SourceDestCheck"
                                  ([], (AttributeBooleanValue.to_xml f)))])
                         @
                         [Util.option_map v.attribute
                            (fun f ->
                               Ezxmlm.make_tag "attribute"
                                 ([], (InstanceAttributeName.to_xml f)))])
                        @
                        (List.map
                           (fun x ->
                              Some
                                (Ezxmlm.make_tag "blockDeviceMapping"
                                   ([],
                                     (InstanceBlockDeviceMappingSpecificationList.to_xml
                                        [x])))) v.block_device_mappings))
                       @
                       [Util.option_map v.disable_api_termination
                          (fun f ->
                             Ezxmlm.make_tag "disableApiTermination"
                               ([], (AttributeBooleanValue.to_xml f)))])
                      @
                      [Util.option_map v.dry_run
                         (fun f ->
                            Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
                     @
                     [Util.option_map v.ebs_optimized
                        (fun f ->
                           Ezxmlm.make_tag "ebsOptimized"
                             ([], (AttributeBooleanValue.to_xml f)))])
                    @
                    [Util.option_map v.ena_support
                       (fun f ->
                          Ezxmlm.make_tag "enaSupport"
                            ([], (AttributeBooleanValue.to_xml f)))])
                   @
                   (List.map
                      (fun x ->
                         Some
                           (Ezxmlm.make_tag "GroupId"
                              ([], (GroupIdStringList.to_xml [x])))) v.groups))
                  @
                  [Some
                     (Ezxmlm.make_tag "instanceId"
                        ([], (String.to_xml v.instance_id)))])
                 @
                 [Util.option_map v.instance_initiated_shutdown_behavior
                    (fun f ->
                       Ezxmlm.make_tag "instanceInitiatedShutdownBehavior"
                         ([], (AttributeValue.to_xml f)))])
                @
                [Util.option_map v.instance_type
                   (fun f ->
                      Ezxmlm.make_tag "instanceType"
                        ([], (AttributeValue.to_xml f)))])
               @
               [Util.option_map v.kernel
                  (fun f ->
                     Ezxmlm.make_tag "kernel" ([], (AttributeValue.to_xml f)))])
              @
              [Util.option_map v.ramdisk
                 (fun f ->
                    Ezxmlm.make_tag "ramdisk" ([], (AttributeValue.to_xml f)))])
             @
             [Util.option_map v.sriov_net_support
                (fun f ->
                   Ezxmlm.make_tag "sriovNetSupport"
                     ([], (AttributeValue.to_xml f)))])
            @
            [Util.option_map v.user_data
               (fun f ->
                  Ezxmlm.make_tag "userData"
                    ([], (BlobAttributeValue.to_xml f)))])
           @
           [Util.option_map v.value
              (fun f -> Ezxmlm.make_tag "value" ([], (String.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = ModifyInstanceAttributeRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]);
         ("Action", ["ModifyInstanceAttribute"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyInstanceAttributeRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifyInstanceAttributeRequest.to_headers req)), "")
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