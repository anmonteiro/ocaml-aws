open Aws
open Aws.BaseTypes
module MetricDimension =
  struct
    type t =
      {
      name: String.t [@ocaml.doc "<p>The name of the dimension.</p>"];
      value: String.t [@ocaml.doc "<p>The value of the dimension.</p>"]}
    [@@ocaml.doc "<p>Describes the dimension of a metric.</p>"]
    let make ~name  ~value  () = { name; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("value", (String.to_json v.value));
           Some ("name", (String.to_json v.name))])
    let parse xml =
      Some
        {
          name =
            (Xml.required "Name"
               (Util.option_bind (Xml.member "Name" xml) String.parse));
          value =
            (Xml.required "Value"
               (Util.option_bind (Xml.member "Value" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "Name" ([], (String.to_xml v.name)))])
           @ [Some (Ezxmlm.make_tag "Value" ([], (String.to_xml v.value)))])
  end[@@ocaml.doc "<p>Describes the dimension of a metric.</p>"]
module LaunchTemplateOverrides =
  struct
    type t =
      {
      instance_type: String.t option
        [@ocaml.doc
          "<p>The instance type.</p> <p>For information about available instance types, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html#AvailableInstanceTypes\">Available Instance Types</a> in the <i>Amazon Elastic Compute Cloud User Guide.</i> </p>"];
      weighted_capacity: String.t option
        [@ocaml.doc
          "<p>The number of capacity units, which gives the instance type a proportional weight to other instance types. For example, larger instance types are generally weighted more than smaller instance types. These are the same units that you chose to set the desired capacity in terms of instances, or a performance attribute such as vCPUs, memory, or I/O.</p> <p>Valid Range: Minimum value of 1. Maximum value of 999.</p>"]}
    [@@ocaml.doc "<p>Describes an override for a launch template.</p>"]
    let make ?instance_type  ?weighted_capacity  () =
      { instance_type; weighted_capacity }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.weighted_capacity
              (fun f -> ("weighted_capacity", (String.to_json f)));
           Util.option_map v.instance_type
             (fun f -> ("instance_type", (String.to_json f)))])
    let parse xml =
      Some
        {
          instance_type =
            (Util.option_bind (Xml.member "InstanceType" xml) String.parse);
          weighted_capacity =
            (Util.option_bind (Xml.member "WeightedCapacity" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.instance_type
               (fun f ->
                  Ezxmlm.make_tag "InstanceType" ([], (String.to_xml f)))])
           @
           [Util.option_map v.weighted_capacity
              (fun f ->
                 Ezxmlm.make_tag "WeightedCapacity" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>Describes an override for a launch template.</p>"]
module MetricDimensions =
  struct
    type t = MetricDimension.t list
    let make elems () = elems
    let to_query v = Query.to_query_list MetricDimension.to_query v
    let to_headers v = Headers.to_headers_list MetricDimension.to_headers v
    let to_json v = `List (List.map MetricDimension.to_json v)
    let parse xml =
      Util.option_all
        (List.map MetricDimension.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (MetricDimension.to_xml x)))
        v
  end
module MetricStatistic =
  struct
    type t =
      | Average 
      | Minimum 
      | Maximum 
      | SampleCount 
      | Sum 
    let str_to_t =
      [("Sum", Sum);
      ("SampleCount", SampleCount);
      ("Maximum", Maximum);
      ("Minimum", Minimum);
      ("Average", Average)]
    let t_to_str =
      [(Sum, "Sum");
      (SampleCount, "SampleCount");
      (Maximum, "Maximum");
      (Minimum, "Minimum");
      (Average, "Average")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module MetricType =
  struct
    type t =
      | ASGAverageCPUUtilization 
      | ASGAverageNetworkIn 
      | ASGAverageNetworkOut 
      | ALBRequestCountPerTarget 
    let str_to_t =
      [("ALBRequestCountPerTarget", ALBRequestCountPerTarget);
      ("ASGAverageNetworkOut", ASGAverageNetworkOut);
      ("ASGAverageNetworkIn", ASGAverageNetworkIn);
      ("ASGAverageCPUUtilization", ASGAverageCPUUtilization)]
    let t_to_str =
      [(ALBRequestCountPerTarget, "ALBRequestCountPerTarget");
      (ASGAverageNetworkOut, "ASGAverageNetworkOut");
      (ASGAverageNetworkIn, "ASGAverageNetworkIn");
      (ASGAverageCPUUtilization, "ASGAverageCPUUtilization")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module LaunchTemplateSpecification =
  struct
    type t =
      {
      launch_template_id: String.t option
        [@ocaml.doc
          "<p>The ID of the launch template. You must specify either a template ID or a template name.</p>"];
      launch_template_name: String.t option
        [@ocaml.doc
          "<p>The name of the launch template. You must specify either a template name or a template ID.</p>"];
      version: String.t option
        [@ocaml.doc
          "<p>The version number, <code>$Latest</code>, or <code>$Default</code>. If the value is <code>$Latest</code>, Amazon EC2 Auto Scaling selects the latest version of the launch template when launching instances. If the value is <code>$Default</code>, Amazon EC2 Auto Scaling selects the default version of the launch template when launching instances. The default value is <code>$Default</code>.</p>"]}
    [@@ocaml.doc
      "<p>Describes a launch template and the launch template version.</p> <p>The launch template that is specified must be configured for use with an Auto Scaling group. For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-launch-template.html\">Creating a Launch Template for an Auto Scaling Group</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"]
    let make ?launch_template_id  ?launch_template_name  ?version  () =
      { launch_template_id; launch_template_name; version }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.version
              (fun f -> ("version", (String.to_json f)));
           Util.option_map v.launch_template_name
             (fun f -> ("launch_template_name", (String.to_json f)));
           Util.option_map v.launch_template_id
             (fun f -> ("launch_template_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          launch_template_id =
            (Util.option_bind (Xml.member "LaunchTemplateId" xml)
               String.parse);
          launch_template_name =
            (Util.option_bind (Xml.member "LaunchTemplateName" xml)
               String.parse);
          version =
            (Util.option_bind (Xml.member "Version" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.launch_template_id
                (fun f ->
                   Ezxmlm.make_tag "LaunchTemplateId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.launch_template_name
               (fun f ->
                  Ezxmlm.make_tag "LaunchTemplateName"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.version
              (fun f -> Ezxmlm.make_tag "Version" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Describes a launch template and the launch template version.</p> <p>The launch template that is specified must be configured for use with an Auto Scaling group. For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-launch-template.html\">Creating a Launch Template for an Auto Scaling Group</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"]
module LifecycleState =
  struct
    type t =
      | Pending 
      | Pending_Wait 
      | Pending_Proceed 
      | Quarantined 
      | InService 
      | Terminating 
      | Terminating_Wait 
      | Terminating_Proceed 
      | Terminated 
      | Detaching 
      | Detached 
      | EnteringStandby 
      | Standby 
    let str_to_t =
      [("Standby", Standby);
      ("EnteringStandby", EnteringStandby);
      ("Detached", Detached);
      ("Detaching", Detaching);
      ("Terminated", Terminated);
      ("Terminating:Proceed", Terminating_Proceed);
      ("Terminating:Wait", Terminating_Wait);
      ("Terminating", Terminating);
      ("InService", InService);
      ("Quarantined", Quarantined);
      ("Pending:Proceed", Pending_Proceed);
      ("Pending:Wait", Pending_Wait);
      ("Pending", Pending)]
    let t_to_str =
      [(Standby, "Standby");
      (EnteringStandby, "EnteringStandby");
      (Detached, "Detached");
      (Detaching, "Detaching");
      (Terminated, "Terminated");
      (Terminating_Proceed, "Terminating:Proceed");
      (Terminating_Wait, "Terminating:Wait");
      (Terminating, "Terminating");
      (InService, "InService");
      (Quarantined, "Quarantined");
      (Pending_Proceed, "Pending:Proceed");
      (Pending_Wait, "Pending:Wait");
      (Pending, "Pending")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module Overrides =
  struct
    type t = LaunchTemplateOverrides.t list
    let make elems () = elems
    let to_query v = Query.to_query_list LaunchTemplateOverrides.to_query v
    let to_headers v =
      Headers.to_headers_list LaunchTemplateOverrides.to_headers v
    let to_json v = `List (List.map LaunchTemplateOverrides.to_json v)
    let parse xml =
      Util.option_all
        (List.map LaunchTemplateOverrides.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (LaunchTemplateOverrides.to_xml x)))
        v
  end
module Ebs =
  struct
    type t =
      {
      snapshot_id: String.t option
        [@ocaml.doc
          "<p>The snapshot ID of the volume to use.</p> <p>Conditional: This parameter is optional if you specify a volume size. If you specify both <code>SnapshotId</code> and <code>VolumeSize</code>, <code>VolumeSize</code> must be equal or greater than the size of the snapshot.</p>"];
      volume_size: Integer.t option
        [@ocaml.doc
          "<p>The volume size, in Gibibytes (GiB).</p> <p>This can be a number from 1-1,024 for <code>standard</code>, 4-16,384 for <code>io1</code>, 1-16,384 for <code>gp2</code>, and 500-16,384 for <code>st1</code> and <code>sc1</code>. If you specify a snapshot, the volume size must be equal to or larger than the snapshot size.</p> <p>Default: If you create a volume from a snapshot and you don't specify a volume size, the default is the snapshot size.</p> <note> <p>At least one of VolumeSize or SnapshotId is required.</p> </note>"];
      volume_type: String.t option
        [@ocaml.doc
          "<p>The volume type, which can be <code>standard</code> for Magnetic, <code>io1</code> for Provisioned IOPS SSD, <code>gp2</code> for General Purpose SSD, <code>st1</code> for Throughput Optimized HDD, or <code>sc1</code> for Cold HDD. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumeTypes.html\">Amazon EBS Volume Types</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.</p> <p>Valid Values: <code>standard</code> | <code>io1</code> | <code>gp2</code> | <code>st1</code> | <code>sc1</code> </p>"];
      delete_on_termination: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether the volume is deleted on instance termination. For Amazon EC2 Auto Scaling, the default value is <code>true</code>.</p>"];
      iops: Integer.t option
        [@ocaml.doc
          "<p>The number of I/O operations per second (IOPS) to provision for the volume. The maximum ratio of IOPS to volume size (in GiB) is 50:1. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumeTypes.html\">Amazon EBS Volume Types</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.</p> <p>Conditional: This parameter is required when the volume type is <code>io1</code>. (Not used with <code>standard</code>, <code>gp2</code>, <code>st1</code>, or <code>sc1</code> volumes.) </p>"];
      encrypted: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the volume should be encrypted. Encrypted EBS volumes can only be attached to instances that support Amazon EBS encryption. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSEncryption.html#EBSEncryption_supported_instances\">Supported Instance Types</a>. If your AMI uses encrypted volumes, you can also only launch it on supported instance types.</p> <note> <p>If you are creating a volume from a snapshot, you cannot specify an encryption value. Volumes that are created from encrypted snapshots are automatically encrypted, and volumes that are created from unencrypted snapshots are automatically unencrypted. By default, encrypted snapshots use the AWS managed CMK that is used for EBS encryption, but you can specify a custom CMK when you create the snapshot. The ability to encrypt a snapshot during copying also allows you to apply a new CMK to an already-encrypted snapshot. Volumes restored from the resulting copy are only accessible using the new CMK.</p> <p>Enabling <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSEncryption.html#encryption-by-default\">encryption by default</a> results in all EBS volumes being encrypted with the AWS managed CMK or a customer managed CMK, whether or not the snapshot was encrypted.</p> </note> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIEncryption.html\">Using Encryption with EBS-Backed AMIs</a> in the <i>Amazon EC2 User Guide for Linux Instances</i> and <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/key-policy-requirements-EBS-encryption.html\">Required CMK Key Policy for Use with Encrypted Volumes</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"]}
    [@@ocaml.doc
      "<p>Describes an Amazon EBS volume. Used in combination with <a>BlockDeviceMapping</a>.</p>"]
    let make ?snapshot_id  ?volume_size  ?volume_type  ?delete_on_termination
       ?iops  ?encrypted  () =
      {
        snapshot_id;
        volume_size;
        volume_type;
        delete_on_termination;
        iops;
        encrypted
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.encrypted
              (fun f -> ("encrypted", (Boolean.to_json f)));
           Util.option_map v.iops (fun f -> ("iops", (Integer.to_json f)));
           Util.option_map v.delete_on_termination
             (fun f -> ("delete_on_termination", (Boolean.to_json f)));
           Util.option_map v.volume_type
             (fun f -> ("volume_type", (String.to_json f)));
           Util.option_map v.volume_size
             (fun f -> ("volume_size", (Integer.to_json f)));
           Util.option_map v.snapshot_id
             (fun f -> ("snapshot_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          snapshot_id =
            (Util.option_bind (Xml.member "SnapshotId" xml) String.parse);
          volume_size =
            (Util.option_bind (Xml.member "VolumeSize" xml) Integer.parse);
          volume_type =
            (Util.option_bind (Xml.member "VolumeType" xml) String.parse);
          delete_on_termination =
            (Util.option_bind (Xml.member "DeleteOnTermination" xml)
               Boolean.parse);
          iops = (Util.option_bind (Xml.member "Iops" xml) Integer.parse);
          encrypted =
            (Util.option_bind (Xml.member "Encrypted" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.snapshot_id
                   (fun f ->
                      Ezxmlm.make_tag "SnapshotId" ([], (String.to_xml f)))])
               @
               [Util.option_map v.volume_size
                  (fun f ->
                     Ezxmlm.make_tag "VolumeSize" ([], (Integer.to_xml f)))])
              @
              [Util.option_map v.volume_type
                 (fun f ->
                    Ezxmlm.make_tag "VolumeType" ([], (String.to_xml f)))])
             @
             [Util.option_map v.delete_on_termination
                (fun f ->
                   Ezxmlm.make_tag "DeleteOnTermination"
                     ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.iops
               (fun f -> Ezxmlm.make_tag "Iops" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.encrypted
              (fun f -> Ezxmlm.make_tag "Encrypted" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc
       "<p>Describes an Amazon EBS volume. Used in combination with <a>BlockDeviceMapping</a>.</p>"]
module Alarm =
  struct
    type t =
      {
      alarm_name: String.t option
        [@ocaml.doc "<p>The name of the alarm.</p>"];
      alarm_a_r_n: String.t option
        [@ocaml.doc "<p>The Amazon Resource Name (ARN) of the alarm.</p>"]}
    [@@ocaml.doc "<p>Describes an alarm.</p>"]
    let make ?alarm_name  ?alarm_a_r_n  () = { alarm_name; alarm_a_r_n }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.alarm_a_r_n
              (fun f -> ("alarm_a_r_n", (String.to_json f)));
           Util.option_map v.alarm_name
             (fun f -> ("alarm_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          alarm_name =
            (Util.option_bind (Xml.member "AlarmName" xml) String.parse);
          alarm_a_r_n =
            (Util.option_bind (Xml.member "AlarmARN" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.alarm_name
               (fun f -> Ezxmlm.make_tag "AlarmName" ([], (String.to_xml f)))])
           @
           [Util.option_map v.alarm_a_r_n
              (fun f -> Ezxmlm.make_tag "AlarmARN" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>Describes an alarm.</p>"]
module StepAdjustment =
  struct
    type t =
      {
      metric_interval_lower_bound: Double.t option
        [@ocaml.doc
          "<p>The lower bound for the difference between the alarm threshold and the CloudWatch metric. If the metric value is above the breach threshold, the lower bound is inclusive (the metric must be greater than or equal to the threshold plus the lower bound). Otherwise, it is exclusive (the metric must be greater than the threshold plus the lower bound). A null value indicates negative infinity.</p>"];
      metric_interval_upper_bound: Double.t option
        [@ocaml.doc
          "<p>The upper bound for the difference between the alarm threshold and the CloudWatch metric. If the metric value is above the breach threshold, the upper bound is exclusive (the metric must be less than the threshold plus the upper bound). Otherwise, it is inclusive (the metric must be less than or equal to the threshold plus the upper bound). A null value indicates positive infinity.</p> <p>The upper bound must be greater than the lower bound.</p>"];
      scaling_adjustment: Integer.t
        [@ocaml.doc
          "<p>The amount by which to scale, based on the specified adjustment type. A positive value adds to the current capacity while a negative number removes from the current capacity.</p>"]}
    [@@ocaml.doc
      "<p>Describes an adjustment based on the difference between the value of the aggregated CloudWatch metric and the breach threshold that you've defined for the alarm. Used in combination with <a>PutScalingPolicy</a>.</p> <p>For the following examples, suppose that you have an alarm with a breach threshold of 50:</p> <ul> <li> <p>To trigger the adjustment when the metric is greater than or equal to 50 and less than 60, specify a lower bound of 0 and an upper bound of 10.</p> </li> <li> <p>To trigger the adjustment when the metric is greater than 40 and less than or equal to 50, specify a lower bound of -10 and an upper bound of 0.</p> </li> </ul> <p>There are a few rules for the step adjustments for your step policy:</p> <ul> <li> <p>The ranges of your step adjustments can't overlap or have a gap.</p> </li> <li> <p>At most, one step adjustment can have a null lower bound. If one step adjustment has a negative lower bound, then there must be a step adjustment with a null lower bound.</p> </li> <li> <p>At most, one step adjustment can have a null upper bound. If one step adjustment has a positive upper bound, then there must be a step adjustment with a null upper bound.</p> </li> <li> <p>The upper and lower bound can't be null in the same step adjustment.</p> </li> </ul>"]
    let make ?metric_interval_lower_bound  ?metric_interval_upper_bound 
      ~scaling_adjustment  () =
      {
        metric_interval_lower_bound;
        metric_interval_upper_bound;
        scaling_adjustment
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("scaling_adjustment", (Integer.to_json v.scaling_adjustment));
           Util.option_map v.metric_interval_upper_bound
             (fun f -> ("metric_interval_upper_bound", (Double.to_json f)));
           Util.option_map v.metric_interval_lower_bound
             (fun f -> ("metric_interval_lower_bound", (Double.to_json f)))])
    let parse xml =
      Some
        {
          metric_interval_lower_bound =
            (Util.option_bind (Xml.member "MetricIntervalLowerBound" xml)
               Double.parse);
          metric_interval_upper_bound =
            (Util.option_bind (Xml.member "MetricIntervalUpperBound" xml)
               Double.parse);
          scaling_adjustment =
            (Xml.required "ScalingAdjustment"
               (Util.option_bind (Xml.member "ScalingAdjustment" xml)
                  Integer.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.metric_interval_lower_bound
                (fun f ->
                   Ezxmlm.make_tag "MetricIntervalLowerBound"
                     ([], (Double.to_xml f)))])
            @
            [Util.option_map v.metric_interval_upper_bound
               (fun f ->
                  Ezxmlm.make_tag "MetricIntervalUpperBound"
                    ([], (Double.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "ScalingAdjustment"
                 ([], (Integer.to_xml v.scaling_adjustment)))])
  end[@@ocaml.doc
       "<p>Describes an adjustment based on the difference between the value of the aggregated CloudWatch metric and the breach threshold that you've defined for the alarm. Used in combination with <a>PutScalingPolicy</a>.</p> <p>For the following examples, suppose that you have an alarm with a breach threshold of 50:</p> <ul> <li> <p>To trigger the adjustment when the metric is greater than or equal to 50 and less than 60, specify a lower bound of 0 and an upper bound of 10.</p> </li> <li> <p>To trigger the adjustment when the metric is greater than 40 and less than or equal to 50, specify a lower bound of -10 and an upper bound of 0.</p> </li> </ul> <p>There are a few rules for the step adjustments for your step policy:</p> <ul> <li> <p>The ranges of your step adjustments can't overlap or have a gap.</p> </li> <li> <p>At most, one step adjustment can have a null lower bound. If one step adjustment has a negative lower bound, then there must be a step adjustment with a null lower bound.</p> </li> <li> <p>At most, one step adjustment can have a null upper bound. If one step adjustment has a positive upper bound, then there must be a step adjustment with a null upper bound.</p> </li> <li> <p>The upper and lower bound can't be null in the same step adjustment.</p> </li> </ul>"]
module CustomizedMetricSpecification =
  struct
    type t =
      {
      metric_name: String.t [@ocaml.doc "<p>The name of the metric.</p>"];
      namespace: String.t [@ocaml.doc "<p>The namespace of the metric.</p>"];
      dimensions: MetricDimensions.t
        [@ocaml.doc
          "<p>The dimensions of the metric.</p> <p>Conditional: If you published your metric with dimensions, you must specify the same dimensions in your scaling policy.</p>"];
      statistic: MetricStatistic.t
        [@ocaml.doc "<p>The statistic of the metric.</p>"];
      unit: String.t option [@ocaml.doc "<p>The unit of the metric.</p>"]}
    [@@ocaml.doc
      "<p>Represents a CloudWatch metric of your choosing for a target tracking scaling policy to use with Amazon EC2 Auto Scaling.</p> <p>To create your customized metric specification:</p> <ul> <li> <p>Add values for each required parameter from CloudWatch. You can use an existing metric, or a new metric that you create. To use your own metric, you must first publish the metric to CloudWatch. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/publishingMetrics.html\">Publish Custom Metrics</a> in the <i>Amazon CloudWatch User Guide</i>.</p> </li> <li> <p>Choose a metric that changes proportionally with capacity. The value of the metric should increase or decrease in inverse proportion to the number of capacity units. That is, the value of the metric should decrease when capacity increases.</p> </li> </ul> <p>For more information about CloudWatch, see <a href=\"https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_concepts.html\">Amazon CloudWatch Concepts</a>.</p>"]
    let make ~metric_name  ~namespace  ?(dimensions= [])  ~statistic  ?unit 
      () = { metric_name; namespace; dimensions; statistic; unit }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.unit (fun f -> ("unit", (String.to_json f)));
           Some ("statistic", (MetricStatistic.to_json v.statistic));
           Some ("dimensions", (MetricDimensions.to_json v.dimensions));
           Some ("namespace", (String.to_json v.namespace));
           Some ("metric_name", (String.to_json v.metric_name))])
    let parse xml =
      Some
        {
          metric_name =
            (Xml.required "MetricName"
               (Util.option_bind (Xml.member "MetricName" xml) String.parse));
          namespace =
            (Xml.required "Namespace"
               (Util.option_bind (Xml.member "Namespace" xml) String.parse));
          dimensions =
            (Util.of_option []
               (Util.option_bind (Xml.member "Dimensions" xml)
                  MetricDimensions.parse));
          statistic =
            (Xml.required "Statistic"
               (Util.option_bind (Xml.member "Statistic" xml)
                  MetricStatistic.parse));
          unit = (Util.option_bind (Xml.member "Unit" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "MetricName"
                     ([], (String.to_xml v.metric_name)))])
              @
              [Some
                 (Ezxmlm.make_tag "Namespace"
                    ([], (String.to_xml v.namespace)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "Dimensions"
                        ([], (MetricDimensions.to_xml [x])))) v.dimensions))
            @
            [Some
               (Ezxmlm.make_tag "Statistic"
                  ([], (MetricStatistic.to_xml v.statistic)))])
           @
           [Util.option_map v.unit
              (fun f -> Ezxmlm.make_tag "Unit" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents a CloudWatch metric of your choosing for a target tracking scaling policy to use with Amazon EC2 Auto Scaling.</p> <p>To create your customized metric specification:</p> <ul> <li> <p>Add values for each required parameter from CloudWatch. You can use an existing metric, or a new metric that you create. To use your own metric, you must first publish the metric to CloudWatch. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/publishingMetrics.html\">Publish Custom Metrics</a> in the <i>Amazon CloudWatch User Guide</i>.</p> </li> <li> <p>Choose a metric that changes proportionally with capacity. The value of the metric should increase or decrease in inverse proportion to the number of capacity units. That is, the value of the metric should decrease when capacity increases.</p> </li> </ul> <p>For more information about CloudWatch, see <a href=\"https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_concepts.html\">Amazon CloudWatch Concepts</a>.</p>"]
module PredefinedMetricSpecification =
  struct
    type t =
      {
      predefined_metric_type: MetricType.t
        [@ocaml.doc
          "<p>The metric type. The following predefined metrics are available:</p> <ul> <li> <p> <code>ASGAverageCPUUtilization</code> - Average CPU utilization of the Auto Scaling group.</p> </li> <li> <p> <code>ASGAverageNetworkIn</code> - Average number of bytes received on all network interfaces by the Auto Scaling group.</p> </li> <li> <p> <code>ASGAverageNetworkOut</code> - Average number of bytes sent out on all network interfaces by the Auto Scaling group.</p> </li> <li> <p> <code>ALBRequestCountPerTarget</code> - Number of requests completed per target in an Application Load Balancer target group.</p> </li> </ul>"];
      resource_label: String.t option
        [@ocaml.doc
          "<p>Identifies the resource associated with the metric type. You can't specify a resource label unless the metric type is <code>ALBRequestCountPerTarget</code> and there is a target group attached to the Auto Scaling group.</p> <p>The format is <code>app/<i>load-balancer-name</i>/<i>load-balancer-id</i>/targetgroup/<i>target-group-name</i>/<i>target-group-id</i> </code>, where </p> <ul> <li> <p> <code>app/<i>load-balancer-name</i>/<i>load-balancer-id</i> </code> is the final portion of the load balancer ARN, and</p> </li> <li> <p> <code>targetgroup/<i>target-group-name</i>/<i>target-group-id</i> </code> is the final portion of the target group ARN.</p> </li> </ul>"]}
    [@@ocaml.doc
      "<p>Represents a predefined metric for a target tracking scaling policy to use with Amazon EC2 Auto Scaling.</p>"]
    let make ~predefined_metric_type  ?resource_label  () =
      { predefined_metric_type; resource_label }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.resource_label
              (fun f -> ("resource_label", (String.to_json f)));
           Some
             ("predefined_metric_type",
               (MetricType.to_json v.predefined_metric_type))])
    let parse xml =
      Some
        {
          predefined_metric_type =
            (Xml.required "PredefinedMetricType"
               (Util.option_bind (Xml.member "PredefinedMetricType" xml)
                  MetricType.parse));
          resource_label =
            (Util.option_bind (Xml.member "ResourceLabel" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "PredefinedMetricType"
                  ([], (MetricType.to_xml v.predefined_metric_type)))])
           @
           [Util.option_map v.resource_label
              (fun f ->
                 Ezxmlm.make_tag "ResourceLabel" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents a predefined metric for a target tracking scaling policy to use with Amazon EC2 Auto Scaling.</p>"]
module EnabledMetric =
  struct
    type t =
      {
      metric: String.t option
        [@ocaml.doc
          "<p>One of the following metrics:</p> <ul> <li> <p> <code>GroupMinSize</code> </p> </li> <li> <p> <code>GroupMaxSize</code> </p> </li> <li> <p> <code>GroupDesiredCapacity</code> </p> </li> <li> <p> <code>GroupInServiceInstances</code> </p> </li> <li> <p> <code>GroupPendingInstances</code> </p> </li> <li> <p> <code>GroupStandbyInstances</code> </p> </li> <li> <p> <code>GroupTerminatingInstances</code> </p> </li> <li> <p> <code>GroupTotalInstances</code> </p> </li> </ul>"];
      granularity: String.t option
        [@ocaml.doc
          "<p>The granularity of the metric. The only valid value is <code>1Minute</code>.</p>"]}
    [@@ocaml.doc "<p>Describes an enabled metric.</p>"]
    let make ?metric  ?granularity  () = { metric; granularity }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.granularity
              (fun f -> ("granularity", (String.to_json f)));
           Util.option_map v.metric (fun f -> ("metric", (String.to_json f)))])
    let parse xml =
      Some
        {
          metric = (Util.option_bind (Xml.member "Metric" xml) String.parse);
          granularity =
            (Util.option_bind (Xml.member "Granularity" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.metric
               (fun f -> Ezxmlm.make_tag "Metric" ([], (String.to_xml f)))])
           @
           [Util.option_map v.granularity
              (fun f -> Ezxmlm.make_tag "Granularity" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>Describes an enabled metric.</p>"]
module Instance =
  struct
    type t =
      {
      instance_id: String.t [@ocaml.doc "<p>The ID of the instance.</p>"];
      instance_type: String.t option
        [@ocaml.doc "<p>The instance type of the EC2 instance.</p>"];
      availability_zone: String.t
        [@ocaml.doc
          "<p>The Availability Zone in which the instance is running.</p>"];
      lifecycle_state: LifecycleState.t
        [@ocaml.doc
          "<p>A description of the current lifecycle state. The <code>Quarantined</code> state is not used.</p>"];
      health_status: String.t
        [@ocaml.doc
          "<p>The last reported health status of the instance. \"Healthy\" means that the instance is healthy and should remain in service. \"Unhealthy\" means that the instance is unhealthy and that Amazon EC2 Auto Scaling should terminate and replace it.</p>"];
      launch_configuration_name: String.t option
        [@ocaml.doc
          "<p>The launch configuration associated with the instance.</p>"];
      launch_template: LaunchTemplateSpecification.t option
        [@ocaml.doc "<p>The launch template for the instance.</p>"];
      protected_from_scale_in: Boolean.t
        [@ocaml.doc
          "<p>Indicates whether the instance is protected from termination by Amazon EC2 Auto Scaling when scaling in.</p>"];
      weighted_capacity: String.t option
        [@ocaml.doc
          "<p>The number of capacity units contributed by the instance based on its instance type.</p> <p>Valid Range: Minimum value of 1. Maximum value of 999.</p>"]}
    [@@ocaml.doc "<p>Describes an EC2 instance.</p>"]
    let make ~instance_id  ?instance_type  ~availability_zone 
      ~lifecycle_state  ~health_status  ?launch_configuration_name 
      ?launch_template  ~protected_from_scale_in  ?weighted_capacity  () =
      {
        instance_id;
        instance_type;
        availability_zone;
        lifecycle_state;
        health_status;
        launch_configuration_name;
        launch_template;
        protected_from_scale_in;
        weighted_capacity
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.weighted_capacity
              (fun f -> ("weighted_capacity", (String.to_json f)));
           Some
             ("protected_from_scale_in",
               (Boolean.to_json v.protected_from_scale_in));
           Util.option_map v.launch_template
             (fun f ->
                ("launch_template", (LaunchTemplateSpecification.to_json f)));
           Util.option_map v.launch_configuration_name
             (fun f -> ("launch_configuration_name", (String.to_json f)));
           Some ("health_status", (String.to_json v.health_status));
           Some
             ("lifecycle_state", (LifecycleState.to_json v.lifecycle_state));
           Some ("availability_zone", (String.to_json v.availability_zone));
           Util.option_map v.instance_type
             (fun f -> ("instance_type", (String.to_json f)));
           Some ("instance_id", (String.to_json v.instance_id))])
    let parse xml =
      Some
        {
          instance_id =
            (Xml.required "InstanceId"
               (Util.option_bind (Xml.member "InstanceId" xml) String.parse));
          instance_type =
            (Util.option_bind (Xml.member "InstanceType" xml) String.parse);
          availability_zone =
            (Xml.required "AvailabilityZone"
               (Util.option_bind (Xml.member "AvailabilityZone" xml)
                  String.parse));
          lifecycle_state =
            (Xml.required "LifecycleState"
               (Util.option_bind (Xml.member "LifecycleState" xml)
                  LifecycleState.parse));
          health_status =
            (Xml.required "HealthStatus"
               (Util.option_bind (Xml.member "HealthStatus" xml) String.parse));
          launch_configuration_name =
            (Util.option_bind (Xml.member "LaunchConfigurationName" xml)
               String.parse);
          launch_template =
            (Util.option_bind (Xml.member "LaunchTemplate" xml)
               LaunchTemplateSpecification.parse);
          protected_from_scale_in =
            (Xml.required "ProtectedFromScaleIn"
               (Util.option_bind (Xml.member "ProtectedFromScaleIn" xml)
                  Boolean.parse));
          weighted_capacity =
            (Util.option_bind (Xml.member "WeightedCapacity" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Some
                      (Ezxmlm.make_tag "InstanceId"
                         ([], (String.to_xml v.instance_id)))])
                  @
                  [Util.option_map v.instance_type
                     (fun f ->
                        Ezxmlm.make_tag "InstanceType"
                          ([], (String.to_xml f)))])
                 @
                 [Some
                    (Ezxmlm.make_tag "AvailabilityZone"
                       ([], (String.to_xml v.availability_zone)))])
                @
                [Some
                   (Ezxmlm.make_tag "LifecycleState"
                      ([], (LifecycleState.to_xml v.lifecycle_state)))])
               @
               [Some
                  (Ezxmlm.make_tag "HealthStatus"
                     ([], (String.to_xml v.health_status)))])
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
            [Some
               (Ezxmlm.make_tag "ProtectedFromScaleIn"
                  ([], (Boolean.to_xml v.protected_from_scale_in)))])
           @
           [Util.option_map v.weighted_capacity
              (fun f ->
                 Ezxmlm.make_tag "WeightedCapacity" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>Describes an EC2 instance.</p>"]
module InstancesDistribution =
  struct
    type t =
      {
      on_demand_allocation_strategy: String.t option
        [@ocaml.doc
          "<p>Indicates how to allocate instance types to fulfill On-Demand capacity.</p> <p>The only valid value is <code>prioritized</code>, which is also the default value. This strategy uses the order of instance type overrides for the <a>LaunchTemplate</a> to define the launch priority of each instance type. The first instance type in the array is prioritized higher than the last. If all your On-Demand capacity cannot be fulfilled using your highest priority instance, then the Auto Scaling groups launches the remaining capacity using the second priority instance type, and so on.</p>"];
      on_demand_base_capacity: Integer.t option
        [@ocaml.doc
          "<p>The minimum amount of the Auto Scaling group's capacity that must be fulfilled by On-Demand Instances. This base portion is provisioned first as your group scales.</p> <p>Default if not set is 0. If you leave it set to 0, On-Demand Instances are launched as a percentage of the Auto Scaling group's desired capacity, per the <code>OnDemandPercentageAboveBaseCapacity</code> setting.</p> <note> <p>An update to this setting means a gradual replacement of instances to maintain the specified number of On-Demand Instances for your base capacity. When replacing instances, Amazon EC2 Auto Scaling launches new instances before terminating the old ones.</p> </note>"];
      on_demand_percentage_above_base_capacity: Integer.t option
        [@ocaml.doc
          "<p>Controls the percentages of On-Demand Instances and Spot Instances for your additional capacity beyond <code>OnDemandBaseCapacity</code>.</p> <p>Default if not set is 100. If you leave it set to 100, the percentages are 100% for On-Demand Instances and 0% for Spot Instances.</p> <note> <p>An update to this setting means a gradual replacement of instances to maintain the percentage of On-Demand Instances for your additional capacity above the base capacity. When replacing instances, Amazon EC2 Auto Scaling launches new instances before terminating the old ones.</p> </note> <p>Valid Range: Minimum value of 0. Maximum value of 100.</p>"];
      spot_allocation_strategy: String.t option
        [@ocaml.doc
          "<p>Indicates how to allocate instances across Spot Instance pools.</p> <p>If the allocation strategy is <code>lowest-price</code>, the Auto Scaling group launches instances using the Spot pools with the lowest price, and evenly allocates your instances across the number of Spot pools that you specify. If the allocation strategy is <code>capacity-optimized</code>, the Auto Scaling group launches instances using Spot pools that are optimally chosen based on the available Spot capacity.</p> <p>The default Spot allocation strategy for calls that you make through the API, the AWS CLI, or the AWS SDKs is <code>lowest-price</code>. The default Spot allocation strategy for the AWS Management Console is <code>capacity-optimized</code>.</p> <p>Valid values: <code>lowest-price</code> | <code>capacity-optimized</code> </p>"];
      spot_instance_pools: Integer.t option
        [@ocaml.doc
          "<p>The number of Spot Instance pools across which to allocate your Spot Instances. The Spot pools are determined from the different instance types in the Overrides array of <a>LaunchTemplate</a>. Default if not set is 2.</p> <p>Used only when the Spot allocation strategy is <code>lowest-price</code>.</p> <p>Valid Range: Minimum value of 1. Maximum value of 20.</p>"];
      spot_max_price: String.t option
        [@ocaml.doc
          "<p>The maximum price per unit hour that you are willing to pay for a Spot Instance. If you leave the value of this parameter blank (which is the default), the maximum Spot price is set at the On-Demand price.</p> <p>To remove a value that you previously set, include the parameter but leave the value blank.</p>"]}
    [@@ocaml.doc
      "<p>Describes an instances distribution for an Auto Scaling group with <a>MixedInstancesPolicy</a>.</p> <p>The instances distribution specifies the distribution of On-Demand Instances and Spot Instances, the maximum price to pay for Spot Instances, and how the Auto Scaling group allocates instance types to fulfill On-Demand and Spot capacity.</p> <p>When you update <code>SpotAllocationStrategy</code>, <code>SpotInstancePools</code>, or <code>SpotMaxPrice</code>, this update action does not deploy any changes across the running Amazon EC2 instances in the group. Your existing Spot Instances continue to run as long as the maximum price for those instances is higher than the current Spot price. When scale out occurs, Amazon EC2 Auto Scaling launches instances based on the new settings. When scale in occurs, Amazon EC2 Auto Scaling terminates instances according to the group's termination policies.</p>"]
    let make ?on_demand_allocation_strategy  ?on_demand_base_capacity 
      ?on_demand_percentage_above_base_capacity  ?spot_allocation_strategy 
      ?spot_instance_pools  ?spot_max_price  () =
      {
        on_demand_allocation_strategy;
        on_demand_base_capacity;
        on_demand_percentage_above_base_capacity;
        spot_allocation_strategy;
        spot_instance_pools;
        spot_max_price
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.spot_max_price
              (fun f -> ("spot_max_price", (String.to_json f)));
           Util.option_map v.spot_instance_pools
             (fun f -> ("spot_instance_pools", (Integer.to_json f)));
           Util.option_map v.spot_allocation_strategy
             (fun f -> ("spot_allocation_strategy", (String.to_json f)));
           Util.option_map v.on_demand_percentage_above_base_capacity
             (fun f ->
                ("on_demand_percentage_above_base_capacity",
                  (Integer.to_json f)));
           Util.option_map v.on_demand_base_capacity
             (fun f -> ("on_demand_base_capacity", (Integer.to_json f)));
           Util.option_map v.on_demand_allocation_strategy
             (fun f -> ("on_demand_allocation_strategy", (String.to_json f)))])
    let parse xml =
      Some
        {
          on_demand_allocation_strategy =
            (Util.option_bind (Xml.member "OnDemandAllocationStrategy" xml)
               String.parse);
          on_demand_base_capacity =
            (Util.option_bind (Xml.member "OnDemandBaseCapacity" xml)
               Integer.parse);
          on_demand_percentage_above_base_capacity =
            (Util.option_bind
               (Xml.member "OnDemandPercentageAboveBaseCapacity" xml)
               Integer.parse);
          spot_allocation_strategy =
            (Util.option_bind (Xml.member "SpotAllocationStrategy" xml)
               String.parse);
          spot_instance_pools =
            (Util.option_bind (Xml.member "SpotInstancePools" xml)
               Integer.parse);
          spot_max_price =
            (Util.option_bind (Xml.member "SpotMaxPrice" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.on_demand_allocation_strategy
                   (fun f ->
                      Ezxmlm.make_tag "OnDemandAllocationStrategy"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.on_demand_base_capacity
                  (fun f ->
                     Ezxmlm.make_tag "OnDemandBaseCapacity"
                       ([], (Integer.to_xml f)))])
              @
              [Util.option_map v.on_demand_percentage_above_base_capacity
                 (fun f ->
                    Ezxmlm.make_tag "OnDemandPercentageAboveBaseCapacity"
                      ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.spot_allocation_strategy
                (fun f ->
                   Ezxmlm.make_tag "SpotAllocationStrategy"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.spot_instance_pools
               (fun f ->
                  Ezxmlm.make_tag "SpotInstancePools"
                    ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.spot_max_price
              (fun f ->
                 Ezxmlm.make_tag "SpotMaxPrice" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Describes an instances distribution for an Auto Scaling group with <a>MixedInstancesPolicy</a>.</p> <p>The instances distribution specifies the distribution of On-Demand Instances and Spot Instances, the maximum price to pay for Spot Instances, and how the Auto Scaling group allocates instance types to fulfill On-Demand and Spot capacity.</p> <p>When you update <code>SpotAllocationStrategy</code>, <code>SpotInstancePools</code>, or <code>SpotMaxPrice</code>, this update action does not deploy any changes across the running Amazon EC2 instances in the group. Your existing Spot Instances continue to run as long as the maximum price for those instances is higher than the current Spot price. When scale out occurs, Amazon EC2 Auto Scaling launches instances based on the new settings. When scale in occurs, Amazon EC2 Auto Scaling terminates instances according to the group's termination policies.</p>"]
module LaunchTemplate =
  struct
    type t =
      {
      launch_template_specification: LaunchTemplateSpecification.t option
        [@ocaml.doc
          "<p>The launch template to use. You must specify either the launch template ID or launch template name in the request.</p>"];
      overrides: Overrides.t
        [@ocaml.doc
          "<p>An optional setting. Any parameters that you specify override the same parameters in the launch template. Currently, the only supported override is instance type. You can specify between 1 and 20 instance types.</p>"]}
    [@@ocaml.doc
      "<p>Describes a launch template and overrides.</p> <p>The overrides are used to override the instance type specified by the launch template with multiple instance types that can be used to launch On-Demand Instances and Spot Instances.</p> <p>When you update the launch template or overrides, existing Amazon EC2 instances continue to run. When scale out occurs, Amazon EC2 Auto Scaling launches instances to match the new settings. When scale in occurs, Amazon EC2 Auto Scaling terminates instances according to the group's termination policies.</p>"]
    let make ?launch_template_specification  ?(overrides= [])  () =
      { launch_template_specification; overrides }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("overrides", (Overrides.to_json v.overrides));
           Util.option_map v.launch_template_specification
             (fun f ->
                ("launch_template_specification",
                  (LaunchTemplateSpecification.to_json f)))])
    let parse xml =
      Some
        {
          launch_template_specification =
            (Util.option_bind (Xml.member "LaunchTemplateSpecification" xml)
               LaunchTemplateSpecification.parse);
          overrides =
            (Util.of_option []
               (Util.option_bind (Xml.member "Overrides" xml) Overrides.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.launch_template_specification
               (fun f ->
                  Ezxmlm.make_tag "LaunchTemplateSpecification"
                    ([], (LaunchTemplateSpecification.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Overrides" ([], (Overrides.to_xml [x]))))
              v.overrides))
  end[@@ocaml.doc
       "<p>Describes a launch template and overrides.</p> <p>The overrides are used to override the instance type specified by the launch template with multiple instance types that can be used to launch On-Demand Instances and Spot Instances.</p> <p>When you update the launch template or overrides, existing Amazon EC2 instances continue to run. When scale out occurs, Amazon EC2 Auto Scaling launches instances to match the new settings. When scale in occurs, Amazon EC2 Auto Scaling terminates instances according to the group's termination policies.</p>"]
module SuspendedProcess =
  struct
    type t =
      {
      process_name: String.t option
        [@ocaml.doc "<p>The name of the suspended process.</p>"];
      suspension_reason: String.t option
        [@ocaml.doc "<p>The reason that the process was suspended.</p>"]}
    [@@ocaml.doc
      "<p>Describes an automatic scaling process that has been suspended. For more information, see <a>ProcessType</a>.</p>"]
    let make ?process_name  ?suspension_reason  () =
      { process_name; suspension_reason }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.suspension_reason
              (fun f -> ("suspension_reason", (String.to_json f)));
           Util.option_map v.process_name
             (fun f -> ("process_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          process_name =
            (Util.option_bind (Xml.member "ProcessName" xml) String.parse);
          suspension_reason =
            (Util.option_bind (Xml.member "SuspensionReason" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.process_name
               (fun f ->
                  Ezxmlm.make_tag "ProcessName" ([], (String.to_xml f)))])
           @
           [Util.option_map v.suspension_reason
              (fun f ->
                 Ezxmlm.make_tag "SuspensionReason" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Describes an automatic scaling process that has been suspended. For more information, see <a>ProcessType</a>.</p>"]
module TagDescription =
  struct
    type t =
      {
      resource_id: String.t [@ocaml.doc "<p>The name of the group.</p>"];
      resource_type: String.t
        [@ocaml.doc
          "<p>The type of resource. The only supported value is <code>auto-scaling-group</code>.</p>"];
      key: String.t [@ocaml.doc "<p>The tag key.</p>"];
      value: String.t [@ocaml.doc "<p>The tag value.</p>"];
      propagate_at_launch: Boolean.t
        [@ocaml.doc
          "<p>Determines whether the tag is added to new instances as they are launched in the group.</p>"]}
    [@@ocaml.doc "<p>Describes a tag for an Auto Scaling group.</p>"]
    let make ~resource_id  ~resource_type  ~key  ~value  ~propagate_at_launch
       () = { resource_id; resource_type; key; value; propagate_at_launch }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("propagate_at_launch",
                (Boolean.to_json v.propagate_at_launch));
           Some ("value", (String.to_json v.value));
           Some ("key", (String.to_json v.key));
           Some ("resource_type", (String.to_json v.resource_type));
           Some ("resource_id", (String.to_json v.resource_id))])
    let parse xml =
      Some
        {
          resource_id =
            (Xml.required "ResourceId"
               (Util.option_bind (Xml.member "ResourceId" xml) String.parse));
          resource_type =
            (Xml.required "ResourceType"
               (Util.option_bind (Xml.member "ResourceType" xml) String.parse));
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          value =
            (Xml.required "Value"
               (Util.option_bind (Xml.member "Value" xml) String.parse));
          propagate_at_launch =
            (Xml.required "PropagateAtLaunch"
               (Util.option_bind (Xml.member "PropagateAtLaunch" xml)
                  Boolean.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "ResourceId"
                     ([], (String.to_xml v.resource_id)))])
              @
              [Some
                 (Ezxmlm.make_tag "ResourceType"
                    ([], (String.to_xml v.resource_type)))])
             @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
            @ [Some (Ezxmlm.make_tag "Value" ([], (String.to_xml v.value)))])
           @
           [Some
              (Ezxmlm.make_tag "PropagateAtLaunch"
                 ([], (Boolean.to_xml v.propagate_at_launch)))])
  end[@@ocaml.doc "<p>Describes a tag for an Auto Scaling group.</p>"]
module BlockDeviceMapping =
  struct
    type t =
      {
      virtual_name: String.t option
        [@ocaml.doc
          "<p>The name of the virtual device (for example, <code>ephemeral0</code>).</p>"];
      device_name: String.t
        [@ocaml.doc
          "<p>The device name exposed to the EC2 instance (for example, <code>/dev/sdh</code> or <code>xvdh</code>). For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/device_naming.html\">Device Naming on Linux Instances</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.</p>"];
      ebs: Ebs.t option
        [@ocaml.doc "<p>The information about the Amazon EBS volume.</p>"];
      no_device: Boolean.t option
        [@ocaml.doc
          "<p>Suppresses a device mapping.</p> <p>If this parameter is true for the root device, the instance might fail the EC2 health check. In that case, Amazon EC2 Auto Scaling launches a replacement instance.</p>"]}
    [@@ocaml.doc "<p>Describes a block device mapping.</p>"]
    let make ?virtual_name  ~device_name  ?ebs  ?no_device  () =
      { virtual_name; device_name; ebs; no_device }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.no_device
              (fun f -> ("no_device", (Boolean.to_json f)));
           Util.option_map v.ebs (fun f -> ("ebs", (Ebs.to_json f)));
           Some ("device_name", (String.to_json v.device_name));
           Util.option_map v.virtual_name
             (fun f -> ("virtual_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          virtual_name =
            (Util.option_bind (Xml.member "VirtualName" xml) String.parse);
          device_name =
            (Xml.required "DeviceName"
               (Util.option_bind (Xml.member "DeviceName" xml) String.parse));
          ebs = (Util.option_bind (Xml.member "Ebs" xml) Ebs.parse);
          no_device =
            (Util.option_bind (Xml.member "NoDevice" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.virtual_name
                 (fun f ->
                    Ezxmlm.make_tag "VirtualName" ([], (String.to_xml f)))])
             @
             [Some
                (Ezxmlm.make_tag "DeviceName"
                   ([], (String.to_xml v.device_name)))])
            @
            [Util.option_map v.ebs
               (fun f -> Ezxmlm.make_tag "Ebs" ([], (Ebs.to_xml f)))])
           @
           [Util.option_map v.no_device
              (fun f -> Ezxmlm.make_tag "NoDevice" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc "<p>Describes a block device mapping.</p>"]
module Values =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module Alarms =
  struct
    type t = Alarm.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Alarm.to_query v
    let to_headers v = Headers.to_headers_list Alarm.to_headers v
    let to_json v = `List (List.map Alarm.to_json v)
    let parse xml =
      Util.option_all (List.map Alarm.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Alarm.to_xml x))) v
  end
module StepAdjustments =
  struct
    type t = StepAdjustment.t list
    let make elems () = elems
    let to_query v = Query.to_query_list StepAdjustment.to_query v
    let to_headers v = Headers.to_headers_list StepAdjustment.to_headers v
    let to_json v = `List (List.map StepAdjustment.to_json v)
    let parse xml =
      Util.option_all
        (List.map StepAdjustment.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (StepAdjustment.to_xml x))) v
  end
module TargetTrackingConfiguration =
  struct
    type t =
      {
      predefined_metric_specification: PredefinedMetricSpecification.t option
        [@ocaml.doc
          "<p>A predefined metric. You must specify either a predefined metric or a customized metric.</p>"];
      customized_metric_specification: CustomizedMetricSpecification.t option
        [@ocaml.doc
          "<p>A customized metric. You must specify either a predefined metric or a customized metric.</p>"];
      target_value: Double.t
        [@ocaml.doc "<p>The target value for the metric.</p>"];
      disable_scale_in: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether scaling in by the target tracking scaling policy is disabled. If scaling in is disabled, the target tracking scaling policy doesn't remove instances from the Auto Scaling group. Otherwise, the target tracking scaling policy can remove instances from the Auto Scaling group. The default is <code>false</code>.</p>"]}
    [@@ocaml.doc
      "<p>Represents a target tracking scaling policy configuration to use with Amazon EC2 Auto Scaling.</p>"]
    let make ?predefined_metric_specification 
      ?customized_metric_specification  ~target_value  ?disable_scale_in  ()
      =
      {
        predefined_metric_specification;
        customized_metric_specification;
        target_value;
        disable_scale_in
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.disable_scale_in
              (fun f -> ("disable_scale_in", (Boolean.to_json f)));
           Some ("target_value", (Double.to_json v.target_value));
           Util.option_map v.customized_metric_specification
             (fun f ->
                ("customized_metric_specification",
                  (CustomizedMetricSpecification.to_json f)));
           Util.option_map v.predefined_metric_specification
             (fun f ->
                ("predefined_metric_specification",
                  (PredefinedMetricSpecification.to_json f)))])
    let parse xml =
      Some
        {
          predefined_metric_specification =
            (Util.option_bind
               (Xml.member "PredefinedMetricSpecification" xml)
               PredefinedMetricSpecification.parse);
          customized_metric_specification =
            (Util.option_bind
               (Xml.member "CustomizedMetricSpecification" xml)
               CustomizedMetricSpecification.parse);
          target_value =
            (Xml.required "TargetValue"
               (Util.option_bind (Xml.member "TargetValue" xml) Double.parse));
          disable_scale_in =
            (Util.option_bind (Xml.member "DisableScaleIn" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.predefined_metric_specification
                 (fun f ->
                    Ezxmlm.make_tag "PredefinedMetricSpecification"
                      ([], (PredefinedMetricSpecification.to_xml f)))])
             @
             [Util.option_map v.customized_metric_specification
                (fun f ->
                   Ezxmlm.make_tag "CustomizedMetricSpecification"
                     ([], (CustomizedMetricSpecification.to_xml f)))])
            @
            [Some
               (Ezxmlm.make_tag "TargetValue"
                  ([], (Double.to_xml v.target_value)))])
           @
           [Util.option_map v.disable_scale_in
              (fun f ->
                 Ezxmlm.make_tag "DisableScaleIn" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents a target tracking scaling policy configuration to use with Amazon EC2 Auto Scaling.</p>"]
module ScalingActivityStatusCode =
  struct
    type t =
      | PendingSpotBidPlacement 
      | WaitingForSpotInstanceRequestId 
      | WaitingForSpotInstanceId 
      | WaitingForInstanceId 
      | PreInService 
      | InProgress 
      | WaitingForELBConnectionDraining 
      | MidLifecycleAction 
      | WaitingForInstanceWarmup 
      | Successful 
      | Failed 
      | Cancelled 
    let str_to_t =
      [("Cancelled", Cancelled);
      ("Failed", Failed);
      ("Successful", Successful);
      ("WaitingForInstanceWarmup", WaitingForInstanceWarmup);
      ("MidLifecycleAction", MidLifecycleAction);
      ("WaitingForELBConnectionDraining", WaitingForELBConnectionDraining);
      ("InProgress", InProgress);
      ("PreInService", PreInService);
      ("WaitingForInstanceId", WaitingForInstanceId);
      ("WaitingForSpotInstanceId", WaitingForSpotInstanceId);
      ("WaitingForSpotInstanceRequestId", WaitingForSpotInstanceRequestId);
      ("PendingSpotBidPlacement", PendingSpotBidPlacement)]
    let t_to_str =
      [(Cancelled, "Cancelled");
      (Failed, "Failed");
      (Successful, "Successful");
      (WaitingForInstanceWarmup, "WaitingForInstanceWarmup");
      (MidLifecycleAction, "MidLifecycleAction");
      (WaitingForELBConnectionDraining, "WaitingForELBConnectionDraining");
      (InProgress, "InProgress");
      (PreInService, "PreInService");
      (WaitingForInstanceId, "WaitingForInstanceId");
      (WaitingForSpotInstanceId, "WaitingForSpotInstanceId");
      (WaitingForSpotInstanceRequestId, "WaitingForSpotInstanceRequestId");
      (PendingSpotBidPlacement, "PendingSpotBidPlacement")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module AvailabilityZones =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module EnabledMetrics =
  struct
    type t = EnabledMetric.t list
    let make elems () = elems
    let to_query v = Query.to_query_list EnabledMetric.to_query v
    let to_headers v = Headers.to_headers_list EnabledMetric.to_headers v
    let to_json v = `List (List.map EnabledMetric.to_json v)
    let parse xml =
      Util.option_all
        (List.map EnabledMetric.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (EnabledMetric.to_xml x))) v
  end
module Instances =
  struct
    type t = Instance.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Instance.to_query v
    let to_headers v = Headers.to_headers_list Instance.to_headers v
    let to_json v = `List (List.map Instance.to_json v)
    let parse xml =
      Util.option_all (List.map Instance.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Instance.to_xml x)))
        v
  end
module LoadBalancerNames =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module MixedInstancesPolicy =
  struct
    type t =
      {
      launch_template: LaunchTemplate.t option
        [@ocaml.doc
          "<p>The launch template and instance types (overrides).</p> <p>This parameter must be specified when creating a mixed instances policy.</p>"];
      instances_distribution: InstancesDistribution.t option
        [@ocaml.doc
          "<p>The instances distribution to use.</p> <p>If you leave this parameter unspecified, the value for each parameter in <code>InstancesDistribution</code> uses a default value.</p>"]}
    [@@ocaml.doc
      "<p>Describes a mixed instances policy for an Auto Scaling group. With mixed instances, your Auto Scaling group can provision a combination of On-Demand Instances and Spot Instances across multiple instance types. For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-purchase-options.html\">Auto Scaling Groups with Multiple Instance Types and Purchase Options</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p> <p>You can create a mixed instances policy for a new Auto Scaling group, or you can create it for an existing group by updating the group to specify <code>MixedInstancesPolicy</code> as the top-level parameter instead of a launch configuration or template. For more information, see <a>CreateAutoScalingGroup</a> and <a>UpdateAutoScalingGroup</a>.</p>"]
    let make ?launch_template  ?instances_distribution  () =
      { launch_template; instances_distribution }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.instances_distribution
              (fun f ->
                 ("instances_distribution",
                   (InstancesDistribution.to_json f)));
           Util.option_map v.launch_template
             (fun f -> ("launch_template", (LaunchTemplate.to_json f)))])
    let parse xml =
      Some
        {
          launch_template =
            (Util.option_bind (Xml.member "LaunchTemplate" xml)
               LaunchTemplate.parse);
          instances_distribution =
            (Util.option_bind (Xml.member "InstancesDistribution" xml)
               InstancesDistribution.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.launch_template
               (fun f ->
                  Ezxmlm.make_tag "LaunchTemplate"
                    ([], (LaunchTemplate.to_xml f)))])
           @
           [Util.option_map v.instances_distribution
              (fun f ->
                 Ezxmlm.make_tag "InstancesDistribution"
                   ([], (InstancesDistribution.to_xml f)))])
  end[@@ocaml.doc
       "<p>Describes a mixed instances policy for an Auto Scaling group. With mixed instances, your Auto Scaling group can provision a combination of On-Demand Instances and Spot Instances across multiple instance types. For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-purchase-options.html\">Auto Scaling Groups with Multiple Instance Types and Purchase Options</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p> <p>You can create a mixed instances policy for a new Auto Scaling group, or you can create it for an existing group by updating the group to specify <code>MixedInstancesPolicy</code> as the top-level parameter instead of a launch configuration or template. For more information, see <a>CreateAutoScalingGroup</a> and <a>UpdateAutoScalingGroup</a>.</p>"]
module SuspendedProcesses =
  struct
    type t = SuspendedProcess.t list
    let make elems () = elems
    let to_query v = Query.to_query_list SuspendedProcess.to_query v
    let to_headers v = Headers.to_headers_list SuspendedProcess.to_headers v
    let to_json v = `List (List.map SuspendedProcess.to_json v)
    let parse xml =
      Util.option_all
        (List.map SuspendedProcess.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (SuspendedProcess.to_xml x)))
        v
  end
module TagDescriptionList =
  struct
    type t = TagDescription.t list
    let make elems () = elems
    let to_query v = Query.to_query_list TagDescription.to_query v
    let to_headers v = Headers.to_headers_list TagDescription.to_headers v
    let to_json v = `List (List.map TagDescription.to_json v)
    let parse xml =
      Util.option_all
        (List.map TagDescription.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (TagDescription.to_xml x))) v
  end
module TargetGroupARNs =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module TerminationPolicies =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module BlockDeviceMappings =
  struct
    type t = BlockDeviceMapping.t list
    let make elems () = elems
    let to_query v = Query.to_query_list BlockDeviceMapping.to_query v
    let to_headers v =
      Headers.to_headers_list BlockDeviceMapping.to_headers v
    let to_json v = `List (List.map BlockDeviceMapping.to_json v)
    let parse xml =
      Util.option_all
        (List.map BlockDeviceMapping.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (BlockDeviceMapping.to_xml x))) v
  end
module ClassicLinkVPCSecurityGroups =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module InstanceMonitoring =
  struct
    type t =
      {
      enabled: Boolean.t option
        [@ocaml.doc
          "<p>If <code>true</code>, detailed monitoring is enabled. Otherwise, basic monitoring is enabled.</p>"]}
    [@@ocaml.doc
      "<p>Describes whether detailed monitoring is enabled for the Auto Scaling instances.</p>"]
    let make ?enabled  () = { enabled }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.enabled
              (fun f -> ("enabled", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          enabled =
            (Util.option_bind (Xml.member "Enabled" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.enabled
              (fun f -> Ezxmlm.make_tag "Enabled" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc
       "<p>Describes whether detailed monitoring is enabled for the Auto Scaling instances.</p>"]
module SecurityGroups =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module Filter =
  struct
    type t =
      {
      name: String.t
        [@ocaml.doc
          "<p>The name of the filter. The valid values are: <code>\"auto-scaling-group\"</code>, <code>\"key\"</code>, <code>\"value\"</code>, and <code>\"propagate-at-launch\"</code>.</p>"];
      values: Values.t [@ocaml.doc "<p>The value of the filter.</p>"]}
    [@@ocaml.doc "<p>Describes a filter.</p>"]
    let make ~name  ?(values= [])  () = { name; values }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("values", (Values.to_json v.values));
           Some ("name", (String.to_json v.name))])
    let parse xml =
      Some
        {
          name =
            (Xml.required "Name"
               (Util.option_bind (Xml.member "Name" xml) String.parse));
          values =
            (Util.of_option []
               (Util.option_bind (Xml.member "Values" xml) Values.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "Name" ([], (String.to_xml v.name)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Values" ([], (Values.to_xml [x]))))
              v.values))
  end[@@ocaml.doc "<p>Describes a filter.</p>"]
module AutoScalingInstanceDetails =
  struct
    type t =
      {
      instance_id: String.t [@ocaml.doc "<p>The ID of the instance.</p>"];
      instance_type: String.t option
        [@ocaml.doc "<p>The instance type of the EC2 instance.</p>"];
      auto_scaling_group_name: String.t
        [@ocaml.doc
          "<p>The name of the Auto Scaling group for the instance.</p>"];
      availability_zone: String.t
        [@ocaml.doc "<p>The Availability Zone for the instance.</p>"];
      lifecycle_state: String.t
        [@ocaml.doc "<p>The lifecycle state for the instance.</p>"];
      health_status: String.t
        [@ocaml.doc
          "<p>The last reported health status of this instance. \"Healthy\" means that the instance is healthy and should remain in service. \"Unhealthy\" means that the instance is unhealthy and Amazon EC2 Auto Scaling should terminate and replace it.</p>"];
      launch_configuration_name: String.t option
        [@ocaml.doc
          "<p>The launch configuration used to launch the instance. This value is not available if you attached the instance to the Auto Scaling group.</p>"];
      launch_template: LaunchTemplateSpecification.t option
        [@ocaml.doc "<p>The launch template for the instance.</p>"];
      protected_from_scale_in: Boolean.t
        [@ocaml.doc
          "<p>Indicates whether the instance is protected from termination by Amazon EC2 Auto Scaling when scaling in.</p>"];
      weighted_capacity: String.t option
        [@ocaml.doc
          "<p>The number of capacity units contributed by the instance based on its instance type.</p> <p>Valid Range: Minimum value of 1. Maximum value of 999.</p>"]}
    [@@ocaml.doc
      "<p>Describes an EC2 instance associated with an Auto Scaling group.</p>"]
    let make ~instance_id  ?instance_type  ~auto_scaling_group_name 
      ~availability_zone  ~lifecycle_state  ~health_status 
      ?launch_configuration_name  ?launch_template  ~protected_from_scale_in 
      ?weighted_capacity  () =
      {
        instance_id;
        instance_type;
        auto_scaling_group_name;
        availability_zone;
        lifecycle_state;
        health_status;
        launch_configuration_name;
        launch_template;
        protected_from_scale_in;
        weighted_capacity
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.weighted_capacity
              (fun f -> ("weighted_capacity", (String.to_json f)));
           Some
             ("protected_from_scale_in",
               (Boolean.to_json v.protected_from_scale_in));
           Util.option_map v.launch_template
             (fun f ->
                ("launch_template", (LaunchTemplateSpecification.to_json f)));
           Util.option_map v.launch_configuration_name
             (fun f -> ("launch_configuration_name", (String.to_json f)));
           Some ("health_status", (String.to_json v.health_status));
           Some ("lifecycle_state", (String.to_json v.lifecycle_state));
           Some ("availability_zone", (String.to_json v.availability_zone));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name));
           Util.option_map v.instance_type
             (fun f -> ("instance_type", (String.to_json f)));
           Some ("instance_id", (String.to_json v.instance_id))])
    let parse xml =
      Some
        {
          instance_id =
            (Xml.required "InstanceId"
               (Util.option_bind (Xml.member "InstanceId" xml) String.parse));
          instance_type =
            (Util.option_bind (Xml.member "InstanceType" xml) String.parse);
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          availability_zone =
            (Xml.required "AvailabilityZone"
               (Util.option_bind (Xml.member "AvailabilityZone" xml)
                  String.parse));
          lifecycle_state =
            (Xml.required "LifecycleState"
               (Util.option_bind (Xml.member "LifecycleState" xml)
                  String.parse));
          health_status =
            (Xml.required "HealthStatus"
               (Util.option_bind (Xml.member "HealthStatus" xml) String.parse));
          launch_configuration_name =
            (Util.option_bind (Xml.member "LaunchConfigurationName" xml)
               String.parse);
          launch_template =
            (Util.option_bind (Xml.member "LaunchTemplate" xml)
               LaunchTemplateSpecification.parse);
          protected_from_scale_in =
            (Xml.required "ProtectedFromScaleIn"
               (Util.option_bind (Xml.member "ProtectedFromScaleIn" xml)
                  Boolean.parse));
          weighted_capacity =
            (Util.option_bind (Xml.member "WeightedCapacity" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((([] @
                    [Some
                       (Ezxmlm.make_tag "InstanceId"
                          ([], (String.to_xml v.instance_id)))])
                   @
                   [Util.option_map v.instance_type
                      (fun f ->
                         Ezxmlm.make_tag "InstanceType"
                           ([], (String.to_xml f)))])
                  @
                  [Some
                     (Ezxmlm.make_tag "AutoScalingGroupName"
                        ([], (String.to_xml v.auto_scaling_group_name)))])
                 @
                 [Some
                    (Ezxmlm.make_tag "AvailabilityZone"
                       ([], (String.to_xml v.availability_zone)))])
                @
                [Some
                   (Ezxmlm.make_tag "LifecycleState"
                      ([], (String.to_xml v.lifecycle_state)))])
               @
               [Some
                  (Ezxmlm.make_tag "HealthStatus"
                     ([], (String.to_xml v.health_status)))])
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
            [Some
               (Ezxmlm.make_tag "ProtectedFromScaleIn"
                  ([], (Boolean.to_xml v.protected_from_scale_in)))])
           @
           [Util.option_map v.weighted_capacity
              (fun f ->
                 Ezxmlm.make_tag "WeightedCapacity" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Describes an EC2 instance associated with an Auto Scaling group.</p>"]
module FailedScheduledUpdateGroupActionRequest =
  struct
    type t =
      {
      scheduled_action_name: String.t
        [@ocaml.doc "<p>The name of the scheduled action.</p>"];
      error_code: String.t option [@ocaml.doc "<p>The error code.</p>"];
      error_message: String.t option
        [@ocaml.doc "<p>The error message accompanying the error code.</p>"]}
    [@@ocaml.doc
      "<p>Describes a scheduled action that could not be created, updated, or deleted.</p>"]
    let make ~scheduled_action_name  ?error_code  ?error_message  () =
      { scheduled_action_name; error_code; error_message }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.error_message
              (fun f -> ("error_message", (String.to_json f)));
           Util.option_map v.error_code
             (fun f -> ("error_code", (String.to_json f)));
           Some
             ("scheduled_action_name",
               (String.to_json v.scheduled_action_name))])
    let parse xml =
      Some
        {
          scheduled_action_name =
            (Xml.required "ScheduledActionName"
               (Util.option_bind (Xml.member "ScheduledActionName" xml)
                  String.parse));
          error_code =
            (Util.option_bind (Xml.member "ErrorCode" xml) String.parse);
          error_message =
            (Util.option_bind (Xml.member "ErrorMessage" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "ScheduledActionName"
                   ([], (String.to_xml v.scheduled_action_name)))])
            @
            [Util.option_map v.error_code
               (fun f -> Ezxmlm.make_tag "ErrorCode" ([], (String.to_xml f)))])
           @
           [Util.option_map v.error_message
              (fun f ->
                 Ezxmlm.make_tag "ErrorMessage" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Describes a scheduled action that could not be created, updated, or deleted.</p>"]
module ScalingPolicy =
  struct
    type t =
      {
      auto_scaling_group_name: String.t option
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      policy_name: String.t option
        [@ocaml.doc "<p>The name of the scaling policy.</p>"];
      policy_a_r_n: String.t option
        [@ocaml.doc "<p>The Amazon Resource Name (ARN) of the policy.</p>"];
      policy_type: String.t option
        [@ocaml.doc
          "<p>The policy type. The valid values are <code>SimpleScaling</code>, <code>StepScaling</code>, and <code>TargetTrackingScaling</code>.</p>"];
      adjustment_type: String.t option
        [@ocaml.doc
          "<p>The adjustment type, which specifies how <code>ScalingAdjustment</code> is interpreted. The valid values are <code>ChangeInCapacity</code>, <code>ExactCapacity</code>, and <code>PercentChangeInCapacity</code>.</p>"];
      min_adjustment_step: Integer.t option
        [@ocaml.doc
          "<p>Available for backward compatibility. Use <code>MinAdjustmentMagnitude</code> instead.</p>"];
      min_adjustment_magnitude: Integer.t option
        [@ocaml.doc
          "<p>The minimum number of instances to scale. If the value of <code>AdjustmentType</code> is <code>PercentChangeInCapacity</code>, the scaling policy changes the <code>DesiredCapacity</code> of the Auto Scaling group by at least this many instances. Otherwise, the error is <code>ValidationError</code>.</p>"];
      scaling_adjustment: Integer.t option
        [@ocaml.doc
          "<p>The amount by which to scale, based on the specified adjustment type. A positive value adds to the current capacity while a negative number removes from the current capacity.</p>"];
      cooldown: Integer.t option
        [@ocaml.doc
          "<p>The amount of time, in seconds, after a scaling activity completes before any further dynamic scaling activities can start.</p>"];
      step_adjustments: StepAdjustments.t
        [@ocaml.doc
          "<p>A set of adjustments that enable you to scale based on the size of the alarm breach.</p>"];
      metric_aggregation_type: String.t option
        [@ocaml.doc
          "<p>The aggregation type for the CloudWatch metrics. The valid values are <code>Minimum</code>, <code>Maximum</code>, and <code>Average</code>.</p>"];
      estimated_instance_warmup: Integer.t option
        [@ocaml.doc
          "<p>The estimated time, in seconds, until a newly launched instance can contribute to the CloudWatch metrics.</p>"];
      alarms: Alarms.t
        [@ocaml.doc "<p>The CloudWatch alarms related to the policy.</p>"];
      target_tracking_configuration: TargetTrackingConfiguration.t option
        [@ocaml.doc "<p>A target tracking scaling policy.</p>"]}[@@ocaml.doc
                                                                  "<p>Describes a scaling policy.</p>"]
    let make ?auto_scaling_group_name  ?policy_name  ?policy_a_r_n 
      ?policy_type  ?adjustment_type  ?min_adjustment_step 
      ?min_adjustment_magnitude  ?scaling_adjustment  ?cooldown 
      ?(step_adjustments= [])  ?metric_aggregation_type 
      ?estimated_instance_warmup  ?(alarms= []) 
      ?target_tracking_configuration  () =
      {
        auto_scaling_group_name;
        policy_name;
        policy_a_r_n;
        policy_type;
        adjustment_type;
        min_adjustment_step;
        min_adjustment_magnitude;
        scaling_adjustment;
        cooldown;
        step_adjustments;
        metric_aggregation_type;
        estimated_instance_warmup;
        alarms;
        target_tracking_configuration
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.target_tracking_configuration
              (fun f ->
                 ("target_tracking_configuration",
                   (TargetTrackingConfiguration.to_json f)));
           Some ("alarms", (Alarms.to_json v.alarms));
           Util.option_map v.estimated_instance_warmup
             (fun f -> ("estimated_instance_warmup", (Integer.to_json f)));
           Util.option_map v.metric_aggregation_type
             (fun f -> ("metric_aggregation_type", (String.to_json f)));
           Some
             ("step_adjustments",
               (StepAdjustments.to_json v.step_adjustments));
           Util.option_map v.cooldown
             (fun f -> ("cooldown", (Integer.to_json f)));
           Util.option_map v.scaling_adjustment
             (fun f -> ("scaling_adjustment", (Integer.to_json f)));
           Util.option_map v.min_adjustment_magnitude
             (fun f -> ("min_adjustment_magnitude", (Integer.to_json f)));
           Util.option_map v.min_adjustment_step
             (fun f -> ("min_adjustment_step", (Integer.to_json f)));
           Util.option_map v.adjustment_type
             (fun f -> ("adjustment_type", (String.to_json f)));
           Util.option_map v.policy_type
             (fun f -> ("policy_type", (String.to_json f)));
           Util.option_map v.policy_a_r_n
             (fun f -> ("policy_a_r_n", (String.to_json f)));
           Util.option_map v.policy_name
             (fun f -> ("policy_name", (String.to_json f)));
           Util.option_map v.auto_scaling_group_name
             (fun f -> ("auto_scaling_group_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
               String.parse);
          policy_name =
            (Util.option_bind (Xml.member "PolicyName" xml) String.parse);
          policy_a_r_n =
            (Util.option_bind (Xml.member "PolicyARN" xml) String.parse);
          policy_type =
            (Util.option_bind (Xml.member "PolicyType" xml) String.parse);
          adjustment_type =
            (Util.option_bind (Xml.member "AdjustmentType" xml) String.parse);
          min_adjustment_step =
            (Util.option_bind (Xml.member "MinAdjustmentStep" xml)
               Integer.parse);
          min_adjustment_magnitude =
            (Util.option_bind (Xml.member "MinAdjustmentMagnitude" xml)
               Integer.parse);
          scaling_adjustment =
            (Util.option_bind (Xml.member "ScalingAdjustment" xml)
               Integer.parse);
          cooldown =
            (Util.option_bind (Xml.member "Cooldown" xml) Integer.parse);
          step_adjustments =
            (Util.of_option []
               (Util.option_bind (Xml.member "StepAdjustments" xml)
                  StepAdjustments.parse));
          metric_aggregation_type =
            (Util.option_bind (Xml.member "MetricAggregationType" xml)
               String.parse);
          estimated_instance_warmup =
            (Util.option_bind (Xml.member "EstimatedInstanceWarmup" xml)
               Integer.parse);
          alarms =
            (Util.of_option []
               (Util.option_bind (Xml.member "Alarms" xml) Alarms.parse));
          target_tracking_configuration =
            (Util.option_bind (Xml.member "TargetTrackingConfiguration" xml)
               TargetTrackingConfiguration.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((([] @
                        [Util.option_map v.auto_scaling_group_name
                           (fun f ->
                              Ezxmlm.make_tag "AutoScalingGroupName"
                                ([], (String.to_xml f)))])
                       @
                       [Util.option_map v.policy_name
                          (fun f ->
                             Ezxmlm.make_tag "PolicyName"
                               ([], (String.to_xml f)))])
                      @
                      [Util.option_map v.policy_a_r_n
                         (fun f ->
                            Ezxmlm.make_tag "PolicyARN"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.policy_type
                        (fun f ->
                           Ezxmlm.make_tag "PolicyType"
                             ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.adjustment_type
                       (fun f ->
                          Ezxmlm.make_tag "AdjustmentType"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.min_adjustment_step
                      (fun f ->
                         Ezxmlm.make_tag "MinAdjustmentStep"
                           ([], (Integer.to_xml f)))])
                  @
                  [Util.option_map v.min_adjustment_magnitude
                     (fun f ->
                        Ezxmlm.make_tag "MinAdjustmentMagnitude"
                          ([], (Integer.to_xml f)))])
                 @
                 [Util.option_map v.scaling_adjustment
                    (fun f ->
                       Ezxmlm.make_tag "ScalingAdjustment"
                         ([], (Integer.to_xml f)))])
                @
                [Util.option_map v.cooldown
                   (fun f ->
                      Ezxmlm.make_tag "Cooldown" ([], (Integer.to_xml f)))])
               @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "StepAdjustments"
                          ([], (StepAdjustments.to_xml [x]))))
                  v.step_adjustments))
              @
              [Util.option_map v.metric_aggregation_type
                 (fun f ->
                    Ezxmlm.make_tag "MetricAggregationType"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.estimated_instance_warmup
                (fun f ->
                   Ezxmlm.make_tag "EstimatedInstanceWarmup"
                     ([], (Integer.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some (Ezxmlm.make_tag "Alarms" ([], (Alarms.to_xml [x]))))
               v.alarms))
           @
           [Util.option_map v.target_tracking_configuration
              (fun f ->
                 Ezxmlm.make_tag "TargetTrackingConfiguration"
                   ([], (TargetTrackingConfiguration.to_xml f)))])
  end[@@ocaml.doc "<p>Describes a scaling policy.</p>"]
module LifecycleHookSpecification =
  struct
    type t =
      {
      lifecycle_hook_name: String.t
        [@ocaml.doc "<p>The name of the lifecycle hook.</p>"];
      lifecycle_transition: String.t
        [@ocaml.doc
          "<p>The state of the EC2 instance to which you want to attach the lifecycle hook. The valid values are:</p> <ul> <li> <p>autoscaling:EC2_INSTANCE_LAUNCHING</p> </li> <li> <p>autoscaling:EC2_INSTANCE_TERMINATING</p> </li> </ul>"];
      notification_metadata: String.t option
        [@ocaml.doc
          "<p>Additional information that you want to include any time Amazon EC2 Auto Scaling sends a message to the notification target.</p>"];
      heartbeat_timeout: Integer.t option
        [@ocaml.doc
          "<p>The maximum time, in seconds, that can elapse before the lifecycle hook times out.</p> <p>If the lifecycle hook times out, Amazon EC2 Auto Scaling performs the action that you specified in the <code>DefaultResult</code> parameter. You can prevent the lifecycle hook from timing out by calling <a>RecordLifecycleActionHeartbeat</a>.</p>"];
      default_result: String.t option
        [@ocaml.doc
          "<p>Defines the action the Auto Scaling group should take when the lifecycle hook timeout elapses or if an unexpected failure occurs. The valid values are <code>CONTINUE</code> and <code>ABANDON</code>. The default value is <code>ABANDON</code>.</p>"];
      notification_target_a_r_n: String.t option
        [@ocaml.doc
          "<p>The ARN of the target that Amazon EC2 Auto Scaling sends notifications to when an instance is in the transition state for the lifecycle hook. The notification target can be either an SQS queue or an SNS topic.</p>"];
      role_a_r_n: String.t option
        [@ocaml.doc
          "<p>The ARN of the IAM role that allows the Auto Scaling group to publish to the specified notification target, for example, an Amazon SNS topic or an Amazon SQS queue.</p>"]}
    [@@ocaml.doc
      "<p>Describes a lifecycle hook. Used in combination with <a>CreateAutoScalingGroup</a>.</p> <p>A lifecycle hook tells Amazon EC2 Auto Scaling to perform an action on an instance when the instance launches (before it is put into service) or as the instance terminates (before it is fully terminated).</p> <p>This step is a part of the procedure for creating a lifecycle hook for an Auto Scaling group:</p> <ol> <li> <p>(Optional) Create a Lambda function and a rule that allows CloudWatch Events to invoke your Lambda function when Amazon EC2 Auto Scaling launches or terminates instances.</p> </li> <li> <p>(Optional) Create a notification target and an IAM role. The target can be either an Amazon SQS queue or an Amazon SNS topic. The role allows Amazon EC2 Auto Scaling to publish lifecycle notifications to the target.</p> </li> <li> <p> <b>Create the lifecycle hook. Specify whether the hook is used when the instances launch or terminate.</b> </p> </li> <li> <p>If you need more time, record the lifecycle action heartbeat to keep the instance in a pending state using <a>RecordLifecycleActionHeartbeat</a>.</p> </li> <li> <p>If you finish before the timeout period ends, complete the lifecycle action using <a>CompleteLifecycleAction</a>.</p> </li> </ol> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/lifecycle-hooks.html\">Amazon EC2 Auto Scaling Lifecycle Hooks</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p> <p>You can view the lifecycle hooks for an Auto Scaling group using <a>DescribeLifecycleHooks</a>. You can modify an existing lifecycle hook or create new lifecycle hooks using <a>PutLifecycleHook</a>. If you are no longer using a lifecycle hook, you can delete it using <a>DeleteLifecycleHook</a>.</p>"]
    let make ~lifecycle_hook_name  ~lifecycle_transition 
      ?notification_metadata  ?heartbeat_timeout  ?default_result 
      ?notification_target_a_r_n  ?role_a_r_n  () =
      {
        lifecycle_hook_name;
        lifecycle_transition;
        notification_metadata;
        heartbeat_timeout;
        default_result;
        notification_target_a_r_n;
        role_a_r_n
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.role_a_r_n
              (fun f -> ("role_a_r_n", (String.to_json f)));
           Util.option_map v.notification_target_a_r_n
             (fun f -> ("notification_target_a_r_n", (String.to_json f)));
           Util.option_map v.default_result
             (fun f -> ("default_result", (String.to_json f)));
           Util.option_map v.heartbeat_timeout
             (fun f -> ("heartbeat_timeout", (Integer.to_json f)));
           Util.option_map v.notification_metadata
             (fun f -> ("notification_metadata", (String.to_json f)));
           Some
             ("lifecycle_transition",
               (String.to_json v.lifecycle_transition));
           Some
             ("lifecycle_hook_name", (String.to_json v.lifecycle_hook_name))])
    let parse xml =
      Some
        {
          lifecycle_hook_name =
            (Xml.required "LifecycleHookName"
               (Util.option_bind (Xml.member "LifecycleHookName" xml)
                  String.parse));
          lifecycle_transition =
            (Xml.required "LifecycleTransition"
               (Util.option_bind (Xml.member "LifecycleTransition" xml)
                  String.parse));
          notification_metadata =
            (Util.option_bind (Xml.member "NotificationMetadata" xml)
               String.parse);
          heartbeat_timeout =
            (Util.option_bind (Xml.member "HeartbeatTimeout" xml)
               Integer.parse);
          default_result =
            (Util.option_bind (Xml.member "DefaultResult" xml) String.parse);
          notification_target_a_r_n =
            (Util.option_bind (Xml.member "NotificationTargetARN" xml)
               String.parse);
          role_a_r_n =
            (Util.option_bind (Xml.member "RoleARN" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Some
                    (Ezxmlm.make_tag "LifecycleHookName"
                       ([], (String.to_xml v.lifecycle_hook_name)))])
                @
                [Some
                   (Ezxmlm.make_tag "LifecycleTransition"
                      ([], (String.to_xml v.lifecycle_transition)))])
               @
               [Util.option_map v.notification_metadata
                  (fun f ->
                     Ezxmlm.make_tag "NotificationMetadata"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.heartbeat_timeout
                 (fun f ->
                    Ezxmlm.make_tag "HeartbeatTimeout"
                      ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.default_result
                (fun f ->
                   Ezxmlm.make_tag "DefaultResult" ([], (String.to_xml f)))])
            @
            [Util.option_map v.notification_target_a_r_n
               (fun f ->
                  Ezxmlm.make_tag "NotificationTargetARN"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.role_a_r_n
              (fun f -> Ezxmlm.make_tag "RoleARN" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Describes a lifecycle hook. Used in combination with <a>CreateAutoScalingGroup</a>.</p> <p>A lifecycle hook tells Amazon EC2 Auto Scaling to perform an action on an instance when the instance launches (before it is put into service) or as the instance terminates (before it is fully terminated).</p> <p>This step is a part of the procedure for creating a lifecycle hook for an Auto Scaling group:</p> <ol> <li> <p>(Optional) Create a Lambda function and a rule that allows CloudWatch Events to invoke your Lambda function when Amazon EC2 Auto Scaling launches or terminates instances.</p> </li> <li> <p>(Optional) Create a notification target and an IAM role. The target can be either an Amazon SQS queue or an Amazon SNS topic. The role allows Amazon EC2 Auto Scaling to publish lifecycle notifications to the target.</p> </li> <li> <p> <b>Create the lifecycle hook. Specify whether the hook is used when the instances launch or terminate.</b> </p> </li> <li> <p>If you need more time, record the lifecycle action heartbeat to keep the instance in a pending state using <a>RecordLifecycleActionHeartbeat</a>.</p> </li> <li> <p>If you finish before the timeout period ends, complete the lifecycle action using <a>CompleteLifecycleAction</a>.</p> </li> </ol> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/lifecycle-hooks.html\">Amazon EC2 Auto Scaling Lifecycle Hooks</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p> <p>You can view the lifecycle hooks for an Auto Scaling group using <a>DescribeLifecycleHooks</a>. You can modify an existing lifecycle hook or create new lifecycle hooks using <a>PutLifecycleHook</a>. If you are no longer using a lifecycle hook, you can delete it using <a>DeleteLifecycleHook</a>.</p>"]
module Tag =
  struct
    type t =
      {
      resource_id: String.t [@ocaml.doc "<p>The name of the group.</p>"];
      resource_type: String.t
        [@ocaml.doc
          "<p>The type of resource. The only supported value is <code>auto-scaling-group</code>.</p>"];
      key: String.t [@ocaml.doc "<p>The tag key.</p>"];
      value: String.t [@ocaml.doc "<p>The tag value.</p>"];
      propagate_at_launch: Boolean.t
        [@ocaml.doc
          "<p>Determines whether the tag is added to new instances as they are launched in the group.</p>"]}
    [@@ocaml.doc "<p>Describes a tag for an Auto Scaling group.</p>"]
    let make ~resource_id  ~resource_type  ~key  ~value  ~propagate_at_launch
       () = { resource_id; resource_type; key; value; propagate_at_launch }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("propagate_at_launch",
                (Boolean.to_json v.propagate_at_launch));
           Some ("value", (String.to_json v.value));
           Some ("key", (String.to_json v.key));
           Some ("resource_type", (String.to_json v.resource_type));
           Some ("resource_id", (String.to_json v.resource_id))])
    let parse xml =
      Some
        {
          resource_id =
            (Xml.required "ResourceId"
               (Util.option_bind (Xml.member "ResourceId" xml) String.parse));
          resource_type =
            (Xml.required "ResourceType"
               (Util.option_bind (Xml.member "ResourceType" xml) String.parse));
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          value =
            (Xml.required "Value"
               (Util.option_bind (Xml.member "Value" xml) String.parse));
          propagate_at_launch =
            (Xml.required "PropagateAtLaunch"
               (Util.option_bind (Xml.member "PropagateAtLaunch" xml)
                  Boolean.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "ResourceId"
                     ([], (String.to_xml v.resource_id)))])
              @
              [Some
                 (Ezxmlm.make_tag "ResourceType"
                    ([], (String.to_xml v.resource_type)))])
             @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
            @ [Some (Ezxmlm.make_tag "Value" ([], (String.to_xml v.value)))])
           @
           [Some
              (Ezxmlm.make_tag "PropagateAtLaunch"
                 ([], (Boolean.to_xml v.propagate_at_launch)))])
  end[@@ocaml.doc "<p>Describes a tag for an Auto Scaling group.</p>"]
module LifecycleHook =
  struct
    type t =
      {
      lifecycle_hook_name: String.t option
        [@ocaml.doc "<p>The name of the lifecycle hook.</p>"];
      auto_scaling_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the Auto Scaling group for the lifecycle hook.</p>"];
      lifecycle_transition: String.t option
        [@ocaml.doc
          "<p>The state of the EC2 instance to which to attach the lifecycle hook. The following are possible values:</p> <ul> <li> <p>autoscaling:EC2_INSTANCE_LAUNCHING</p> </li> <li> <p>autoscaling:EC2_INSTANCE_TERMINATING</p> </li> </ul>"];
      notification_target_a_r_n: String.t option
        [@ocaml.doc
          "<p>The ARN of the target that Amazon EC2 Auto Scaling sends notifications to when an instance is in the transition state for the lifecycle hook. The notification target can be either an SQS queue or an SNS topic.</p>"];
      role_a_r_n: String.t option
        [@ocaml.doc
          "<p>The ARN of the IAM role that allows the Auto Scaling group to publish to the specified notification target.</p>"];
      notification_metadata: String.t option
        [@ocaml.doc
          "<p>Additional information that is included any time Amazon EC2 Auto Scaling sends a message to the notification target.</p>"];
      heartbeat_timeout: Integer.t option
        [@ocaml.doc
          "<p>The maximum time, in seconds, that can elapse before the lifecycle hook times out. If the lifecycle hook times out, Amazon EC2 Auto Scaling performs the action that you specified in the <code>DefaultResult</code> parameter.</p>"];
      global_timeout: Integer.t option
        [@ocaml.doc
          "<p>The maximum time, in seconds, that an instance can remain in a <code>Pending:Wait</code> or <code>Terminating:Wait</code> state. The maximum is 172800 seconds (48 hours) or 100 times <code>HeartbeatTimeout</code>, whichever is smaller.</p>"];
      default_result: String.t option
        [@ocaml.doc
          "<p>Defines the action the Auto Scaling group should take when the lifecycle hook timeout elapses or if an unexpected failure occurs. The possible values are <code>CONTINUE</code> and <code>ABANDON</code>.</p>"]}
    [@@ocaml.doc
      "<p>Describes a lifecycle hook, which tells Amazon EC2 Auto Scaling that you want to perform an action whenever it launches instances or terminates instances. Used in response to <a>DescribeLifecycleHooks</a>.</p>"]
    let make ?lifecycle_hook_name  ?auto_scaling_group_name 
      ?lifecycle_transition  ?notification_target_a_r_n  ?role_a_r_n 
      ?notification_metadata  ?heartbeat_timeout  ?global_timeout 
      ?default_result  () =
      {
        lifecycle_hook_name;
        auto_scaling_group_name;
        lifecycle_transition;
        notification_target_a_r_n;
        role_a_r_n;
        notification_metadata;
        heartbeat_timeout;
        global_timeout;
        default_result
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.default_result
              (fun f -> ("default_result", (String.to_json f)));
           Util.option_map v.global_timeout
             (fun f -> ("global_timeout", (Integer.to_json f)));
           Util.option_map v.heartbeat_timeout
             (fun f -> ("heartbeat_timeout", (Integer.to_json f)));
           Util.option_map v.notification_metadata
             (fun f -> ("notification_metadata", (String.to_json f)));
           Util.option_map v.role_a_r_n
             (fun f -> ("role_a_r_n", (String.to_json f)));
           Util.option_map v.notification_target_a_r_n
             (fun f -> ("notification_target_a_r_n", (String.to_json f)));
           Util.option_map v.lifecycle_transition
             (fun f -> ("lifecycle_transition", (String.to_json f)));
           Util.option_map v.auto_scaling_group_name
             (fun f -> ("auto_scaling_group_name", (String.to_json f)));
           Util.option_map v.lifecycle_hook_name
             (fun f -> ("lifecycle_hook_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          lifecycle_hook_name =
            (Util.option_bind (Xml.member "LifecycleHookName" xml)
               String.parse);
          auto_scaling_group_name =
            (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
               String.parse);
          lifecycle_transition =
            (Util.option_bind (Xml.member "LifecycleTransition" xml)
               String.parse);
          notification_target_a_r_n =
            (Util.option_bind (Xml.member "NotificationTargetARN" xml)
               String.parse);
          role_a_r_n =
            (Util.option_bind (Xml.member "RoleARN" xml) String.parse);
          notification_metadata =
            (Util.option_bind (Xml.member "NotificationMetadata" xml)
               String.parse);
          heartbeat_timeout =
            (Util.option_bind (Xml.member "HeartbeatTimeout" xml)
               Integer.parse);
          global_timeout =
            (Util.option_bind (Xml.member "GlobalTimeout" xml) Integer.parse);
          default_result =
            (Util.option_bind (Xml.member "DefaultResult" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Util.option_map v.lifecycle_hook_name
                      (fun f ->
                         Ezxmlm.make_tag "LifecycleHookName"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.auto_scaling_group_name
                     (fun f ->
                        Ezxmlm.make_tag "AutoScalingGroupName"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.lifecycle_transition
                    (fun f ->
                       Ezxmlm.make_tag "LifecycleTransition"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.notification_target_a_r_n
                   (fun f ->
                      Ezxmlm.make_tag "NotificationTargetARN"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.role_a_r_n
                  (fun f -> Ezxmlm.make_tag "RoleARN" ([], (String.to_xml f)))])
              @
              [Util.option_map v.notification_metadata
                 (fun f ->
                    Ezxmlm.make_tag "NotificationMetadata"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.heartbeat_timeout
                (fun f ->
                   Ezxmlm.make_tag "HeartbeatTimeout"
                     ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.global_timeout
               (fun f ->
                  Ezxmlm.make_tag "GlobalTimeout" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.default_result
              (fun f ->
                 Ezxmlm.make_tag "DefaultResult" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Describes a lifecycle hook, which tells Amazon EC2 Auto Scaling that you want to perform an action whenever it launches instances or terminates instances. Used in response to <a>DescribeLifecycleHooks</a>.</p>"]
module LoadBalancerTargetGroupState =
  struct
    type t =
      {
      load_balancer_target_group_a_r_n: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the target group.</p>"];
      state: String.t option
        [@ocaml.doc
          "<p>The state of the target group.</p> <ul> <li> <p> <code>Adding</code> - The Auto Scaling instances are being registered with the target group.</p> </li> <li> <p> <code>Added</code> - All Auto Scaling instances are registered with the target group.</p> </li> <li> <p> <code>InService</code> - At least one Auto Scaling instance passed an ELB health check.</p> </li> <li> <p> <code>Removing</code> - The Auto Scaling instances are being deregistered from the target group. If connection draining is enabled, Elastic Load Balancing waits for in-flight requests to complete before deregistering the instances.</p> </li> <li> <p> <code>Removed</code> - All Auto Scaling instances are deregistered from the target group.</p> </li> </ul>"]}
    [@@ocaml.doc
      "<p>Describes the state of a target group.</p> <p>If you attach a target group to an existing Auto Scaling group, the initial state is <code>Adding</code>. The state transitions to <code>Added</code> after all Auto Scaling instances are registered with the target group. If Elastic Load Balancing health checks are enabled, the state transitions to <code>InService</code> after at least one Auto Scaling instance passes the health check. If EC2 health checks are enabled instead, the target group remains in the <code>Added</code> state.</p>"]
    let make ?load_balancer_target_group_a_r_n  ?state  () =
      { load_balancer_target_group_a_r_n; state }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.state (fun f -> ("state", (String.to_json f)));
           Util.option_map v.load_balancer_target_group_a_r_n
             (fun f ->
                ("load_balancer_target_group_a_r_n", (String.to_json f)))])
    let parse xml =
      Some
        {
          load_balancer_target_group_a_r_n =
            (Util.option_bind (Xml.member "LoadBalancerTargetGroupARN" xml)
               String.parse);
          state = (Util.option_bind (Xml.member "State" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.load_balancer_target_group_a_r_n
               (fun f ->
                  Ezxmlm.make_tag "LoadBalancerTargetGroupARN"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.state
              (fun f -> Ezxmlm.make_tag "State" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Describes the state of a target group.</p> <p>If you attach a target group to an existing Auto Scaling group, the initial state is <code>Adding</code>. The state transitions to <code>Added</code> after all Auto Scaling instances are registered with the target group. If Elastic Load Balancing health checks are enabled, the state transitions to <code>InService</code> after at least one Auto Scaling instance passes the health check. If EC2 health checks are enabled instead, the target group remains in the <code>Added</code> state.</p>"]
module Activity =
  struct
    type t =
      {
      activity_id: String.t [@ocaml.doc "<p>The ID of the activity.</p>"];
      auto_scaling_group_name: String.t
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      description: String.t option
        [@ocaml.doc
          "<p>A friendly, more verbose description of the activity.</p>"];
      cause: String.t [@ocaml.doc "<p>The reason the activity began.</p>"];
      start_time: DateTime.t
        [@ocaml.doc "<p>The start time of the activity.</p>"];
      end_time: DateTime.t option
        [@ocaml.doc "<p>The end time of the activity.</p>"];
      status_code: ScalingActivityStatusCode.t
        [@ocaml.doc "<p>The current status of the activity.</p>"];
      status_message: String.t option
        [@ocaml.doc
          "<p>A friendly, more verbose description of the activity status.</p>"];
      progress: Integer.t option
        [@ocaml.doc
          "<p>A value between 0 and 100 that indicates the progress of the activity.</p>"];
      details: String.t option
        [@ocaml.doc "<p>The details about the activity.</p>"]}[@@ocaml.doc
                                                                "<p>Describes scaling activity, which is a long-running process that represents a change to your Auto Scaling group, such as changing its size or replacing an instance.</p>"]
    let make ~activity_id  ~auto_scaling_group_name  ?description  ~cause 
      ~start_time  ?end_time  ~status_code  ?status_message  ?progress 
      ?details  () =
      {
        activity_id;
        auto_scaling_group_name;
        description;
        cause;
        start_time;
        end_time;
        status_code;
        status_message;
        progress;
        details
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.details
              (fun f -> ("details", (String.to_json f)));
           Util.option_map v.progress
             (fun f -> ("progress", (Integer.to_json f)));
           Util.option_map v.status_message
             (fun f -> ("status_message", (String.to_json f)));
           Some
             ("status_code",
               (ScalingActivityStatusCode.to_json v.status_code));
           Util.option_map v.end_time
             (fun f -> ("end_time", (DateTime.to_json f)));
           Some ("start_time", (DateTime.to_json v.start_time));
           Some ("cause", (String.to_json v.cause));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name));
           Some ("activity_id", (String.to_json v.activity_id))])
    let parse xml =
      Some
        {
          activity_id =
            (Xml.required "ActivityId"
               (Util.option_bind (Xml.member "ActivityId" xml) String.parse));
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          cause =
            (Xml.required "Cause"
               (Util.option_bind (Xml.member "Cause" xml) String.parse));
          start_time =
            (Xml.required "StartTime"
               (Util.option_bind (Xml.member "StartTime" xml) DateTime.parse));
          end_time =
            (Util.option_bind (Xml.member "EndTime" xml) DateTime.parse);
          status_code =
            (Xml.required "StatusCode"
               (Util.option_bind (Xml.member "StatusCode" xml)
                  ScalingActivityStatusCode.parse));
          status_message =
            (Util.option_bind (Xml.member "StatusMessage" xml) String.parse);
          progress =
            (Util.option_bind (Xml.member "Progress" xml) Integer.parse);
          details =
            (Util.option_bind (Xml.member "Details" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((([] @
                    [Some
                       (Ezxmlm.make_tag "ActivityId"
                          ([], (String.to_xml v.activity_id)))])
                   @
                   [Some
                      (Ezxmlm.make_tag "AutoScalingGroupName"
                         ([], (String.to_xml v.auto_scaling_group_name)))])
                  @
                  [Util.option_map v.description
                     (fun f ->
                        Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
                 @
                 [Some
                    (Ezxmlm.make_tag "Cause" ([], (String.to_xml v.cause)))])
                @
                [Some
                   (Ezxmlm.make_tag "StartTime"
                      ([], (DateTime.to_xml v.start_time)))])
               @
               [Util.option_map v.end_time
                  (fun f ->
                     Ezxmlm.make_tag "EndTime" ([], (DateTime.to_xml f)))])
              @
              [Some
                 (Ezxmlm.make_tag "StatusCode"
                    ([], (ScalingActivityStatusCode.to_xml v.status_code)))])
             @
             [Util.option_map v.status_message
                (fun f ->
                   Ezxmlm.make_tag "StatusMessage" ([], (String.to_xml f)))])
            @
            [Util.option_map v.progress
               (fun f -> Ezxmlm.make_tag "Progress" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.details
              (fun f -> Ezxmlm.make_tag "Details" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Describes scaling activity, which is a long-running process that represents a change to your Auto Scaling group, such as changing its size or replacing an instance.</p>"]
module AdjustmentType =
  struct
    type t =
      {
      adjustment_type: String.t option
        [@ocaml.doc
          "<p>The policy adjustment type. The valid values are <code>ChangeInCapacity</code>, <code>ExactCapacity</code>, and <code>PercentChangeInCapacity</code>.</p>"]}
    [@@ocaml.doc "<p>Describes a policy adjustment type.</p>"]
    let make ?adjustment_type  () = { adjustment_type }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.adjustment_type
              (fun f -> ("adjustment_type", (String.to_json f)))])
    let parse xml =
      Some
        {
          adjustment_type =
            (Util.option_bind (Xml.member "AdjustmentType" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.adjustment_type
              (fun f ->
                 Ezxmlm.make_tag "AdjustmentType" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>Describes a policy adjustment type.</p>"]
module AutoScalingGroup =
  struct
    type t =
      {
      auto_scaling_group_name: String.t
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      auto_scaling_group_a_r_n: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the Auto Scaling group.</p>"];
      launch_configuration_name: String.t option
        [@ocaml.doc
          "<p>The name of the associated launch configuration.</p>"];
      launch_template: LaunchTemplateSpecification.t option
        [@ocaml.doc "<p>The launch template for the group.</p>"];
      mixed_instances_policy: MixedInstancesPolicy.t option
        [@ocaml.doc "<p>The mixed instances policy for the group.</p>"];
      min_size: Integer.t
        [@ocaml.doc "<p>The minimum size of the group.</p>"];
      max_size: Integer.t
        [@ocaml.doc "<p>The maximum size of the group.</p>"];
      desired_capacity: Integer.t
        [@ocaml.doc "<p>The desired size of the group.</p>"];
      default_cooldown: Integer.t
        [@ocaml.doc
          "<p>The amount of time, in seconds, after a scaling activity completes before another scaling activity can start.</p>"];
      availability_zones: AvailabilityZones.t
        [@ocaml.doc "<p>One or more Availability Zones for the group.</p>"];
      load_balancer_names: LoadBalancerNames.t
        [@ocaml.doc
          "<p>One or more load balancers associated with the group.</p>"];
      target_group_a_r_ns: TargetGroupARNs.t
        [@ocaml.doc
          "<p>The Amazon Resource Names (ARN) of the target groups for your load balancer.</p>"];
      health_check_type: String.t
        [@ocaml.doc
          "<p>The service to use for the health checks. The valid values are <code>EC2</code> and <code>ELB</code>. If you configure an Auto Scaling group to use ELB health checks, it considers the instance unhealthy if it fails either the EC2 status checks or the load balancer health checks.</p>"];
      health_check_grace_period: Integer.t option
        [@ocaml.doc
          "<p>The amount of time, in seconds, that Amazon EC2 Auto Scaling waits before checking the health status of an EC2 instance that has come into service.</p>"];
      instances: Instances.t
        [@ocaml.doc "<p>The EC2 instances associated with the group.</p>"];
      created_time: DateTime.t
        [@ocaml.doc "<p>The date and time the group was created.</p>"];
      suspended_processes: SuspendedProcesses.t
        [@ocaml.doc
          "<p>The suspended processes associated with the group.</p>"];
      placement_group: String.t option
        [@ocaml.doc
          "<p>The name of the placement group into which to launch your instances, if any.</p>"];
      v_p_c_zone_identifier: String.t option
        [@ocaml.doc
          "<p>One or more subnet IDs, if applicable, separated by commas.</p>"];
      enabled_metrics: EnabledMetrics.t
        [@ocaml.doc "<p>The metrics enabled for the group.</p>"];
      status: String.t option
        [@ocaml.doc
          "<p>The current state of the group when <a>DeleteAutoScalingGroup</a> is in progress.</p>"];
      tags: TagDescriptionList.t
        [@ocaml.doc "<p>The tags for the group.</p>"];
      termination_policies: TerminationPolicies.t
        [@ocaml.doc "<p>The termination policies for the group.</p>"];
      new_instances_protected_from_scale_in: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether newly launched instances are protected from termination by Amazon EC2 Auto Scaling when scaling in.</p>"];
      service_linked_role_a_r_n: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the service-linked role that the Auto Scaling group uses to call other AWS services on your behalf.</p>"];
      max_instance_lifetime: Integer.t option
        [@ocaml.doc
          "<p>The maximum amount of time, in seconds, that an instance can be in service.</p> <p>Valid Range: Minimum value of 604800.</p>"]}
    [@@ocaml.doc "<p>Describes an Auto Scaling group.</p>"]
    let make ~auto_scaling_group_name  ?auto_scaling_group_a_r_n 
      ?launch_configuration_name  ?launch_template  ?mixed_instances_policy 
      ~min_size  ~max_size  ~desired_capacity  ~default_cooldown 
      ~availability_zones  ?(load_balancer_names= [])  ?(target_group_a_r_ns=
      [])  ~health_check_type  ?health_check_grace_period  ?(instances= []) 
      ~created_time  ?(suspended_processes= [])  ?placement_group 
      ?v_p_c_zone_identifier  ?(enabled_metrics= [])  ?status  ?(tags= []) 
      ?(termination_policies= [])  ?new_instances_protected_from_scale_in 
      ?service_linked_role_a_r_n  ?max_instance_lifetime  () =
      {
        auto_scaling_group_name;
        auto_scaling_group_a_r_n;
        launch_configuration_name;
        launch_template;
        mixed_instances_policy;
        min_size;
        max_size;
        desired_capacity;
        default_cooldown;
        availability_zones;
        load_balancer_names;
        target_group_a_r_ns;
        health_check_type;
        health_check_grace_period;
        instances;
        created_time;
        suspended_processes;
        placement_group;
        v_p_c_zone_identifier;
        enabled_metrics;
        status;
        tags;
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
           Some ("tags", (TagDescriptionList.to_json v.tags));
           Util.option_map v.status (fun f -> ("status", (String.to_json f)));
           Some
             ("enabled_metrics", (EnabledMetrics.to_json v.enabled_metrics));
           Util.option_map v.v_p_c_zone_identifier
             (fun f -> ("v_p_c_zone_identifier", (String.to_json f)));
           Util.option_map v.placement_group
             (fun f -> ("placement_group", (String.to_json f)));
           Some
             ("suspended_processes",
               (SuspendedProcesses.to_json v.suspended_processes));
           Some ("created_time", (DateTime.to_json v.created_time));
           Some ("instances", (Instances.to_json v.instances));
           Util.option_map v.health_check_grace_period
             (fun f -> ("health_check_grace_period", (Integer.to_json f)));
           Some ("health_check_type", (String.to_json v.health_check_type));
           Some
             ("target_group_a_r_ns",
               (TargetGroupARNs.to_json v.target_group_a_r_ns));
           Some
             ("load_balancer_names",
               (LoadBalancerNames.to_json v.load_balancer_names));
           Some
             ("availability_zones",
               (AvailabilityZones.to_json v.availability_zones));
           Some ("default_cooldown", (Integer.to_json v.default_cooldown));
           Some ("desired_capacity", (Integer.to_json v.desired_capacity));
           Some ("max_size", (Integer.to_json v.max_size));
           Some ("min_size", (Integer.to_json v.min_size));
           Util.option_map v.mixed_instances_policy
             (fun f ->
                ("mixed_instances_policy", (MixedInstancesPolicy.to_json f)));
           Util.option_map v.launch_template
             (fun f ->
                ("launch_template", (LaunchTemplateSpecification.to_json f)));
           Util.option_map v.launch_configuration_name
             (fun f -> ("launch_configuration_name", (String.to_json f)));
           Util.option_map v.auto_scaling_group_a_r_n
             (fun f -> ("auto_scaling_group_a_r_n", (String.to_json f)));
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
          auto_scaling_group_a_r_n =
            (Util.option_bind (Xml.member "AutoScalingGroupARN" xml)
               String.parse);
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
            (Xml.required "MinSize"
               (Util.option_bind (Xml.member "MinSize" xml) Integer.parse));
          max_size =
            (Xml.required "MaxSize"
               (Util.option_bind (Xml.member "MaxSize" xml) Integer.parse));
          desired_capacity =
            (Xml.required "DesiredCapacity"
               (Util.option_bind (Xml.member "DesiredCapacity" xml)
                  Integer.parse));
          default_cooldown =
            (Xml.required "DefaultCooldown"
               (Util.option_bind (Xml.member "DefaultCooldown" xml)
                  Integer.parse));
          availability_zones =
            (Xml.required "AvailabilityZones"
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
            (Xml.required "HealthCheckType"
               (Util.option_bind (Xml.member "HealthCheckType" xml)
                  String.parse));
          health_check_grace_period =
            (Util.option_bind (Xml.member "HealthCheckGracePeriod" xml)
               Integer.parse);
          instances =
            (Util.of_option []
               (Util.option_bind (Xml.member "Instances" xml) Instances.parse));
          created_time =
            (Xml.required "CreatedTime"
               (Util.option_bind (Xml.member "CreatedTime" xml)
                  DateTime.parse));
          suspended_processes =
            (Util.of_option []
               (Util.option_bind (Xml.member "SuspendedProcesses" xml)
                  SuspendedProcesses.parse));
          placement_group =
            (Util.option_bind (Xml.member "PlacementGroup" xml) String.parse);
          v_p_c_zone_identifier =
            (Util.option_bind (Xml.member "VPCZoneIdentifier" xml)
               String.parse);
          enabled_metrics =
            (Util.of_option []
               (Util.option_bind (Xml.member "EnabledMetrics" xml)
                  EnabledMetrics.parse));
          status = (Util.option_bind (Xml.member "Status" xml) String.parse);
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml)
                  TagDescriptionList.parse));
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
        (((((((((((((((((((((((((([] @
                                    [Some
                                       (Ezxmlm.make_tag
                                          "AutoScalingGroupName"
                                          ([],
                                            (String.to_xml
                                               v.auto_scaling_group_name)))])
                                   @
                                   [Util.option_map
                                      v.auto_scaling_group_a_r_n
                                      (fun f ->
                                         Ezxmlm.make_tag
                                           "AutoScalingGroupARN"
                                           ([], (String.to_xml f)))])
                                  @
                                  [Util.option_map
                                     v.launch_configuration_name
                                     (fun f ->
                                        Ezxmlm.make_tag
                                          "LaunchConfigurationName"
                                          ([], (String.to_xml f)))])
                                 @
                                 [Util.option_map v.launch_template
                                    (fun f ->
                                       Ezxmlm.make_tag "LaunchTemplate"
                                         ([],
                                           (LaunchTemplateSpecification.to_xml
                                              f)))])
                                @
                                [Util.option_map v.mixed_instances_policy
                                   (fun f ->
                                      Ezxmlm.make_tag "MixedInstancesPolicy"
                                        ([], (MixedInstancesPolicy.to_xml f)))])
                               @
                               [Some
                                  (Ezxmlm.make_tag "MinSize"
                                     ([], (Integer.to_xml v.min_size)))])
                              @
                              [Some
                                 (Ezxmlm.make_tag "MaxSize"
                                    ([], (Integer.to_xml v.max_size)))])
                             @
                             [Some
                                (Ezxmlm.make_tag "DesiredCapacity"
                                   ([], (Integer.to_xml v.desired_capacity)))])
                            @
                            [Some
                               (Ezxmlm.make_tag "DefaultCooldown"
                                  ([], (Integer.to_xml v.default_cooldown)))])
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
                        [Some
                           (Ezxmlm.make_tag "HealthCheckType"
                              ([], (String.to_xml v.health_check_type)))])
                       @
                       [Util.option_map v.health_check_grace_period
                          (fun f ->
                             Ezxmlm.make_tag "HealthCheckGracePeriod"
                               ([], (Integer.to_xml f)))])
                      @
                      (List.map
                         (fun x ->
                            Some
                              (Ezxmlm.make_tag "Instances"
                                 ([], (Instances.to_xml [x])))) v.instances))
                     @
                     [Some
                        (Ezxmlm.make_tag "CreatedTime"
                           ([], (DateTime.to_xml v.created_time)))])
                    @
                    (List.map
                       (fun x ->
                          Some
                            (Ezxmlm.make_tag "SuspendedProcesses"
                               ([], (SuspendedProcesses.to_xml [x]))))
                       v.suspended_processes))
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
                         (Ezxmlm.make_tag "EnabledMetrics"
                            ([], (EnabledMetrics.to_xml [x]))))
                    v.enabled_metrics))
                @
                [Util.option_map v.status
                   (fun f -> Ezxmlm.make_tag "Status" ([], (String.to_xml f)))])
               @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "Tags"
                          ([], (TagDescriptionList.to_xml [x])))) v.tags))
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
  end[@@ocaml.doc "<p>Describes an Auto Scaling group.</p>"]
module NotificationConfiguration =
  struct
    type t =
      {
      auto_scaling_group_name: String.t option
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      topic_a_r_n: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the Amazon Simple Notification Service (Amazon SNS) topic.</p>"];
      notification_type: String.t option
        [@ocaml.doc
          "<p>One of the following event notification types:</p> <ul> <li> <p> <code>autoscaling:EC2_INSTANCE_LAUNCH</code> </p> </li> <li> <p> <code>autoscaling:EC2_INSTANCE_LAUNCH_ERROR</code> </p> </li> <li> <p> <code>autoscaling:EC2_INSTANCE_TERMINATE</code> </p> </li> <li> <p> <code>autoscaling:EC2_INSTANCE_TERMINATE_ERROR</code> </p> </li> <li> <p> <code>autoscaling:TEST_NOTIFICATION</code> </p> </li> </ul>"]}
    [@@ocaml.doc "<p>Describes a notification.</p>"]
    let make ?auto_scaling_group_name  ?topic_a_r_n  ?notification_type  () =
      { auto_scaling_group_name; topic_a_r_n; notification_type }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.notification_type
              (fun f -> ("notification_type", (String.to_json f)));
           Util.option_map v.topic_a_r_n
             (fun f -> ("topic_a_r_n", (String.to_json f)));
           Util.option_map v.auto_scaling_group_name
             (fun f -> ("auto_scaling_group_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
               String.parse);
          topic_a_r_n =
            (Util.option_bind (Xml.member "TopicARN" xml) String.parse);
          notification_type =
            (Util.option_bind (Xml.member "NotificationType" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.auto_scaling_group_name
                (fun f ->
                   Ezxmlm.make_tag "AutoScalingGroupName"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.topic_a_r_n
               (fun f -> Ezxmlm.make_tag "TopicARN" ([], (String.to_xml f)))])
           @
           [Util.option_map v.notification_type
              (fun f ->
                 Ezxmlm.make_tag "NotificationType" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>Describes a notification.</p>"]
module LaunchConfiguration =
  struct
    type t =
      {
      launch_configuration_name: String.t
        [@ocaml.doc "<p>The name of the launch configuration.</p>"];
      launch_configuration_a_r_n: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the launch configuration.</p>"];
      image_id: String.t
        [@ocaml.doc
          "<p>The ID of the Amazon Machine Image (AMI) to use to launch your EC2 instances.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html\">Finding an AMI</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.</p>"];
      key_name: String.t option
        [@ocaml.doc
          "<p>The name of the key pair.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html\">Amazon EC2 Key Pairs</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.</p>"];
      security_groups: SecurityGroups.t
        [@ocaml.doc
          "<p>A list that contains the security groups to assign to the instances in the Auto Scaling group.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_SecurityGroups.html\">Security Groups for Your VPC</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>"];
      classic_link_v_p_c_id: String.t option
        [@ocaml.doc
          "<p>The ID of a ClassicLink-enabled VPC to link your EC2-Classic instances to.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/vpc-classiclink.html\">ClassicLink</a> in the <i>Amazon EC2 User Guide for Linux Instances</i> and <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-in-vpc.html#as-ClassicLink\">Linking EC2-Classic Instances to a VPC</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"];
      classic_link_v_p_c_security_groups: ClassicLinkVPCSecurityGroups.t
        [@ocaml.doc
          "<p>The IDs of one or more security groups for the VPC specified in <code>ClassicLinkVPCId</code>.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/vpc-classiclink.html\">ClassicLink</a> in the <i>Amazon EC2 User Guide for Linux Instances</i> and <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-in-vpc.html#as-ClassicLink\">Linking EC2-Classic Instances to a VPC</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"];
      user_data: String.t option
        [@ocaml.doc
          "<p>The Base64-encoded user data to make available to the launched EC2 instances.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html\">Instance Metadata and User Data</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.</p>"];
      instance_type: String.t
        [@ocaml.doc
          "<p>The instance type for the instances.</p> <p>For information about available instance types, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html#AvailableInstanceTypes\">Available Instance Types</a> in the <i>Amazon EC2 User Guide for Linux Instances.</i> </p>"];
      kernel_id: String.t option
        [@ocaml.doc "<p>The ID of the kernel associated with the AMI.</p>"];
      ramdisk_id: String.t option
        [@ocaml.doc "<p>The ID of the RAM disk associated with the AMI.</p>"];
      block_device_mappings: BlockDeviceMappings.t
        [@ocaml.doc
          "<p>A block device mapping, which specifies the block devices for the instance.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/block-device-mapping-concepts.html\">Block Device Mapping</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.</p>"];
      instance_monitoring: InstanceMonitoring.t option
        [@ocaml.doc
          "<p>Controls whether instances in this group are launched with detailed (<code>true</code>) or basic (<code>false</code>) monitoring.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/latest/userguide/as-instance-monitoring.html#enable-as-instance-metrics\">Configure Monitoring for Auto Scaling Instances</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"];
      spot_price: String.t option
        [@ocaml.doc
          "<p>The maximum hourly price to be paid for any Spot Instance launched to fulfill the request. Spot Instances are launched when the price you specify exceeds the current Spot price.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-launch-spot-instances.html\">Launching Spot Instances in Your Auto Scaling Group</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"];
      iam_instance_profile: String.t option
        [@ocaml.doc
          "<p>The name or the Amazon Resource Name (ARN) of the instance profile associated with the IAM role for the instance. The instance profile contains the IAM role.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/us-iam-role.html\">IAM Role for Applications That Run on Amazon EC2 Instances</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"];
      created_time: DateTime.t
        [@ocaml.doc
          "<p>The creation date and time for the launch configuration.</p>"];
      ebs_optimized: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the launch configuration is optimized for EBS I/O (<code>true</code>) or not (<code>false</code>).</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSOptimized.html\">Amazon EBS-Optimized Instances</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.</p>"];
      associate_public_ip_address: Boolean.t option
        [@ocaml.doc
          "<p>For Auto Scaling groups that are running in a VPC, specifies whether to assign a public IP address to the group's instances.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-in-vpc.html\">Launching Auto Scaling Instances in a VPC</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"];
      placement_tenancy: String.t option
        [@ocaml.doc
          "<p>The tenancy of the instance, either <code>default</code> or <code>dedicated</code>. An instance with <code>dedicated</code> tenancy runs on isolated, single-tenant hardware and can only be launched into a VPC.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-in-vpc.html#as-vpc-tenancy\">Instance Placement Tenancy</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"]}
    [@@ocaml.doc "<p>Describes a launch configuration.</p>"]
    let make ~launch_configuration_name  ?launch_configuration_a_r_n 
      ~image_id  ?key_name  ?(security_groups= [])  ?classic_link_v_p_c_id 
      ?(classic_link_v_p_c_security_groups= [])  ?user_data  ~instance_type 
      ?kernel_id  ?ramdisk_id  ?(block_device_mappings= []) 
      ?instance_monitoring  ?spot_price  ?iam_instance_profile  ~created_time
       ?ebs_optimized  ?associate_public_ip_address  ?placement_tenancy  () =
      {
        launch_configuration_name;
        launch_configuration_a_r_n;
        image_id;
        key_name;
        security_groups;
        classic_link_v_p_c_id;
        classic_link_v_p_c_security_groups;
        user_data;
        instance_type;
        kernel_id;
        ramdisk_id;
        block_device_mappings;
        instance_monitoring;
        spot_price;
        iam_instance_profile;
        created_time;
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
           Some ("created_time", (DateTime.to_json v.created_time));
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
           Some ("instance_type", (String.to_json v.instance_type));
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
           Some ("image_id", (String.to_json v.image_id));
           Util.option_map v.launch_configuration_a_r_n
             (fun f -> ("launch_configuration_a_r_n", (String.to_json f)));
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
          launch_configuration_a_r_n =
            (Util.option_bind (Xml.member "LaunchConfigurationARN" xml)
               String.parse);
          image_id =
            (Xml.required "ImageId"
               (Util.option_bind (Xml.member "ImageId" xml) String.parse));
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
          instance_type =
            (Xml.required "InstanceType"
               (Util.option_bind (Xml.member "InstanceType" xml) String.parse));
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
          created_time =
            (Xml.required "CreatedTime"
               (Util.option_bind (Xml.member "CreatedTime" xml)
                  DateTime.parse));
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
        ((((((((((((((((((([] @
                             [Some
                                (Ezxmlm.make_tag "LaunchConfigurationName"
                                   ([],
                                     (String.to_xml
                                        v.launch_configuration_name)))])
                            @
                            [Util.option_map v.launch_configuration_a_r_n
                               (fun f ->
                                  Ezxmlm.make_tag "LaunchConfigurationARN"
                                    ([], (String.to_xml f)))])
                           @
                           [Some
                              (Ezxmlm.make_tag "ImageId"
                                 ([], (String.to_xml v.image_id)))])
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
                     [Some
                        (Ezxmlm.make_tag "InstanceType"
                           ([], (String.to_xml v.instance_type)))])
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
              [Some
                 (Ezxmlm.make_tag "CreatedTime"
                    ([], (DateTime.to_xml v.created_time)))])
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
  end[@@ocaml.doc "<p>Describes a launch configuration.</p>"]
module ScheduledUpdateGroupAction =
  struct
    type t =
      {
      auto_scaling_group_name: String.t option
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      scheduled_action_name: String.t option
        [@ocaml.doc "<p>The name of the scheduled action.</p>"];
      scheduled_action_a_r_n: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the scheduled action.</p>"];
      time: DateTime.t option
        [@ocaml.doc "<p>This parameter is no longer used.</p>"];
      start_time: DateTime.t option
        [@ocaml.doc
          "<p>The date and time in UTC for this action to start. For example, <code>\"2019-06-01T00:00:00Z\"</code>. </p>"];
      end_time: DateTime.t option
        [@ocaml.doc
          "<p>The date and time in UTC for the recurring schedule to end. For example, <code>\"2019-06-01T00:00:00Z\"</code>. </p>"];
      recurrence: String.t option
        [@ocaml.doc
          "<p>The recurring schedule for the action, in Unix cron syntax format.</p> <p>When <code>StartTime</code> and <code>EndTime</code> are specified with <code>Recurrence</code>, they form the boundaries of when the recurring action starts and stops.</p>"];
      min_size: Integer.t option
        [@ocaml.doc
          "<p>The minimum number of instances in the Auto Scaling group.</p>"];
      max_size: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of instances in the Auto Scaling group.</p>"];
      desired_capacity: Integer.t option
        [@ocaml.doc
          "<p>The number of instances you prefer to maintain in the group.</p>"]}
    [@@ocaml.doc
      "<p>Describes a scheduled scaling action. Used in response to <a>DescribeScheduledActions</a>.</p>"]
    let make ?auto_scaling_group_name  ?scheduled_action_name 
      ?scheduled_action_a_r_n  ?time  ?start_time  ?end_time  ?recurrence 
      ?min_size  ?max_size  ?desired_capacity  () =
      {
        auto_scaling_group_name;
        scheduled_action_name;
        scheduled_action_a_r_n;
        time;
        start_time;
        end_time;
        recurrence;
        min_size;
        max_size;
        desired_capacity
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.desired_capacity
              (fun f -> ("desired_capacity", (Integer.to_json f)));
           Util.option_map v.max_size
             (fun f -> ("max_size", (Integer.to_json f)));
           Util.option_map v.min_size
             (fun f -> ("min_size", (Integer.to_json f)));
           Util.option_map v.recurrence
             (fun f -> ("recurrence", (String.to_json f)));
           Util.option_map v.end_time
             (fun f -> ("end_time", (DateTime.to_json f)));
           Util.option_map v.start_time
             (fun f -> ("start_time", (DateTime.to_json f)));
           Util.option_map v.time (fun f -> ("time", (DateTime.to_json f)));
           Util.option_map v.scheduled_action_a_r_n
             (fun f -> ("scheduled_action_a_r_n", (String.to_json f)));
           Util.option_map v.scheduled_action_name
             (fun f -> ("scheduled_action_name", (String.to_json f)));
           Util.option_map v.auto_scaling_group_name
             (fun f -> ("auto_scaling_group_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
               String.parse);
          scheduled_action_name =
            (Util.option_bind (Xml.member "ScheduledActionName" xml)
               String.parse);
          scheduled_action_a_r_n =
            (Util.option_bind (Xml.member "ScheduledActionARN" xml)
               String.parse);
          time = (Util.option_bind (Xml.member "Time" xml) DateTime.parse);
          start_time =
            (Util.option_bind (Xml.member "StartTime" xml) DateTime.parse);
          end_time =
            (Util.option_bind (Xml.member "EndTime" xml) DateTime.parse);
          recurrence =
            (Util.option_bind (Xml.member "Recurrence" xml) String.parse);
          min_size =
            (Util.option_bind (Xml.member "MinSize" xml) Integer.parse);
          max_size =
            (Util.option_bind (Xml.member "MaxSize" xml) Integer.parse);
          desired_capacity =
            (Util.option_bind (Xml.member "DesiredCapacity" xml)
               Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((([] @
                    [Util.option_map v.auto_scaling_group_name
                       (fun f ->
                          Ezxmlm.make_tag "AutoScalingGroupName"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.scheduled_action_name
                      (fun f ->
                         Ezxmlm.make_tag "ScheduledActionName"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.scheduled_action_a_r_n
                     (fun f ->
                        Ezxmlm.make_tag "ScheduledActionARN"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.time
                    (fun f ->
                       Ezxmlm.make_tag "Time" ([], (DateTime.to_xml f)))])
                @
                [Util.option_map v.start_time
                   (fun f ->
                      Ezxmlm.make_tag "StartTime" ([], (DateTime.to_xml f)))])
               @
               [Util.option_map v.end_time
                  (fun f ->
                     Ezxmlm.make_tag "EndTime" ([], (DateTime.to_xml f)))])
              @
              [Util.option_map v.recurrence
                 (fun f ->
                    Ezxmlm.make_tag "Recurrence" ([], (String.to_xml f)))])
             @
             [Util.option_map v.min_size
                (fun f -> Ezxmlm.make_tag "MinSize" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.max_size
               (fun f -> Ezxmlm.make_tag "MaxSize" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.desired_capacity
              (fun f ->
                 Ezxmlm.make_tag "DesiredCapacity" ([], (Integer.to_xml f)))])
  end[@@ocaml.doc
       "<p>Describes a scheduled scaling action. Used in response to <a>DescribeScheduledActions</a>.</p>"]
module ScheduledUpdateGroupActionRequest =
  struct
    type t =
      {
      scheduled_action_name: String.t
        [@ocaml.doc "<p>The name of the scaling action.</p>"];
      start_time: DateTime.t option
        [@ocaml.doc
          "<p>The date and time for the action to start, in YYYY-MM-DDThh:mm:ssZ format in UTC/GMT only and in quotes (for example, <code>\"2019-06-01T00:00:00Z\"</code>).</p> <p>If you specify <code>Recurrence</code> and <code>StartTime</code>, Amazon EC2 Auto Scaling performs the action at this time, and then performs the action based on the specified recurrence.</p> <p>If you try to schedule the action in the past, Amazon EC2 Auto Scaling returns an error message.</p>"];
      end_time: DateTime.t option
        [@ocaml.doc
          "<p>The date and time for the recurring schedule to end. Amazon EC2 Auto Scaling does not perform the action after this time.</p>"];
      recurrence: String.t option
        [@ocaml.doc
          "<p>The recurring schedule for the action, in Unix cron syntax format. This format consists of five fields separated by white spaces: [Minute] [Hour] [Day_of_Month] [Month_of_Year] [Day_of_Week]. The value must be in quotes (for example, <code>\"30 0 1 1,6,12 *\"</code>). For more information about this format, see <a href=\"http://crontab.org\">Crontab</a>.</p> <p>When <code>StartTime</code> and <code>EndTime</code> are specified with <code>Recurrence</code>, they form the boundaries of when the recurring action starts and stops.</p>"];
      min_size: Integer.t option
        [@ocaml.doc
          "<p>The minimum number of instances in the Auto Scaling group.</p>"];
      max_size: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of instances in the Auto Scaling group.</p>"];
      desired_capacity: Integer.t option
        [@ocaml.doc
          "<p>The number of EC2 instances that should be running in the group.</p>"]}
    [@@ocaml.doc
      "<p>Describes one or more scheduled scaling action updates for a specified Auto Scaling group. Used in combination with <a>BatchPutScheduledUpdateGroupAction</a>.</p> <p>When updating a scheduled scaling action, all optional parameters are left unchanged if not specified.</p>"]
    let make ~scheduled_action_name  ?start_time  ?end_time  ?recurrence 
      ?min_size  ?max_size  ?desired_capacity  () =
      {
        scheduled_action_name;
        start_time;
        end_time;
        recurrence;
        min_size;
        max_size;
        desired_capacity
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.desired_capacity
              (fun f -> ("desired_capacity", (Integer.to_json f)));
           Util.option_map v.max_size
             (fun f -> ("max_size", (Integer.to_json f)));
           Util.option_map v.min_size
             (fun f -> ("min_size", (Integer.to_json f)));
           Util.option_map v.recurrence
             (fun f -> ("recurrence", (String.to_json f)));
           Util.option_map v.end_time
             (fun f -> ("end_time", (DateTime.to_json f)));
           Util.option_map v.start_time
             (fun f -> ("start_time", (DateTime.to_json f)));
           Some
             ("scheduled_action_name",
               (String.to_json v.scheduled_action_name))])
    let parse xml =
      Some
        {
          scheduled_action_name =
            (Xml.required "ScheduledActionName"
               (Util.option_bind (Xml.member "ScheduledActionName" xml)
                  String.parse));
          start_time =
            (Util.option_bind (Xml.member "StartTime" xml) DateTime.parse);
          end_time =
            (Util.option_bind (Xml.member "EndTime" xml) DateTime.parse);
          recurrence =
            (Util.option_bind (Xml.member "Recurrence" xml) String.parse);
          min_size =
            (Util.option_bind (Xml.member "MinSize" xml) Integer.parse);
          max_size =
            (Util.option_bind (Xml.member "MaxSize" xml) Integer.parse);
          desired_capacity =
            (Util.option_bind (Xml.member "DesiredCapacity" xml)
               Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Some
                    (Ezxmlm.make_tag "ScheduledActionName"
                       ([], (String.to_xml v.scheduled_action_name)))])
                @
                [Util.option_map v.start_time
                   (fun f ->
                      Ezxmlm.make_tag "StartTime" ([], (DateTime.to_xml f)))])
               @
               [Util.option_map v.end_time
                  (fun f ->
                     Ezxmlm.make_tag "EndTime" ([], (DateTime.to_xml f)))])
              @
              [Util.option_map v.recurrence
                 (fun f ->
                    Ezxmlm.make_tag "Recurrence" ([], (String.to_xml f)))])
             @
             [Util.option_map v.min_size
                (fun f -> Ezxmlm.make_tag "MinSize" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.max_size
               (fun f -> Ezxmlm.make_tag "MaxSize" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.desired_capacity
              (fun f ->
                 Ezxmlm.make_tag "DesiredCapacity" ([], (Integer.to_xml f)))])
  end[@@ocaml.doc
       "<p>Describes one or more scheduled scaling action updates for a specified Auto Scaling group. Used in combination with <a>BatchPutScheduledUpdateGroupAction</a>.</p> <p>When updating a scheduled scaling action, all optional parameters are left unchanged if not specified.</p>"]
module LoadBalancerState =
  struct
    type t =
      {
      load_balancer_name: String.t option
        [@ocaml.doc "<p>The name of the load balancer.</p>"];
      state: String.t option
        [@ocaml.doc
          "<p>One of the following load balancer states:</p> <ul> <li> <p> <code>Adding</code> - The instances in the group are being registered with the load balancer.</p> </li> <li> <p> <code>Added</code> - All instances in the group are registered with the load balancer.</p> </li> <li> <p> <code>InService</code> - At least one instance in the group passed an ELB health check.</p> </li> <li> <p> <code>Removing</code> - The instances in the group are being deregistered from the load balancer. If connection draining is enabled, Elastic Load Balancing waits for in-flight requests to complete before deregistering the instances.</p> </li> <li> <p> <code>Removed</code> - All instances in the group are deregistered from the load balancer.</p> </li> </ul>"]}
    [@@ocaml.doc
      "<p>Describes the state of a Classic Load Balancer.</p> <p>If you specify a load balancer when creating the Auto Scaling group, the state of the load balancer is <code>InService</code>.</p> <p>If you attach a load balancer to an existing Auto Scaling group, the initial state is <code>Adding</code>. The state transitions to <code>Added</code> after all instances in the group are registered with the load balancer. If Elastic Load Balancing health checks are enabled for the load balancer, the state transitions to <code>InService</code> after at least one instance in the group passes the health check. If EC2 health checks are enabled instead, the load balancer remains in the <code>Added</code> state.</p>"]
    let make ?load_balancer_name  ?state  () = { load_balancer_name; state }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.state (fun f -> ("state", (String.to_json f)));
           Util.option_map v.load_balancer_name
             (fun f -> ("load_balancer_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          load_balancer_name =
            (Util.option_bind (Xml.member "LoadBalancerName" xml)
               String.parse);
          state = (Util.option_bind (Xml.member "State" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.load_balancer_name
               (fun f ->
                  Ezxmlm.make_tag "LoadBalancerName" ([], (String.to_xml f)))])
           @
           [Util.option_map v.state
              (fun f -> Ezxmlm.make_tag "State" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Describes the state of a Classic Load Balancer.</p> <p>If you specify a load balancer when creating the Auto Scaling group, the state of the load balancer is <code>InService</code>.</p> <p>If you attach a load balancer to an existing Auto Scaling group, the initial state is <code>Adding</code>. The state transitions to <code>Added</code> after all instances in the group are registered with the load balancer. If Elastic Load Balancing health checks are enabled for the load balancer, the state transitions to <code>InService</code> after at least one instance in the group passes the health check. If EC2 health checks are enabled instead, the load balancer remains in the <code>Added</code> state.</p>"]
module MetricCollectionType =
  struct
    type t =
      {
      metric: String.t option
        [@ocaml.doc
          "<p>One of the following metrics:</p> <ul> <li> <p> <code>GroupMinSize</code> </p> </li> <li> <p> <code>GroupMaxSize</code> </p> </li> <li> <p> <code>GroupDesiredCapacity</code> </p> </li> <li> <p> <code>GroupInServiceInstances</code> </p> </li> <li> <p> <code>GroupPendingInstances</code> </p> </li> <li> <p> <code>GroupStandbyInstances</code> </p> </li> <li> <p> <code>GroupTerminatingInstances</code> </p> </li> <li> <p> <code>GroupTotalInstances</code> </p> </li> </ul>"]}
    [@@ocaml.doc "<p>Describes a metric.</p>"]
    let make ?metric  () = { metric }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.metric
              (fun f -> ("metric", (String.to_json f)))])
    let parse xml =
      Some
        { metric = (Util.option_bind (Xml.member "Metric" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.metric
              (fun f -> Ezxmlm.make_tag "Metric" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>Describes a metric.</p>"]
module MetricGranularityType =
  struct
    type t =
      {
      granularity: String.t option
        [@ocaml.doc
          "<p>The granularity. The only valid value is <code>1Minute</code>.</p>"]}
    [@@ocaml.doc "<p>Describes a granularity of a metric.</p>"]
    let make ?granularity  () = { granularity }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.granularity
              (fun f -> ("granularity", (String.to_json f)))])
    let parse xml =
      Some
        {
          granularity =
            (Util.option_bind (Xml.member "Granularity" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.granularity
              (fun f -> Ezxmlm.make_tag "Granularity" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>Describes a granularity of a metric.</p>"]
module ProcessType =
  struct
    type t =
      {
      process_name: String.t
        [@ocaml.doc
          "<p>One of the following processes:</p> <ul> <li> <p> <code>Launch</code> </p> </li> <li> <p> <code>Terminate</code> </p> </li> <li> <p> <code>AddToLoadBalancer</code> </p> </li> <li> <p> <code>AlarmNotification</code> </p> </li> <li> <p> <code>AZRebalance</code> </p> </li> <li> <p> <code>HealthCheck</code> </p> </li> <li> <p> <code>ReplaceUnhealthy</code> </p> </li> <li> <p> <code>ScheduledActions</code> </p> </li> </ul>"]}
    [@@ocaml.doc
      "<p>Describes a process type.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-suspend-resume-processes.html#process-types\">Scaling Processes</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"]
    let make ~process_name  () = { process_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("process_name", (String.to_json v.process_name))])
    let parse xml =
      Some
        {
          process_name =
            (Xml.required "ProcessName"
               (Util.option_bind (Xml.member "ProcessName" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "ProcessName"
                 ([], (String.to_xml v.process_name)))])
  end[@@ocaml.doc
       "<p>Describes a process type.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-suspend-resume-processes.html#process-types\">Scaling Processes</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"]
module InstanceIds =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module Filters =
  struct
    type t = Filter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Filter.to_query v
    let to_headers v = Headers.to_headers_list Filter.to_headers v
    let to_json v = `List (List.map Filter.to_json v)
    let parse xml =
      Util.option_all (List.map Filter.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Filter.to_xml x))) v
  end
module ProcessNames =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module AutoScalingInstances =
  struct
    type t = AutoScalingInstanceDetails.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list AutoScalingInstanceDetails.to_query v
    let to_headers v =
      Headers.to_headers_list AutoScalingInstanceDetails.to_headers v
    let to_json v = `List (List.map AutoScalingInstanceDetails.to_json v)
    let parse xml =
      Util.option_all
        (List.map AutoScalingInstanceDetails.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (AutoScalingInstanceDetails.to_xml x))) v
  end
module AutoScalingNotificationTypes =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module FailedScheduledUpdateGroupActionRequests =
  struct
    type t = FailedScheduledUpdateGroupActionRequest.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list FailedScheduledUpdateGroupActionRequest.to_query v
    let to_headers v =
      Headers.to_headers_list
        FailedScheduledUpdateGroupActionRequest.to_headers v
    let to_json v =
      `List (List.map FailedScheduledUpdateGroupActionRequest.to_json v)
    let parse xml =
      Util.option_all
        (List.map FailedScheduledUpdateGroupActionRequest.parse
           (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (FailedScheduledUpdateGroupActionRequest.to_xml x))) v
  end
module ScalingPolicies =
  struct
    type t = ScalingPolicy.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ScalingPolicy.to_query v
    let to_headers v = Headers.to_headers_list ScalingPolicy.to_headers v
    let to_json v = `List (List.map ScalingPolicy.to_json v)
    let parse xml =
      Util.option_all
        (List.map ScalingPolicy.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (ScalingPolicy.to_xml x))) v
  end
module LifecycleHookSpecifications =
  struct
    type t = LifecycleHookSpecification.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list LifecycleHookSpecification.to_query v
    let to_headers v =
      Headers.to_headers_list LifecycleHookSpecification.to_headers v
    let to_json v = `List (List.map LifecycleHookSpecification.to_json v)
    let parse xml =
      Util.option_all
        (List.map LifecycleHookSpecification.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (LifecycleHookSpecification.to_xml x))) v
  end
module Tags =
  struct
    type t = Tag.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Tag.to_query v
    let to_headers v = Headers.to_headers_list Tag.to_headers v
    let to_json v = `List (List.map Tag.to_json v)
    let parse xml =
      Util.option_all (List.map Tag.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Tag.to_xml x))) v
  end
module ActivityIds =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module LifecycleHooks =
  struct
    type t = LifecycleHook.t list
    let make elems () = elems
    let to_query v = Query.to_query_list LifecycleHook.to_query v
    let to_headers v = Headers.to_headers_list LifecycleHook.to_headers v
    let to_json v = `List (List.map LifecycleHook.to_json v)
    let parse xml =
      Util.option_all
        (List.map LifecycleHook.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (LifecycleHook.to_xml x))) v
  end
module LoadBalancerTargetGroupStates =
  struct
    type t = LoadBalancerTargetGroupState.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list LoadBalancerTargetGroupState.to_query v
    let to_headers v =
      Headers.to_headers_list LoadBalancerTargetGroupState.to_headers v
    let to_json v = `List (List.map LoadBalancerTargetGroupState.to_json v)
    let parse xml =
      Util.option_all
        (List.map LoadBalancerTargetGroupState.parse
           (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (LoadBalancerTargetGroupState.to_xml x))) v
  end
module Activities =
  struct
    type t = Activity.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Activity.to_query v
    let to_headers v = Headers.to_headers_list Activity.to_headers v
    let to_json v = `List (List.map Activity.to_json v)
    let parse xml =
      Util.option_all (List.map Activity.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Activity.to_xml x)))
        v
  end
module LaunchConfigurationNames =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module AdjustmentTypes =
  struct
    type t = AdjustmentType.t list
    let make elems () = elems
    let to_query v = Query.to_query_list AdjustmentType.to_query v
    let to_headers v = Headers.to_headers_list AdjustmentType.to_headers v
    let to_json v = `List (List.map AdjustmentType.to_json v)
    let parse xml =
      Util.option_all
        (List.map AdjustmentType.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (AdjustmentType.to_xml x))) v
  end
module AutoScalingGroups =
  struct
    type t = AutoScalingGroup.t list
    let make elems () = elems
    let to_query v = Query.to_query_list AutoScalingGroup.to_query v
    let to_headers v = Headers.to_headers_list AutoScalingGroup.to_headers v
    let to_json v = `List (List.map AutoScalingGroup.to_json v)
    let parse xml =
      Util.option_all
        (List.map AutoScalingGroup.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (AutoScalingGroup.to_xml x)))
        v
  end
module ScheduledActionNames =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module Metrics =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module PolicyNames =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module PolicyTypes =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module NotificationConfigurations =
  struct
    type t = NotificationConfiguration.t list
    let make elems () = elems
    let to_query v = Query.to_query_list NotificationConfiguration.to_query v
    let to_headers v =
      Headers.to_headers_list NotificationConfiguration.to_headers v
    let to_json v = `List (List.map NotificationConfiguration.to_json v)
    let parse xml =
      Util.option_all
        (List.map NotificationConfiguration.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (NotificationConfiguration.to_xml x))) v
  end
module AutoScalingGroupNames =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module LaunchConfigurations =
  struct
    type t = LaunchConfiguration.t list
    let make elems () = elems
    let to_query v = Query.to_query_list LaunchConfiguration.to_query v
    let to_headers v =
      Headers.to_headers_list LaunchConfiguration.to_headers v
    let to_json v = `List (List.map LaunchConfiguration.to_json v)
    let parse xml =
      Util.option_all
        (List.map LaunchConfiguration.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (LaunchConfiguration.to_xml x))) v
  end
module ScheduledUpdateGroupActions =
  struct
    type t = ScheduledUpdateGroupAction.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list ScheduledUpdateGroupAction.to_query v
    let to_headers v =
      Headers.to_headers_list ScheduledUpdateGroupAction.to_headers v
    let to_json v = `List (List.map ScheduledUpdateGroupAction.to_json v)
    let parse xml =
      Util.option_all
        (List.map ScheduledUpdateGroupAction.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (ScheduledUpdateGroupAction.to_xml x))) v
  end
module ScheduledUpdateGroupActionRequests =
  struct
    type t = ScheduledUpdateGroupActionRequest.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list ScheduledUpdateGroupActionRequest.to_query v
    let to_headers v =
      Headers.to_headers_list ScheduledUpdateGroupActionRequest.to_headers v
    let to_json v =
      `List (List.map ScheduledUpdateGroupActionRequest.to_json v)
    let parse xml =
      Util.option_all
        (List.map ScheduledUpdateGroupActionRequest.parse
           (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (ScheduledUpdateGroupActionRequest.to_xml x))) v
  end
module LoadBalancerStates =
  struct
    type t = LoadBalancerState.t list
    let make elems () = elems
    let to_query v = Query.to_query_list LoadBalancerState.to_query v
    let to_headers v = Headers.to_headers_list LoadBalancerState.to_headers v
    let to_json v = `List (List.map LoadBalancerState.to_json v)
    let parse xml =
      Util.option_all
        (List.map LoadBalancerState.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (LoadBalancerState.to_xml x)))
        v
  end
module MetricCollectionTypes =
  struct
    type t = MetricCollectionType.t list
    let make elems () = elems
    let to_query v = Query.to_query_list MetricCollectionType.to_query v
    let to_headers v =
      Headers.to_headers_list MetricCollectionType.to_headers v
    let to_json v = `List (List.map MetricCollectionType.to_json v)
    let parse xml =
      Util.option_all
        (List.map MetricCollectionType.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (MetricCollectionType.to_xml x))) v
  end
module MetricGranularityTypes =
  struct
    type t = MetricGranularityType.t list
    let make elems () = elems
    let to_query v = Query.to_query_list MetricGranularityType.to_query v
    let to_headers v =
      Headers.to_headers_list MetricGranularityType.to_headers v
    let to_json v = `List (List.map MetricGranularityType.to_json v)
    let parse xml =
      Util.option_all
        (List.map MetricGranularityType.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (MetricGranularityType.to_xml x))) v
  end
module LifecycleHookNames =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module Processes =
  struct
    type t = ProcessType.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ProcessType.to_query v
    let to_headers v = Headers.to_headers_list ProcessType.to_headers v
    let to_json v = `List (List.map ProcessType.to_json v)
    let parse xml =
      Util.option_all (List.map ProcessType.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (ProcessType.to_xml x))) v
  end
module RecordLifecycleActionHeartbeatAnswer =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end
module ActivityType =
  struct
    type t =
      {
      activity: Activity.t option [@ocaml.doc "<p>A scaling activity.</p>"]}
    let make ?activity  () = { activity }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.activity
              (fun f -> ("activity", (Activity.to_json f)))])
    let parse xml =
      Some
        {
          activity =
            (Util.option_bind (Xml.member "Activity" xml) Activity.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.activity
              (fun f -> Ezxmlm.make_tag "Activity" ([], (Activity.to_xml f)))])
  end
module AttachLoadBalancerTargetGroupsResultType =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end
module PutLifecycleHookAnswer =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end
module SetInstanceProtectionAnswer =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end
module DetachLoadBalancerTargetGroupsResultType =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end
module AutoScalingInstancesType =
  struct
    type t =
      {
      auto_scaling_instances: AutoScalingInstances.t
        [@ocaml.doc "<p>The instances.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>A string that indicates that the response contains more items than can be returned in a single response. To receive additional items, specify this string for the <code>NextToken</code> value when requesting the next set of items. This value is null when there are no more items to return.</p>"]}
    let make ?(auto_scaling_instances= [])  ?next_token  () =
      { auto_scaling_instances; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("auto_scaling_instances",
               (AutoScalingInstances.to_json v.auto_scaling_instances))])
    let parse xml =
      Some
        {
          auto_scaling_instances =
            (Util.of_option []
               (Util.option_bind (Xml.member "AutoScalingInstances" xml)
                  AutoScalingInstances.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "AutoScalingInstances"
                       ([], (AutoScalingInstances.to_xml [x]))))
               v.auto_scaling_instances))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module BatchPutScheduledUpdateGroupActionAnswer =
  struct
    type t =
      {
      failed_scheduled_update_group_actions:
        FailedScheduledUpdateGroupActionRequests.t
        [@ocaml.doc
          "<p>The names of the scheduled actions that could not be created or updated, including an error message.</p>"]}
    let make ?(failed_scheduled_update_group_actions= [])  () =
      { failed_scheduled_update_group_actions }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("failed_scheduled_update_group_actions",
                (FailedScheduledUpdateGroupActionRequests.to_json
                   v.failed_scheduled_update_group_actions))])
    let parse xml =
      Some
        {
          failed_scheduled_update_group_actions =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "FailedScheduledUpdateGroupActions" xml)
                  FailedScheduledUpdateGroupActionRequests.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "FailedScheduledUpdateGroupActions"
                      ([],
                        (FailedScheduledUpdateGroupActionRequests.to_xml [x]))))
              v.failed_scheduled_update_group_actions))
  end
module PoliciesType =
  struct
    type t =
      {
      scaling_policies: ScalingPolicies.t
        [@ocaml.doc "<p>The scaling policies.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>A string that indicates that the response contains more items than can be returned in a single response. To receive additional items, specify this string for the <code>NextToken</code> value when requesting the next set of items. This value is null when there are no more items to return.</p>"]}
    let make ?(scaling_policies= [])  ?next_token  () =
      { scaling_policies; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("scaling_policies",
               (ScalingPolicies.to_json v.scaling_policies))])
    let parse xml =
      Some
        {
          scaling_policies =
            (Util.of_option []
               (Util.option_bind (Xml.member "ScalingPolicies" xml)
                  ScalingPolicies.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "ScalingPolicies"
                       ([], (ScalingPolicies.to_xml [x]))))
               v.scaling_policies))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module TagsType =
  struct
    type t =
      {
      tags: TagDescriptionList.t [@ocaml.doc "<p>One or more tags.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>A string that indicates that the response contains more items than can be returned in a single response. To receive additional items, specify this string for the <code>NextToken</code> value when requesting the next set of items. This value is null when there are no more items to return.</p>"]}
    let make ?(tags= [])  ?next_token  () = { tags; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("tags", (TagDescriptionList.to_json v.tags))])
    let parse xml =
      Some
        {
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml)
                  TagDescriptionList.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Tags"
                       ([], (TagDescriptionList.to_xml [x])))) v.tags))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module AttachLoadBalancersResultType =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end
module DescribeLifecycleHooksAnswer =
  struct
    type t =
      {
      lifecycle_hooks: LifecycleHooks.t
        [@ocaml.doc "<p>The lifecycle hooks for the specified group.</p>"]}
    let make ?(lifecycle_hooks= [])  () = { lifecycle_hooks }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("lifecycle_hooks", (LifecycleHooks.to_json v.lifecycle_hooks))])
    let parse xml =
      Some
        {
          lifecycle_hooks =
            (Util.of_option []
               (Util.option_bind (Xml.member "LifecycleHooks" xml)
                  LifecycleHooks.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "LifecycleHooks"
                      ([], (LifecycleHooks.to_xml [x])))) v.lifecycle_hooks))
  end
module DescribeLoadBalancerTargetGroupsResponse =
  struct
    type t =
      {
      load_balancer_target_groups: LoadBalancerTargetGroupStates.t
        [@ocaml.doc "<p>Information about the target groups.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>A string that indicates that the response contains more items than can be returned in a single response. To receive additional items, specify this string for the <code>NextToken</code> value when requesting the next set of items. This value is null when there are no more items to return.</p>"]}
    let make ?(load_balancer_target_groups= [])  ?next_token  () =
      { load_balancer_target_groups; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("load_balancer_target_groups",
               (LoadBalancerTargetGroupStates.to_json
                  v.load_balancer_target_groups))])
    let parse xml =
      Some
        {
          load_balancer_target_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "LoadBalancerTargetGroups" xml)
                  LoadBalancerTargetGroupStates.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "LoadBalancerTargetGroups"
                       ([], (LoadBalancerTargetGroupStates.to_xml [x]))))
               v.load_balancer_target_groups))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module DetachInstancesAnswer =
  struct
    type t =
      {
      activities: Activities.t
        [@ocaml.doc
          "<p>The activities related to detaching the instances from the Auto Scaling group.</p>"]}
    let make ?(activities= [])  () = { activities }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("activities", (Activities.to_json v.activities))])
    let parse xml =
      Some
        {
          activities =
            (Util.of_option []
               (Util.option_bind (Xml.member "Activities" xml)
                  Activities.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Activities"
                      ([], (Activities.to_xml [x])))) v.activities))
  end
module DetachLoadBalancersResultType =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end
module DescribeLifecycleHookTypesAnswer =
  struct
    type t =
      {
      lifecycle_hook_types: AutoScalingNotificationTypes.t
        [@ocaml.doc "<p>The lifecycle hook types.</p>"]}
    let make ?(lifecycle_hook_types= [])  () = { lifecycle_hook_types }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("lifecycle_hook_types",
                (AutoScalingNotificationTypes.to_json v.lifecycle_hook_types))])
    let parse xml =
      Some
        {
          lifecycle_hook_types =
            (Util.of_option []
               (Util.option_bind (Xml.member "LifecycleHookTypes" xml)
                  AutoScalingNotificationTypes.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "LifecycleHookTypes"
                      ([], (AutoScalingNotificationTypes.to_xml [x]))))
              v.lifecycle_hook_types))
  end
module DescribeAccountLimitsAnswer =
  struct
    type t =
      {
      max_number_of_auto_scaling_groups: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of groups allowed for your AWS account. The default limit is 200 per AWS Region.</p>"];
      max_number_of_launch_configurations: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of launch configurations allowed for your AWS account. The default limit is 200 per AWS Region.</p>"];
      number_of_auto_scaling_groups: Integer.t option
        [@ocaml.doc
          "<p>The current number of groups for your AWS account.</p>"];
      number_of_launch_configurations: Integer.t option
        [@ocaml.doc
          "<p>The current number of launch configurations for your AWS account.</p>"]}
    let make ?max_number_of_auto_scaling_groups 
      ?max_number_of_launch_configurations  ?number_of_auto_scaling_groups 
      ?number_of_launch_configurations  () =
      {
        max_number_of_auto_scaling_groups;
        max_number_of_launch_configurations;
        number_of_auto_scaling_groups;
        number_of_launch_configurations
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.number_of_launch_configurations
              (fun f ->
                 ("number_of_launch_configurations", (Integer.to_json f)));
           Util.option_map v.number_of_auto_scaling_groups
             (fun f -> ("number_of_auto_scaling_groups", (Integer.to_json f)));
           Util.option_map v.max_number_of_launch_configurations
             (fun f ->
                ("max_number_of_launch_configurations", (Integer.to_json f)));
           Util.option_map v.max_number_of_auto_scaling_groups
             (fun f ->
                ("max_number_of_auto_scaling_groups", (Integer.to_json f)))])
    let parse xml =
      Some
        {
          max_number_of_auto_scaling_groups =
            (Util.option_bind (Xml.member "MaxNumberOfAutoScalingGroups" xml)
               Integer.parse);
          max_number_of_launch_configurations =
            (Util.option_bind
               (Xml.member "MaxNumberOfLaunchConfigurations" xml)
               Integer.parse);
          number_of_auto_scaling_groups =
            (Util.option_bind (Xml.member "NumberOfAutoScalingGroups" xml)
               Integer.parse);
          number_of_launch_configurations =
            (Util.option_bind (Xml.member "NumberOfLaunchConfigurations" xml)
               Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.max_number_of_auto_scaling_groups
                 (fun f ->
                    Ezxmlm.make_tag "MaxNumberOfAutoScalingGroups"
                      ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.max_number_of_launch_configurations
                (fun f ->
                   Ezxmlm.make_tag "MaxNumberOfLaunchConfigurations"
                     ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.number_of_auto_scaling_groups
               (fun f ->
                  Ezxmlm.make_tag "NumberOfAutoScalingGroups"
                    ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.number_of_launch_configurations
              (fun f ->
                 Ezxmlm.make_tag "NumberOfLaunchConfigurations"
                   ([], (Integer.to_xml f)))])
  end
module DescribeTerminationPolicyTypesAnswer =
  struct
    type t =
      {
      termination_policy_types: TerminationPolicies.t
        [@ocaml.doc
          "<p>The termination policies supported by Amazon EC2 Auto Scaling: <code>OldestInstance</code>, <code>OldestLaunchConfiguration</code>, <code>NewestInstance</code>, <code>ClosestToNextInstanceHour</code>, <code>Default</code>, <code>OldestLaunchTemplate</code>, and <code>AllocationStrategy</code>.</p>"]}
    let make ?(termination_policy_types= [])  () =
      { termination_policy_types }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("termination_policy_types",
                (TerminationPolicies.to_json v.termination_policy_types))])
    let parse xml =
      Some
        {
          termination_policy_types =
            (Util.of_option []
               (Util.option_bind (Xml.member "TerminationPolicyTypes" xml)
                  TerminationPolicies.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "TerminationPolicyTypes"
                      ([], (TerminationPolicies.to_xml [x]))))
              v.termination_policy_types))
  end
module DescribeAdjustmentTypesAnswer =
  struct
    type t =
      {
      adjustment_types: AdjustmentTypes.t
        [@ocaml.doc "<p>The policy adjustment types.</p>"]}
    let make ?(adjustment_types= [])  () = { adjustment_types }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("adjustment_types",
                (AdjustmentTypes.to_json v.adjustment_types))])
    let parse xml =
      Some
        {
          adjustment_types =
            (Util.of_option []
               (Util.option_bind (Xml.member "AdjustmentTypes" xml)
                  AdjustmentTypes.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "AdjustmentTypes"
                      ([], (AdjustmentTypes.to_xml [x])))) v.adjustment_types))
  end
module AutoScalingGroupsType =
  struct
    type t =
      {
      auto_scaling_groups: AutoScalingGroups.t
        [@ocaml.doc "<p>The groups.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>A string that indicates that the response contains more items than can be returned in a single response. To receive additional items, specify this string for the <code>NextToken</code> value when requesting the next set of items. This value is null when there are no more items to return.</p>"]}
    let make ~auto_scaling_groups  ?next_token  () =
      { auto_scaling_groups; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("auto_scaling_groups",
               (AutoScalingGroups.to_json v.auto_scaling_groups))])
    let parse xml =
      Some
        {
          auto_scaling_groups =
            (Xml.required "AutoScalingGroups"
               (Util.option_bind (Xml.member "AutoScalingGroups" xml)
                  AutoScalingGroups.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "AutoScalingGroups"
                       ([], (AutoScalingGroups.to_xml [x]))))
               v.auto_scaling_groups))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module DescribeNotificationConfigurationsAnswer =
  struct
    type t =
      {
      notification_configurations: NotificationConfigurations.t
        [@ocaml.doc "<p>The notification configurations.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>A string that indicates that the response contains more items than can be returned in a single response. To receive additional items, specify this string for the <code>NextToken</code> value when requesting the next set of items. This value is null when there are no more items to return.</p>"]}
    let make ~notification_configurations  ?next_token  () =
      { notification_configurations; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("notification_configurations",
               (NotificationConfigurations.to_json
                  v.notification_configurations))])
    let parse xml =
      Some
        {
          notification_configurations =
            (Xml.required "NotificationConfigurations"
               (Util.option_bind
                  (Xml.member "NotificationConfigurations" xml)
                  NotificationConfigurations.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "NotificationConfigurations"
                       ([], (NotificationConfigurations.to_xml [x]))))
               v.notification_configurations))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module DeleteLifecycleHookAnswer =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end
module LaunchConfigurationsType =
  struct
    type t =
      {
      launch_configurations: LaunchConfigurations.t
        [@ocaml.doc "<p>The launch configurations.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>A string that indicates that the response contains more items than can be returned in a single response. To receive additional items, specify this string for the <code>NextToken</code> value when requesting the next set of items. This value is null when there are no more items to return.</p>"]}
    let make ~launch_configurations  ?next_token  () =
      { launch_configurations; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("launch_configurations",
               (LaunchConfigurations.to_json v.launch_configurations))])
    let parse xml =
      Some
        {
          launch_configurations =
            (Xml.required "LaunchConfigurations"
               (Util.option_bind (Xml.member "LaunchConfigurations" xml)
                  LaunchConfigurations.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "LaunchConfigurations"
                       ([], (LaunchConfigurations.to_xml [x]))))
               v.launch_configurations))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module ExitStandbyAnswer =
  struct
    type t =
      {
      activities: Activities.t
        [@ocaml.doc
          "<p>The activities related to moving instances out of <code>Standby</code> mode.</p>"]}
    let make ?(activities= [])  () = { activities }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("activities", (Activities.to_json v.activities))])
    let parse xml =
      Some
        {
          activities =
            (Util.of_option []
               (Util.option_bind (Xml.member "Activities" xml)
                  Activities.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Activities"
                      ([], (Activities.to_xml [x])))) v.activities))
  end
module ScheduledActionsType =
  struct
    type t =
      {
      scheduled_update_group_actions: ScheduledUpdateGroupActions.t
        [@ocaml.doc "<p>The scheduled actions.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>A string that indicates that the response contains more items than can be returned in a single response. To receive additional items, specify this string for the <code>NextToken</code> value when requesting the next set of items. This value is null when there are no more items to return.</p>"]}
    let make ?(scheduled_update_group_actions= [])  ?next_token  () =
      { scheduled_update_group_actions; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("scheduled_update_group_actions",
               (ScheduledUpdateGroupActions.to_json
                  v.scheduled_update_group_actions))])
    let parse xml =
      Some
        {
          scheduled_update_group_actions =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "ScheduledUpdateGroupActions" xml)
                  ScheduledUpdateGroupActions.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "ScheduledUpdateGroupActions"
                       ([], (ScheduledUpdateGroupActions.to_xml [x]))))
               v.scheduled_update_group_actions))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module DescribeAutoScalingNotificationTypesAnswer =
  struct
    type t =
      {
      auto_scaling_notification_types: AutoScalingNotificationTypes.t
        [@ocaml.doc "<p>The notification types.</p>"]}
    let make ?(auto_scaling_notification_types= [])  () =
      { auto_scaling_notification_types }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("auto_scaling_notification_types",
                (AutoScalingNotificationTypes.to_json
                   v.auto_scaling_notification_types))])
    let parse xml =
      Some
        {
          auto_scaling_notification_types =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "AutoScalingNotificationTypes" xml)
                  AutoScalingNotificationTypes.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "AutoScalingNotificationTypes"
                      ([], (AutoScalingNotificationTypes.to_xml [x]))))
              v.auto_scaling_notification_types))
  end
module BatchDeleteScheduledActionAnswer =
  struct
    type t =
      {
      failed_scheduled_actions: FailedScheduledUpdateGroupActionRequests.t
        [@ocaml.doc
          "<p>The names of the scheduled actions that could not be deleted, including an error message.</p>"]}
    let make ?(failed_scheduled_actions= [])  () =
      { failed_scheduled_actions }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("failed_scheduled_actions",
                (FailedScheduledUpdateGroupActionRequests.to_json
                   v.failed_scheduled_actions))])
    let parse xml =
      Some
        {
          failed_scheduled_actions =
            (Util.of_option []
               (Util.option_bind (Xml.member "FailedScheduledActions" xml)
                  FailedScheduledUpdateGroupActionRequests.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "FailedScheduledActions"
                      ([],
                        (FailedScheduledUpdateGroupActionRequests.to_xml [x]))))
              v.failed_scheduled_actions))
  end
module DescribeLoadBalancersResponse =
  struct
    type t =
      {
      load_balancers: LoadBalancerStates.t
        [@ocaml.doc "<p>The load balancers.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>A string that indicates that the response contains more items than can be returned in a single response. To receive additional items, specify this string for the <code>NextToken</code> value when requesting the next set of items. This value is null when there are no more items to return.</p>"]}
    let make ?(load_balancers= [])  ?next_token  () =
      { load_balancers; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("load_balancers",
               (LoadBalancerStates.to_json v.load_balancers))])
    let parse xml =
      Some
        {
          load_balancers =
            (Util.of_option []
               (Util.option_bind (Xml.member "LoadBalancers" xml)
                  LoadBalancerStates.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "LoadBalancers"
                       ([], (LoadBalancerStates.to_xml [x]))))
               v.load_balancers))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module ActivitiesType =
  struct
    type t =
      {
      activities: Activities.t
        [@ocaml.doc
          "<p>The scaling activities. Activities are sorted by start time. Activities still in progress are described first.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>A string that indicates that the response contains more items than can be returned in a single response. To receive additional items, specify this string for the <code>NextToken</code> value when requesting the next set of items. This value is null when there are no more items to return.</p>"]}
    let make ~activities  ?next_token  () = { activities; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("activities", (Activities.to_json v.activities))])
    let parse xml =
      Some
        {
          activities =
            (Xml.required "Activities"
               (Util.option_bind (Xml.member "Activities" xml)
                  Activities.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Activities"
                       ([], (Activities.to_xml [x])))) v.activities))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module CompleteLifecycleActionAnswer =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end
module PolicyARNType =
  struct
    type t =
      {
      policy_a_r_n: String.t option
        [@ocaml.doc "<p>The Amazon Resource Name (ARN) of the policy.</p>"];
      alarms: Alarms.t
        [@ocaml.doc
          "<p>The CloudWatch alarms created for the target tracking scaling policy.</p>"]}
    [@@ocaml.doc "<p>Contains the output of PutScalingPolicy.</p>"]
    let make ?policy_a_r_n  ?(alarms= [])  () = { policy_a_r_n; alarms }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("alarms", (Alarms.to_json v.alarms));
           Util.option_map v.policy_a_r_n
             (fun f -> ("policy_a_r_n", (String.to_json f)))])
    let parse xml =
      Some
        {
          policy_a_r_n =
            (Util.option_bind (Xml.member "PolicyARN" xml) String.parse);
          alarms =
            (Util.of_option []
               (Util.option_bind (Xml.member "Alarms" xml) Alarms.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.policy_a_r_n
               (fun f -> Ezxmlm.make_tag "PolicyARN" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Alarms" ([], (Alarms.to_xml [x]))))
              v.alarms))
  end[@@ocaml.doc "<p>Contains the output of PutScalingPolicy.</p>"]
module DescribeMetricCollectionTypesAnswer =
  struct
    type t =
      {
      metrics: MetricCollectionTypes.t
        [@ocaml.doc "<p>One or more metrics.</p>"];
      granularities: MetricGranularityTypes.t
        [@ocaml.doc "<p>The granularities for the metrics.</p>"]}
    let make ?(metrics= [])  ?(granularities= [])  () =
      { metrics; granularities }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("granularities",
                (MetricGranularityTypes.to_json v.granularities));
           Some ("metrics", (MetricCollectionTypes.to_json v.metrics))])
    let parse xml =
      Some
        {
          metrics =
            (Util.of_option []
               (Util.option_bind (Xml.member "Metrics" xml)
                  MetricCollectionTypes.parse));
          granularities =
            (Util.of_option []
               (Util.option_bind (Xml.member "Granularities" xml)
                  MetricGranularityTypes.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Metrics"
                       ([], (MetricCollectionTypes.to_xml [x])))) v.metrics))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Granularities"
                      ([], (MetricGranularityTypes.to_xml [x]))))
              v.granularities))
  end
module EnterStandbyAnswer =
  struct
    type t =
      {
      activities: Activities.t
        [@ocaml.doc
          "<p>The activities related to moving instances into <code>Standby</code> mode.</p>"]}
    let make ?(activities= [])  () = { activities }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("activities", (Activities.to_json v.activities))])
    let parse xml =
      Some
        {
          activities =
            (Util.of_option []
               (Util.option_bind (Xml.member "Activities" xml)
                  Activities.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Activities"
                      ([], (Activities.to_xml [x])))) v.activities))
  end
module ProcessesType =
  struct
    type t =
      {
      processes: Processes.t
        [@ocaml.doc "<p>The names of the process types.</p>"]}
    let make ?(processes= [])  () = { processes }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("processes", (Processes.to_json v.processes))])
    let parse xml =
      Some
        {
          processes =
            (Util.of_option []
               (Util.option_bind (Xml.member "Processes" xml) Processes.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Processes" ([], (Processes.to_xml [x]))))
              v.processes))
  end