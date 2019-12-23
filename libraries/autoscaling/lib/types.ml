open Aws
open Aws.BaseTypes
open CalendarLib
type calendar = Calendar.t
module MetricDimension =
  struct
    type t = {
      name: String.t ;
      value: String.t }
    let make ~name  ~value  () = { name; value }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "Name" ([], (String.to_xml v.name)))])
           @ [Some (Ezxmlm.make_tag "Value" ([], (String.to_xml v.value)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("value", (String.to_json v.value));
           Some ("name", (String.to_json v.name))])
    let of_json j =
      {
        name = (String.of_json (Util.of_option_exn (Json.lookup j "name")));
        value = (String.of_json (Util.of_option_exn (Json.lookup j "value")))
      }
  end
module LaunchTemplateOverrides =
  struct
    type t =
      {
      instance_type: String.t option ;
      weighted_capacity: String.t option }
    let make ?instance_type  ?weighted_capacity  () =
      { instance_type; weighted_capacity }
    let parse xml =
      Some
        {
          instance_type =
            (Util.option_bind (Xml.member "InstanceType" xml) String.parse);
          weighted_capacity =
            (Util.option_bind (Xml.member "WeightedCapacity" xml)
               String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.weighted_capacity
              (fun f -> ("weighted_capacity", (String.to_json f)));
           Util.option_map v.instance_type
             (fun f -> ("instance_type", (String.to_json f)))])
    let of_json j =
      {
        instance_type =
          (Util.option_map (Json.lookup j "instance_type") String.of_json);
        weighted_capacity =
          (Util.option_map (Json.lookup j "weighted_capacity") String.of_json)
      }
  end
module MetricDimensions =
  struct
    type t = MetricDimension.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map MetricDimension.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list MetricDimension.to_query v
    let to_headers v = Headers.to_headers_list MetricDimension.to_headers v
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (MetricDimension.to_xml x)))
        v
    let to_json v = `List (List.map MetricDimension.to_json v)
    let of_json j = Json.to_list MetricDimension.of_json j
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
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
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
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module LaunchTemplateSpecification =
  struct
    type t =
      {
      launch_template_id: String.t option ;
      launch_template_name: String.t option ;
      version: String.t option }
    let make ?launch_template_id  ?launch_template_name  ?version  () =
      { launch_template_id; launch_template_name; version }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.version
              (fun f -> ("version", (String.to_json f)));
           Util.option_map v.launch_template_name
             (fun f -> ("launch_template_name", (String.to_json f)));
           Util.option_map v.launch_template_id
             (fun f -> ("launch_template_id", (String.to_json f)))])
    let of_json j =
      {
        launch_template_id =
          (Util.option_map (Json.lookup j "launch_template_id")
             String.of_json);
        launch_template_name =
          (Util.option_map (Json.lookup j "launch_template_name")
             String.of_json);
        version = (Util.option_map (Json.lookup j "version") String.of_json)
      }
  end
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
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module Overrides =
  struct
    type t = LaunchTemplateOverrides.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map LaunchTemplateOverrides.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list LaunchTemplateOverrides.to_query v
    let to_headers v =
      Headers.to_headers_list LaunchTemplateOverrides.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (LaunchTemplateOverrides.to_xml x)))
        v
    let to_json v = `List (List.map LaunchTemplateOverrides.to_json v)
    let of_json j = Json.to_list LaunchTemplateOverrides.of_json j
  end
module Ebs =
  struct
    type t =
      {
      snapshot_id: String.t option ;
      volume_size: Integer.t option ;
      volume_type: String.t option ;
      delete_on_termination: Boolean.t option ;
      iops: Integer.t option ;
      encrypted: Boolean.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        snapshot_id =
          (Util.option_map (Json.lookup j "snapshot_id") String.of_json);
        volume_size =
          (Util.option_map (Json.lookup j "volume_size") Integer.of_json);
        volume_type =
          (Util.option_map (Json.lookup j "volume_type") String.of_json);
        delete_on_termination =
          (Util.option_map (Json.lookup j "delete_on_termination")
             Boolean.of_json);
        iops = (Util.option_map (Json.lookup j "iops") Integer.of_json);
        encrypted =
          (Util.option_map (Json.lookup j "encrypted") Boolean.of_json)
      }
  end
module Alarm =
  struct
    type t = {
      alarm_name: String.t option ;
      alarm_a_r_n: String.t option }
    let make ?alarm_name  ?alarm_a_r_n  () = { alarm_name; alarm_a_r_n }
    let parse xml =
      Some
        {
          alarm_name =
            (Util.option_bind (Xml.member "AlarmName" xml) String.parse);
          alarm_a_r_n =
            (Util.option_bind (Xml.member "AlarmARN" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.alarm_name
               (fun f -> Ezxmlm.make_tag "AlarmName" ([], (String.to_xml f)))])
           @
           [Util.option_map v.alarm_a_r_n
              (fun f -> Ezxmlm.make_tag "AlarmARN" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.alarm_a_r_n
              (fun f -> ("alarm_a_r_n", (String.to_json f)));
           Util.option_map v.alarm_name
             (fun f -> ("alarm_name", (String.to_json f)))])
    let of_json j =
      {
        alarm_name =
          (Util.option_map (Json.lookup j "alarm_name") String.of_json);
        alarm_a_r_n =
          (Util.option_map (Json.lookup j "alarm_a_r_n") String.of_json)
      }
  end
module StepAdjustment =
  struct
    type t =
      {
      metric_interval_lower_bound: Double.t option ;
      metric_interval_upper_bound: Double.t option ;
      scaling_adjustment: Integer.t }
    let make ?metric_interval_lower_bound  ?metric_interval_upper_bound 
      ~scaling_adjustment  () =
      {
        metric_interval_lower_bound;
        metric_interval_upper_bound;
        scaling_adjustment
      }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("scaling_adjustment", (Integer.to_json v.scaling_adjustment));
           Util.option_map v.metric_interval_upper_bound
             (fun f -> ("metric_interval_upper_bound", (Double.to_json f)));
           Util.option_map v.metric_interval_lower_bound
             (fun f -> ("metric_interval_lower_bound", (Double.to_json f)))])
    let of_json j =
      {
        metric_interval_lower_bound =
          (Util.option_map (Json.lookup j "metric_interval_lower_bound")
             Double.of_json);
        metric_interval_upper_bound =
          (Util.option_map (Json.lookup j "metric_interval_upper_bound")
             Double.of_json);
        scaling_adjustment =
          (Integer.of_json
             (Util.of_option_exn (Json.lookup j "scaling_adjustment")))
      }
  end
module CustomizedMetricSpecification =
  struct
    type t =
      {
      metric_name: String.t ;
      namespace: String.t ;
      dimensions: MetricDimensions.t ;
      statistic: MetricStatistic.t ;
      unit: String.t option }
    let make ~metric_name  ~namespace  ?(dimensions= [])  ~statistic  ?unit 
      () = { metric_name; namespace; dimensions; statistic; unit }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.unit (fun f -> ("unit", (String.to_json f)));
           Some ("statistic", (MetricStatistic.to_json v.statistic));
           Some ("dimensions", (MetricDimensions.to_json v.dimensions));
           Some ("namespace", (String.to_json v.namespace));
           Some ("metric_name", (String.to_json v.metric_name))])
    let of_json j =
      {
        metric_name =
          (String.of_json (Util.of_option_exn (Json.lookup j "metric_name")));
        namespace =
          (String.of_json (Util.of_option_exn (Json.lookup j "namespace")));
        dimensions =
          (MetricDimensions.of_json
             (Util.of_option_exn (Json.lookup j "dimensions")));
        statistic =
          (MetricStatistic.of_json
             (Util.of_option_exn (Json.lookup j "statistic")));
        unit = (Util.option_map (Json.lookup j "unit") String.of_json)
      }
  end
module PredefinedMetricSpecification =
  struct
    type t =
      {
      predefined_metric_type: MetricType.t ;
      resource_label: String.t option }
    let make ~predefined_metric_type  ?resource_label  () =
      { predefined_metric_type; resource_label }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.resource_label
              (fun f -> ("resource_label", (String.to_json f)));
           Some
             ("predefined_metric_type",
               (MetricType.to_json v.predefined_metric_type))])
    let of_json j =
      {
        predefined_metric_type =
          (MetricType.of_json
             (Util.of_option_exn (Json.lookup j "predefined_metric_type")));
        resource_label =
          (Util.option_map (Json.lookup j "resource_label") String.of_json)
      }
  end
module EnabledMetric =
  struct
    type t = {
      metric: String.t option ;
      granularity: String.t option }
    let make ?metric  ?granularity  () = { metric; granularity }
    let parse xml =
      Some
        {
          metric = (Util.option_bind (Xml.member "Metric" xml) String.parse);
          granularity =
            (Util.option_bind (Xml.member "Granularity" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.metric
               (fun f -> Ezxmlm.make_tag "Metric" ([], (String.to_xml f)))])
           @
           [Util.option_map v.granularity
              (fun f -> Ezxmlm.make_tag "Granularity" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.granularity
              (fun f -> ("granularity", (String.to_json f)));
           Util.option_map v.metric (fun f -> ("metric", (String.to_json f)))])
    let of_json j =
      {
        metric = (Util.option_map (Json.lookup j "metric") String.of_json);
        granularity =
          (Util.option_map (Json.lookup j "granularity") String.of_json)
      }
  end
module Instance =
  struct
    type t =
      {
      instance_id: String.t ;
      instance_type: String.t option ;
      availability_zone: String.t ;
      lifecycle_state: LifecycleState.t ;
      health_status: String.t ;
      launch_configuration_name: String.t option ;
      launch_template: LaunchTemplateSpecification.t option ;
      protected_from_scale_in: Boolean.t ;
      weighted_capacity: String.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        instance_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "instance_id")));
        instance_type =
          (Util.option_map (Json.lookup j "instance_type") String.of_json);
        availability_zone =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "availability_zone")));
        lifecycle_state =
          (LifecycleState.of_json
             (Util.of_option_exn (Json.lookup j "lifecycle_state")));
        health_status =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "health_status")));
        launch_configuration_name =
          (Util.option_map (Json.lookup j "launch_configuration_name")
             String.of_json);
        launch_template =
          (Util.option_map (Json.lookup j "launch_template")
             LaunchTemplateSpecification.of_json);
        protected_from_scale_in =
          (Boolean.of_json
             (Util.of_option_exn (Json.lookup j "protected_from_scale_in")));
        weighted_capacity =
          (Util.option_map (Json.lookup j "weighted_capacity") String.of_json)
      }
  end
module InstancesDistribution =
  struct
    type t =
      {
      on_demand_allocation_strategy: String.t option ;
      on_demand_base_capacity: Integer.t option ;
      on_demand_percentage_above_base_capacity: Integer.t option ;
      spot_allocation_strategy: String.t option ;
      spot_instance_pools: Integer.t option ;
      spot_max_price: String.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        on_demand_allocation_strategy =
          (Util.option_map (Json.lookup j "on_demand_allocation_strategy")
             String.of_json);
        on_demand_base_capacity =
          (Util.option_map (Json.lookup j "on_demand_base_capacity")
             Integer.of_json);
        on_demand_percentage_above_base_capacity =
          (Util.option_map
             (Json.lookup j "on_demand_percentage_above_base_capacity")
             Integer.of_json);
        spot_allocation_strategy =
          (Util.option_map (Json.lookup j "spot_allocation_strategy")
             String.of_json);
        spot_instance_pools =
          (Util.option_map (Json.lookup j "spot_instance_pools")
             Integer.of_json);
        spot_max_price =
          (Util.option_map (Json.lookup j "spot_max_price") String.of_json)
      }
  end
module LaunchTemplate =
  struct
    type t =
      {
      launch_template_specification: LaunchTemplateSpecification.t option ;
      overrides: Overrides.t }
    let make ?launch_template_specification  ?(overrides= [])  () =
      { launch_template_specification; overrides }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("overrides", (Overrides.to_json v.overrides));
           Util.option_map v.launch_template_specification
             (fun f ->
                ("launch_template_specification",
                  (LaunchTemplateSpecification.to_json f)))])
    let of_json j =
      {
        launch_template_specification =
          (Util.option_map (Json.lookup j "launch_template_specification")
             LaunchTemplateSpecification.of_json);
        overrides =
          (Overrides.of_json (Util.of_option_exn (Json.lookup j "overrides")))
      }
  end
module SuspendedProcess =
  struct
    type t =
      {
      process_name: String.t option ;
      suspension_reason: String.t option }
    let make ?process_name  ?suspension_reason  () =
      { process_name; suspension_reason }
    let parse xml =
      Some
        {
          process_name =
            (Util.option_bind (Xml.member "ProcessName" xml) String.parse);
          suspension_reason =
            (Util.option_bind (Xml.member "SuspensionReason" xml)
               String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.suspension_reason
              (fun f -> ("suspension_reason", (String.to_json f)));
           Util.option_map v.process_name
             (fun f -> ("process_name", (String.to_json f)))])
    let of_json j =
      {
        process_name =
          (Util.option_map (Json.lookup j "process_name") String.of_json);
        suspension_reason =
          (Util.option_map (Json.lookup j "suspension_reason") String.of_json)
      }
  end
module TagDescription =
  struct
    type t =
      {
      resource_id: String.t ;
      resource_type: String.t ;
      key: String.t ;
      value: String.t ;
      propagate_at_launch: Boolean.t }
    let make ~resource_id  ~resource_type  ~key  ~value  ~propagate_at_launch
       () = { resource_id; resource_type; key; value; propagate_at_launch }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        resource_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "resource_id")));
        resource_type =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "resource_type")));
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        value = (String.of_json (Util.of_option_exn (Json.lookup j "value")));
        propagate_at_launch =
          (Boolean.of_json
             (Util.of_option_exn (Json.lookup j "propagate_at_launch")))
      }
  end
module BlockDeviceMapping =
  struct
    type t =
      {
      virtual_name: String.t option ;
      device_name: String.t ;
      ebs: Ebs.t option ;
      no_device: Boolean.t option }
    let make ?virtual_name  ~device_name  ?ebs  ?no_device  () =
      { virtual_name; device_name; ebs; no_device }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.no_device
              (fun f -> ("no_device", (Boolean.to_json f)));
           Util.option_map v.ebs (fun f -> ("ebs", (Ebs.to_json f)));
           Some ("device_name", (String.to_json v.device_name));
           Util.option_map v.virtual_name
             (fun f -> ("virtual_name", (String.to_json f)))])
    let of_json j =
      {
        virtual_name =
          (Util.option_map (Json.lookup j "virtual_name") String.of_json);
        device_name =
          (String.of_json (Util.of_option_exn (Json.lookup j "device_name")));
        ebs = (Util.option_map (Json.lookup j "ebs") Ebs.of_json);
        no_device =
          (Util.option_map (Json.lookup j "no_device") Boolean.of_json)
      }
  end
module Values =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module Alarms =
  struct
    type t = Alarm.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map Alarm.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list Alarm.to_query v
    let to_headers v = Headers.to_headers_list Alarm.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Alarm.to_xml x))) v
    let to_json v = `List (List.map Alarm.to_json v)
    let of_json j = Json.to_list Alarm.of_json j
  end
module StepAdjustments =
  struct
    type t = StepAdjustment.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map StepAdjustment.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list StepAdjustment.to_query v
    let to_headers v = Headers.to_headers_list StepAdjustment.to_headers v
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (StepAdjustment.to_xml x))) v
    let to_json v = `List (List.map StepAdjustment.to_json v)
    let of_json j = Json.to_list StepAdjustment.of_json j
  end
module TargetTrackingConfiguration =
  struct
    type t =
      {
      predefined_metric_specification: PredefinedMetricSpecification.t option ;
      customized_metric_specification: CustomizedMetricSpecification.t option ;
      target_value: Double.t ;
      disable_scale_in: Boolean.t option }
    let make ?predefined_metric_specification 
      ?customized_metric_specification  ~target_value  ?disable_scale_in  ()
      =
      {
        predefined_metric_specification;
        customized_metric_specification;
        target_value;
        disable_scale_in
      }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        predefined_metric_specification =
          (Util.option_map (Json.lookup j "predefined_metric_specification")
             PredefinedMetricSpecification.of_json);
        customized_metric_specification =
          (Util.option_map (Json.lookup j "customized_metric_specification")
             CustomizedMetricSpecification.of_json);
        target_value =
          (Double.of_json (Util.of_option_exn (Json.lookup j "target_value")));
        disable_scale_in =
          (Util.option_map (Json.lookup j "disable_scale_in") Boolean.of_json)
      }
  end
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
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module AvailabilityZones =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module EnabledMetrics =
  struct
    type t = EnabledMetric.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map EnabledMetric.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list EnabledMetric.to_query v
    let to_headers v = Headers.to_headers_list EnabledMetric.to_headers v
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (EnabledMetric.to_xml x))) v
    let to_json v = `List (List.map EnabledMetric.to_json v)
    let of_json j = Json.to_list EnabledMetric.of_json j
  end
module Instances =
  struct
    type t = Instance.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map Instance.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list Instance.to_query v
    let to_headers v = Headers.to_headers_list Instance.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Instance.to_xml x)))
        v
    let to_json v = `List (List.map Instance.to_json v)
    let of_json j = Json.to_list Instance.of_json j
  end
module LoadBalancerNames =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module MixedInstancesPolicy =
  struct
    type t =
      {
      launch_template: LaunchTemplate.t option ;
      instances_distribution: InstancesDistribution.t option }
    let make ?launch_template  ?instances_distribution  () =
      { launch_template; instances_distribution }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.instances_distribution
              (fun f ->
                 ("instances_distribution",
                   (InstancesDistribution.to_json f)));
           Util.option_map v.launch_template
             (fun f -> ("launch_template", (LaunchTemplate.to_json f)))])
    let of_json j =
      {
        launch_template =
          (Util.option_map (Json.lookup j "launch_template")
             LaunchTemplate.of_json);
        instances_distribution =
          (Util.option_map (Json.lookup j "instances_distribution")
             InstancesDistribution.of_json)
      }
  end
module SuspendedProcesses =
  struct
    type t = SuspendedProcess.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map SuspendedProcess.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list SuspendedProcess.to_query v
    let to_headers v = Headers.to_headers_list SuspendedProcess.to_headers v
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (SuspendedProcess.to_xml x)))
        v
    let to_json v = `List (List.map SuspendedProcess.to_json v)
    let of_json j = Json.to_list SuspendedProcess.of_json j
  end
module TagDescriptionList =
  struct
    type t = TagDescription.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map TagDescription.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list TagDescription.to_query v
    let to_headers v = Headers.to_headers_list TagDescription.to_headers v
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (TagDescription.to_xml x))) v
    let to_json v = `List (List.map TagDescription.to_json v)
    let of_json j = Json.to_list TagDescription.of_json j
  end
module TargetGroupARNs =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module TerminationPolicies =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module BlockDeviceMappings =
  struct
    type t = BlockDeviceMapping.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map BlockDeviceMapping.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list BlockDeviceMapping.to_query v
    let to_headers v =
      Headers.to_headers_list BlockDeviceMapping.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (BlockDeviceMapping.to_xml x))) v
    let to_json v = `List (List.map BlockDeviceMapping.to_json v)
    let of_json j = Json.to_list BlockDeviceMapping.of_json j
  end
module ClassicLinkVPCSecurityGroups =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module InstanceMonitoring =
  struct
    type t = {
      enabled: Boolean.t option }
    let make ?enabled  () = { enabled }
    let parse xml =
      Some
        {
          enabled =
            (Util.option_bind (Xml.member "Enabled" xml) Boolean.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.enabled
              (fun f -> Ezxmlm.make_tag "Enabled" ([], (Boolean.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.enabled
              (fun f -> ("enabled", (Boolean.to_json f)))])
    let of_json j =
      { enabled = (Util.option_map (Json.lookup j "enabled") Boolean.of_json)
      }
  end
module SecurityGroups =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module Filter =
  struct
    type t = {
      name: String.t ;
      values: Values.t }
    let make ~name  ?(values= [])  () = { name; values }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "Name" ([], (String.to_xml v.name)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Values" ([], (Values.to_xml [x]))))
              v.values))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("values", (Values.to_json v.values));
           Some ("name", (String.to_json v.name))])
    let of_json j =
      {
        name = (String.of_json (Util.of_option_exn (Json.lookup j "name")));
        values =
          (Values.of_json (Util.of_option_exn (Json.lookup j "values")))
      }
  end
module AutoScalingInstanceDetails =
  struct
    type t =
      {
      instance_id: String.t ;
      instance_type: String.t option ;
      auto_scaling_group_name: String.t ;
      availability_zone: String.t ;
      lifecycle_state: String.t ;
      health_status: String.t ;
      launch_configuration_name: String.t option ;
      launch_template: LaunchTemplateSpecification.t option ;
      protected_from_scale_in: Boolean.t ;
      weighted_capacity: String.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        instance_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "instance_id")));
        instance_type =
          (Util.option_map (Json.lookup j "instance_type") String.of_json);
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        availability_zone =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "availability_zone")));
        lifecycle_state =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "lifecycle_state")));
        health_status =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "health_status")));
        launch_configuration_name =
          (Util.option_map (Json.lookup j "launch_configuration_name")
             String.of_json);
        launch_template =
          (Util.option_map (Json.lookup j "launch_template")
             LaunchTemplateSpecification.of_json);
        protected_from_scale_in =
          (Boolean.of_json
             (Util.of_option_exn (Json.lookup j "protected_from_scale_in")));
        weighted_capacity =
          (Util.option_map (Json.lookup j "weighted_capacity") String.of_json)
      }
  end
module FailedScheduledUpdateGroupActionRequest =
  struct
    type t =
      {
      scheduled_action_name: String.t ;
      error_code: String.t option ;
      error_message: String.t option }
    let make ~scheduled_action_name  ?error_code  ?error_message  () =
      { scheduled_action_name; error_code; error_message }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        scheduled_action_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "scheduled_action_name")));
        error_code =
          (Util.option_map (Json.lookup j "error_code") String.of_json);
        error_message =
          (Util.option_map (Json.lookup j "error_message") String.of_json)
      }
  end
module ScalingPolicy =
  struct
    type t =
      {
      auto_scaling_group_name: String.t option ;
      policy_name: String.t option ;
      policy_a_r_n: String.t option ;
      policy_type: String.t option ;
      adjustment_type: String.t option ;
      min_adjustment_step: Integer.t option ;
      min_adjustment_magnitude: Integer.t option ;
      scaling_adjustment: Integer.t option ;
      cooldown: Integer.t option ;
      step_adjustments: StepAdjustments.t ;
      metric_aggregation_type: String.t option ;
      estimated_instance_warmup: Integer.t option ;
      alarms: Alarms.t ;
      target_tracking_configuration: TargetTrackingConfiguration.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        auto_scaling_group_name =
          (Util.option_map (Json.lookup j "auto_scaling_group_name")
             String.of_json);
        policy_name =
          (Util.option_map (Json.lookup j "policy_name") String.of_json);
        policy_a_r_n =
          (Util.option_map (Json.lookup j "policy_a_r_n") String.of_json);
        policy_type =
          (Util.option_map (Json.lookup j "policy_type") String.of_json);
        adjustment_type =
          (Util.option_map (Json.lookup j "adjustment_type") String.of_json);
        min_adjustment_step =
          (Util.option_map (Json.lookup j "min_adjustment_step")
             Integer.of_json);
        min_adjustment_magnitude =
          (Util.option_map (Json.lookup j "min_adjustment_magnitude")
             Integer.of_json);
        scaling_adjustment =
          (Util.option_map (Json.lookup j "scaling_adjustment")
             Integer.of_json);
        cooldown =
          (Util.option_map (Json.lookup j "cooldown") Integer.of_json);
        step_adjustments =
          (StepAdjustments.of_json
             (Util.of_option_exn (Json.lookup j "step_adjustments")));
        metric_aggregation_type =
          (Util.option_map (Json.lookup j "metric_aggregation_type")
             String.of_json);
        estimated_instance_warmup =
          (Util.option_map (Json.lookup j "estimated_instance_warmup")
             Integer.of_json);
        alarms =
          (Alarms.of_json (Util.of_option_exn (Json.lookup j "alarms")));
        target_tracking_configuration =
          (Util.option_map (Json.lookup j "target_tracking_configuration")
             TargetTrackingConfiguration.of_json)
      }
  end
module LifecycleHookSpecification =
  struct
    type t =
      {
      lifecycle_hook_name: String.t ;
      lifecycle_transition: String.t ;
      notification_metadata: String.t option ;
      heartbeat_timeout: Integer.t option ;
      default_result: String.t option ;
      notification_target_a_r_n: String.t option ;
      role_a_r_n: String.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        lifecycle_hook_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "lifecycle_hook_name")));
        lifecycle_transition =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "lifecycle_transition")));
        notification_metadata =
          (Util.option_map (Json.lookup j "notification_metadata")
             String.of_json);
        heartbeat_timeout =
          (Util.option_map (Json.lookup j "heartbeat_timeout")
             Integer.of_json);
        default_result =
          (Util.option_map (Json.lookup j "default_result") String.of_json);
        notification_target_a_r_n =
          (Util.option_map (Json.lookup j "notification_target_a_r_n")
             String.of_json);
        role_a_r_n =
          (Util.option_map (Json.lookup j "role_a_r_n") String.of_json)
      }
  end
module Tag =
  struct
    type t =
      {
      resource_id: String.t ;
      resource_type: String.t ;
      key: String.t ;
      value: String.t ;
      propagate_at_launch: Boolean.t }
    let make ~resource_id  ~resource_type  ~key  ~value  ~propagate_at_launch
       () = { resource_id; resource_type; key; value; propagate_at_launch }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        resource_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "resource_id")));
        resource_type =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "resource_type")));
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        value = (String.of_json (Util.of_option_exn (Json.lookup j "value")));
        propagate_at_launch =
          (Boolean.of_json
             (Util.of_option_exn (Json.lookup j "propagate_at_launch")))
      }
  end
module LifecycleHook =
  struct
    type t =
      {
      lifecycle_hook_name: String.t option ;
      auto_scaling_group_name: String.t option ;
      lifecycle_transition: String.t option ;
      notification_target_a_r_n: String.t option ;
      role_a_r_n: String.t option ;
      notification_metadata: String.t option ;
      heartbeat_timeout: Integer.t option ;
      global_timeout: Integer.t option ;
      default_result: String.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        lifecycle_hook_name =
          (Util.option_map (Json.lookup j "lifecycle_hook_name")
             String.of_json);
        auto_scaling_group_name =
          (Util.option_map (Json.lookup j "auto_scaling_group_name")
             String.of_json);
        lifecycle_transition =
          (Util.option_map (Json.lookup j "lifecycle_transition")
             String.of_json);
        notification_target_a_r_n =
          (Util.option_map (Json.lookup j "notification_target_a_r_n")
             String.of_json);
        role_a_r_n =
          (Util.option_map (Json.lookup j "role_a_r_n") String.of_json);
        notification_metadata =
          (Util.option_map (Json.lookup j "notification_metadata")
             String.of_json);
        heartbeat_timeout =
          (Util.option_map (Json.lookup j "heartbeat_timeout")
             Integer.of_json);
        global_timeout =
          (Util.option_map (Json.lookup j "global_timeout") Integer.of_json);
        default_result =
          (Util.option_map (Json.lookup j "default_result") String.of_json)
      }
  end
module LoadBalancerTargetGroupState =
  struct
    type t =
      {
      load_balancer_target_group_a_r_n: String.t option ;
      state: String.t option }
    let make ?load_balancer_target_group_a_r_n  ?state  () =
      { load_balancer_target_group_a_r_n; state }
    let parse xml =
      Some
        {
          load_balancer_target_group_a_r_n =
            (Util.option_bind (Xml.member "LoadBalancerTargetGroupARN" xml)
               String.parse);
          state = (Util.option_bind (Xml.member "State" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.state (fun f -> ("state", (String.to_json f)));
           Util.option_map v.load_balancer_target_group_a_r_n
             (fun f ->
                ("load_balancer_target_group_a_r_n", (String.to_json f)))])
    let of_json j =
      {
        load_balancer_target_group_a_r_n =
          (Util.option_map (Json.lookup j "load_balancer_target_group_a_r_n")
             String.of_json);
        state = (Util.option_map (Json.lookup j "state") String.of_json)
      }
  end
module Activity =
  struct
    type t =
      {
      activity_id: String.t ;
      auto_scaling_group_name: String.t ;
      description: String.t option ;
      cause: String.t ;
      start_time: DateTime.t ;
      end_time: DateTime.t option ;
      status_code: ScalingActivityStatusCode.t ;
      status_message: String.t option ;
      progress: Integer.t option ;
      details: String.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        activity_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "activity_id")));
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        cause = (String.of_json (Util.of_option_exn (Json.lookup j "cause")));
        start_time =
          (DateTime.of_json (Util.of_option_exn (Json.lookup j "start_time")));
        end_time =
          (Util.option_map (Json.lookup j "end_time") DateTime.of_json);
        status_code =
          (ScalingActivityStatusCode.of_json
             (Util.of_option_exn (Json.lookup j "status_code")));
        status_message =
          (Util.option_map (Json.lookup j "status_message") String.of_json);
        progress =
          (Util.option_map (Json.lookup j "progress") Integer.of_json);
        details = (Util.option_map (Json.lookup j "details") String.of_json)
      }
  end
module AdjustmentType =
  struct
    type t = {
      adjustment_type: String.t option }
    let make ?adjustment_type  () = { adjustment_type }
    let parse xml =
      Some
        {
          adjustment_type =
            (Util.option_bind (Xml.member "AdjustmentType" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.adjustment_type
              (fun f ->
                 Ezxmlm.make_tag "AdjustmentType" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.adjustment_type
              (fun f -> ("adjustment_type", (String.to_json f)))])
    let of_json j =
      {
        adjustment_type =
          (Util.option_map (Json.lookup j "adjustment_type") String.of_json)
      }
  end
module AutoScalingGroup =
  struct
    type t =
      {
      auto_scaling_group_name: String.t ;
      auto_scaling_group_a_r_n: String.t option ;
      launch_configuration_name: String.t option ;
      launch_template: LaunchTemplateSpecification.t option ;
      mixed_instances_policy: MixedInstancesPolicy.t option ;
      min_size: Integer.t ;
      max_size: Integer.t ;
      desired_capacity: Integer.t ;
      default_cooldown: Integer.t ;
      availability_zones: AvailabilityZones.t ;
      load_balancer_names: LoadBalancerNames.t ;
      target_group_a_r_ns: TargetGroupARNs.t ;
      health_check_type: String.t ;
      health_check_grace_period: Integer.t option ;
      instances: Instances.t ;
      created_time: DateTime.t ;
      suspended_processes: SuspendedProcesses.t ;
      placement_group: String.t option ;
      v_p_c_zone_identifier: String.t option ;
      enabled_metrics: EnabledMetrics.t ;
      status: String.t option ;
      tags: TagDescriptionList.t ;
      termination_policies: TerminationPolicies.t ;
      new_instances_protected_from_scale_in: Boolean.t option ;
      service_linked_role_a_r_n: String.t option ;
      max_instance_lifetime: Integer.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        auto_scaling_group_a_r_n =
          (Util.option_map (Json.lookup j "auto_scaling_group_a_r_n")
             String.of_json);
        launch_configuration_name =
          (Util.option_map (Json.lookup j "launch_configuration_name")
             String.of_json);
        launch_template =
          (Util.option_map (Json.lookup j "launch_template")
             LaunchTemplateSpecification.of_json);
        mixed_instances_policy =
          (Util.option_map (Json.lookup j "mixed_instances_policy")
             MixedInstancesPolicy.of_json);
        min_size =
          (Integer.of_json (Util.of_option_exn (Json.lookup j "min_size")));
        max_size =
          (Integer.of_json (Util.of_option_exn (Json.lookup j "max_size")));
        desired_capacity =
          (Integer.of_json
             (Util.of_option_exn (Json.lookup j "desired_capacity")));
        default_cooldown =
          (Integer.of_json
             (Util.of_option_exn (Json.lookup j "default_cooldown")));
        availability_zones =
          (AvailabilityZones.of_json
             (Util.of_option_exn (Json.lookup j "availability_zones")));
        load_balancer_names =
          (LoadBalancerNames.of_json
             (Util.of_option_exn (Json.lookup j "load_balancer_names")));
        target_group_a_r_ns =
          (TargetGroupARNs.of_json
             (Util.of_option_exn (Json.lookup j "target_group_a_r_ns")));
        health_check_type =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "health_check_type")));
        health_check_grace_period =
          (Util.option_map (Json.lookup j "health_check_grace_period")
             Integer.of_json);
        instances =
          (Instances.of_json (Util.of_option_exn (Json.lookup j "instances")));
        created_time =
          (DateTime.of_json
             (Util.of_option_exn (Json.lookup j "created_time")));
        suspended_processes =
          (SuspendedProcesses.of_json
             (Util.of_option_exn (Json.lookup j "suspended_processes")));
        placement_group =
          (Util.option_map (Json.lookup j "placement_group") String.of_json);
        v_p_c_zone_identifier =
          (Util.option_map (Json.lookup j "v_p_c_zone_identifier")
             String.of_json);
        enabled_metrics =
          (EnabledMetrics.of_json
             (Util.of_option_exn (Json.lookup j "enabled_metrics")));
        status = (Util.option_map (Json.lookup j "status") String.of_json);
        tags =
          (TagDescriptionList.of_json
             (Util.of_option_exn (Json.lookup j "tags")));
        termination_policies =
          (TerminationPolicies.of_json
             (Util.of_option_exn (Json.lookup j "termination_policies")));
        new_instances_protected_from_scale_in =
          (Util.option_map
             (Json.lookup j "new_instances_protected_from_scale_in")
             Boolean.of_json);
        service_linked_role_a_r_n =
          (Util.option_map (Json.lookup j "service_linked_role_a_r_n")
             String.of_json);
        max_instance_lifetime =
          (Util.option_map (Json.lookup j "max_instance_lifetime")
             Integer.of_json)
      }
  end
module NotificationConfiguration =
  struct
    type t =
      {
      auto_scaling_group_name: String.t option ;
      topic_a_r_n: String.t option ;
      notification_type: String.t option }
    let make ?auto_scaling_group_name  ?topic_a_r_n  ?notification_type  () =
      { auto_scaling_group_name; topic_a_r_n; notification_type }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.notification_type
              (fun f -> ("notification_type", (String.to_json f)));
           Util.option_map v.topic_a_r_n
             (fun f -> ("topic_a_r_n", (String.to_json f)));
           Util.option_map v.auto_scaling_group_name
             (fun f -> ("auto_scaling_group_name", (String.to_json f)))])
    let of_json j =
      {
        auto_scaling_group_name =
          (Util.option_map (Json.lookup j "auto_scaling_group_name")
             String.of_json);
        topic_a_r_n =
          (Util.option_map (Json.lookup j "topic_a_r_n") String.of_json);
        notification_type =
          (Util.option_map (Json.lookup j "notification_type") String.of_json)
      }
  end
module LaunchConfiguration =
  struct
    type t =
      {
      launch_configuration_name: String.t ;
      launch_configuration_a_r_n: String.t option ;
      image_id: String.t ;
      key_name: String.t option ;
      security_groups: SecurityGroups.t ;
      classic_link_v_p_c_id: String.t option ;
      classic_link_v_p_c_security_groups: ClassicLinkVPCSecurityGroups.t ;
      user_data: String.t option ;
      instance_type: String.t ;
      kernel_id: String.t option ;
      ramdisk_id: String.t option ;
      block_device_mappings: BlockDeviceMappings.t ;
      instance_monitoring: InstanceMonitoring.t option ;
      spot_price: String.t option ;
      iam_instance_profile: String.t option ;
      created_time: DateTime.t ;
      ebs_optimized: Boolean.t option ;
      associate_public_ip_address: Boolean.t option ;
      placement_tenancy: String.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        launch_configuration_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "launch_configuration_name")));
        launch_configuration_a_r_n =
          (Util.option_map (Json.lookup j "launch_configuration_a_r_n")
             String.of_json);
        image_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "image_id")));
        key_name =
          (Util.option_map (Json.lookup j "key_name") String.of_json);
        security_groups =
          (SecurityGroups.of_json
             (Util.of_option_exn (Json.lookup j "security_groups")));
        classic_link_v_p_c_id =
          (Util.option_map (Json.lookup j "classic_link_v_p_c_id")
             String.of_json);
        classic_link_v_p_c_security_groups =
          (ClassicLinkVPCSecurityGroups.of_json
             (Util.of_option_exn
                (Json.lookup j "classic_link_v_p_c_security_groups")));
        user_data =
          (Util.option_map (Json.lookup j "user_data") String.of_json);
        instance_type =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "instance_type")));
        kernel_id =
          (Util.option_map (Json.lookup j "kernel_id") String.of_json);
        ramdisk_id =
          (Util.option_map (Json.lookup j "ramdisk_id") String.of_json);
        block_device_mappings =
          (BlockDeviceMappings.of_json
             (Util.of_option_exn (Json.lookup j "block_device_mappings")));
        instance_monitoring =
          (Util.option_map (Json.lookup j "instance_monitoring")
             InstanceMonitoring.of_json);
        spot_price =
          (Util.option_map (Json.lookup j "spot_price") String.of_json);
        iam_instance_profile =
          (Util.option_map (Json.lookup j "iam_instance_profile")
             String.of_json);
        created_time =
          (DateTime.of_json
             (Util.of_option_exn (Json.lookup j "created_time")));
        ebs_optimized =
          (Util.option_map (Json.lookup j "ebs_optimized") Boolean.of_json);
        associate_public_ip_address =
          (Util.option_map (Json.lookup j "associate_public_ip_address")
             Boolean.of_json);
        placement_tenancy =
          (Util.option_map (Json.lookup j "placement_tenancy") String.of_json)
      }
  end
module ScheduledUpdateGroupAction =
  struct
    type t =
      {
      auto_scaling_group_name: String.t option ;
      scheduled_action_name: String.t option ;
      scheduled_action_a_r_n: String.t option ;
      time: DateTime.t option ;
      start_time: DateTime.t option ;
      end_time: DateTime.t option ;
      recurrence: String.t option ;
      min_size: Integer.t option ;
      max_size: Integer.t option ;
      desired_capacity: Integer.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        auto_scaling_group_name =
          (Util.option_map (Json.lookup j "auto_scaling_group_name")
             String.of_json);
        scheduled_action_name =
          (Util.option_map (Json.lookup j "scheduled_action_name")
             String.of_json);
        scheduled_action_a_r_n =
          (Util.option_map (Json.lookup j "scheduled_action_a_r_n")
             String.of_json);
        time = (Util.option_map (Json.lookup j "time") DateTime.of_json);
        start_time =
          (Util.option_map (Json.lookup j "start_time") DateTime.of_json);
        end_time =
          (Util.option_map (Json.lookup j "end_time") DateTime.of_json);
        recurrence =
          (Util.option_map (Json.lookup j "recurrence") String.of_json);
        min_size =
          (Util.option_map (Json.lookup j "min_size") Integer.of_json);
        max_size =
          (Util.option_map (Json.lookup j "max_size") Integer.of_json);
        desired_capacity =
          (Util.option_map (Json.lookup j "desired_capacity") Integer.of_json)
      }
  end
module ScheduledUpdateGroupActionRequest =
  struct
    type t =
      {
      scheduled_action_name: String.t ;
      start_time: DateTime.t option ;
      end_time: DateTime.t option ;
      recurrence: String.t option ;
      min_size: Integer.t option ;
      max_size: Integer.t option ;
      desired_capacity: Integer.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        scheduled_action_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "scheduled_action_name")));
        start_time =
          (Util.option_map (Json.lookup j "start_time") DateTime.of_json);
        end_time =
          (Util.option_map (Json.lookup j "end_time") DateTime.of_json);
        recurrence =
          (Util.option_map (Json.lookup j "recurrence") String.of_json);
        min_size =
          (Util.option_map (Json.lookup j "min_size") Integer.of_json);
        max_size =
          (Util.option_map (Json.lookup j "max_size") Integer.of_json);
        desired_capacity =
          (Util.option_map (Json.lookup j "desired_capacity") Integer.of_json)
      }
  end
module LoadBalancerState =
  struct
    type t = {
      load_balancer_name: String.t option ;
      state: String.t option }
    let make ?load_balancer_name  ?state  () = { load_balancer_name; state }
    let parse xml =
      Some
        {
          load_balancer_name =
            (Util.option_bind (Xml.member "LoadBalancerName" xml)
               String.parse);
          state = (Util.option_bind (Xml.member "State" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.load_balancer_name
               (fun f ->
                  Ezxmlm.make_tag "LoadBalancerName" ([], (String.to_xml f)))])
           @
           [Util.option_map v.state
              (fun f -> Ezxmlm.make_tag "State" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.state (fun f -> ("state", (String.to_json f)));
           Util.option_map v.load_balancer_name
             (fun f -> ("load_balancer_name", (String.to_json f)))])
    let of_json j =
      {
        load_balancer_name =
          (Util.option_map (Json.lookup j "load_balancer_name")
             String.of_json);
        state = (Util.option_map (Json.lookup j "state") String.of_json)
      }
  end
module MetricCollectionType =
  struct
    type t = {
      metric: String.t option }
    let make ?metric  () = { metric }
    let parse xml =
      Some
        { metric = (Util.option_bind (Xml.member "Metric" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.metric
              (fun f -> Ezxmlm.make_tag "Metric" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.metric
              (fun f -> ("metric", (String.to_json f)))])
    let of_json j =
      { metric = (Util.option_map (Json.lookup j "metric") String.of_json) }
  end
module MetricGranularityType =
  struct
    type t = {
      granularity: String.t option }
    let make ?granularity  () = { granularity }
    let parse xml =
      Some
        {
          granularity =
            (Util.option_bind (Xml.member "Granularity" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.granularity
              (fun f -> Ezxmlm.make_tag "Granularity" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.granularity
              (fun f -> ("granularity", (String.to_json f)))])
    let of_json j =
      {
        granularity =
          (Util.option_map (Json.lookup j "granularity") String.of_json)
      }
  end
module ProcessType =
  struct
    type t = {
      process_name: String.t }
    let make ~process_name  () = { process_name }
    let parse xml =
      Some
        {
          process_name =
            (Xml.required "ProcessName"
               (Util.option_bind (Xml.member "ProcessName" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "ProcessName"
                 ([], (String.to_xml v.process_name)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("process_name", (String.to_json v.process_name))])
    let of_json j =
      {
        process_name =
          (String.of_json (Util.of_option_exn (Json.lookup j "process_name")))
      }
  end
module InstanceIds =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module Filters =
  struct
    type t = Filter.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map Filter.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list Filter.to_query v
    let to_headers v = Headers.to_headers_list Filter.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Filter.to_xml x))) v
    let to_json v = `List (List.map Filter.to_json v)
    let of_json j = Json.to_list Filter.of_json j
  end
module ProcessNames =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module AutoScalingInstances =
  struct
    type t = AutoScalingInstanceDetails.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map AutoScalingInstanceDetails.parse (Xml.members "member" xml))
    let to_query v =
      Query.to_query_list AutoScalingInstanceDetails.to_query v
    let to_headers v =
      Headers.to_headers_list AutoScalingInstanceDetails.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (AutoScalingInstanceDetails.to_xml x))) v
    let to_json v = `List (List.map AutoScalingInstanceDetails.to_json v)
    let of_json j = Json.to_list AutoScalingInstanceDetails.of_json j
  end
module AutoScalingNotificationTypes =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module FailedScheduledUpdateGroupActionRequests =
  struct
    type t = FailedScheduledUpdateGroupActionRequest.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map FailedScheduledUpdateGroupActionRequest.parse
           (Xml.members "member" xml))
    let to_query v =
      Query.to_query_list FailedScheduledUpdateGroupActionRequest.to_query v
    let to_headers v =
      Headers.to_headers_list
        FailedScheduledUpdateGroupActionRequest.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (FailedScheduledUpdateGroupActionRequest.to_xml x))) v
    let to_json v =
      `List (List.map FailedScheduledUpdateGroupActionRequest.to_json v)
    let of_json j =
      Json.to_list FailedScheduledUpdateGroupActionRequest.of_json j
  end
module ScalingPolicies =
  struct
    type t = ScalingPolicy.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map ScalingPolicy.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list ScalingPolicy.to_query v
    let to_headers v = Headers.to_headers_list ScalingPolicy.to_headers v
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (ScalingPolicy.to_xml x))) v
    let to_json v = `List (List.map ScalingPolicy.to_json v)
    let of_json j = Json.to_list ScalingPolicy.of_json j
  end
module LifecycleHookSpecifications =
  struct
    type t = LifecycleHookSpecification.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map LifecycleHookSpecification.parse (Xml.members "member" xml))
    let to_query v =
      Query.to_query_list LifecycleHookSpecification.to_query v
    let to_headers v =
      Headers.to_headers_list LifecycleHookSpecification.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (LifecycleHookSpecification.to_xml x))) v
    let to_json v = `List (List.map LifecycleHookSpecification.to_json v)
    let of_json j = Json.to_list LifecycleHookSpecification.of_json j
  end
module Tags =
  struct
    type t = Tag.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map Tag.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list Tag.to_query v
    let to_headers v = Headers.to_headers_list Tag.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Tag.to_xml x))) v
    let to_json v = `List (List.map Tag.to_json v)
    let of_json j = Json.to_list Tag.of_json j
  end
module ActivityIds =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module LifecycleHooks =
  struct
    type t = LifecycleHook.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map LifecycleHook.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list LifecycleHook.to_query v
    let to_headers v = Headers.to_headers_list LifecycleHook.to_headers v
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (LifecycleHook.to_xml x))) v
    let to_json v = `List (List.map LifecycleHook.to_json v)
    let of_json j = Json.to_list LifecycleHook.of_json j
  end
module LoadBalancerTargetGroupStates =
  struct
    type t = LoadBalancerTargetGroupState.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map LoadBalancerTargetGroupState.parse
           (Xml.members "member" xml))
    let to_query v =
      Query.to_query_list LoadBalancerTargetGroupState.to_query v
    let to_headers v =
      Headers.to_headers_list LoadBalancerTargetGroupState.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (LoadBalancerTargetGroupState.to_xml x))) v
    let to_json v = `List (List.map LoadBalancerTargetGroupState.to_json v)
    let of_json j = Json.to_list LoadBalancerTargetGroupState.of_json j
  end
module Activities =
  struct
    type t = Activity.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map Activity.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list Activity.to_query v
    let to_headers v = Headers.to_headers_list Activity.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Activity.to_xml x)))
        v
    let to_json v = `List (List.map Activity.to_json v)
    let of_json j = Json.to_list Activity.of_json j
  end
module LaunchConfigurationNames =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module AdjustmentTypes =
  struct
    type t = AdjustmentType.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map AdjustmentType.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list AdjustmentType.to_query v
    let to_headers v = Headers.to_headers_list AdjustmentType.to_headers v
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (AdjustmentType.to_xml x))) v
    let to_json v = `List (List.map AdjustmentType.to_json v)
    let of_json j = Json.to_list AdjustmentType.of_json j
  end
module AutoScalingGroups =
  struct
    type t = AutoScalingGroup.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map AutoScalingGroup.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list AutoScalingGroup.to_query v
    let to_headers v = Headers.to_headers_list AutoScalingGroup.to_headers v
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (AutoScalingGroup.to_xml x)))
        v
    let to_json v = `List (List.map AutoScalingGroup.to_json v)
    let of_json j = Json.to_list AutoScalingGroup.of_json j
  end
module ScheduledActionNames =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module Metrics =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module PolicyNames =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module PolicyTypes =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module NotificationConfigurations =
  struct
    type t = NotificationConfiguration.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map NotificationConfiguration.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list NotificationConfiguration.to_query v
    let to_headers v =
      Headers.to_headers_list NotificationConfiguration.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (NotificationConfiguration.to_xml x))) v
    let to_json v = `List (List.map NotificationConfiguration.to_json v)
    let of_json j = Json.to_list NotificationConfiguration.of_json j
  end
module AutoScalingGroupNames =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module LaunchConfigurations =
  struct
    type t = LaunchConfiguration.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map LaunchConfiguration.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list LaunchConfiguration.to_query v
    let to_headers v =
      Headers.to_headers_list LaunchConfiguration.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (LaunchConfiguration.to_xml x))) v
    let to_json v = `List (List.map LaunchConfiguration.to_json v)
    let of_json j = Json.to_list LaunchConfiguration.of_json j
  end
module ScheduledUpdateGroupActions =
  struct
    type t = ScheduledUpdateGroupAction.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map ScheduledUpdateGroupAction.parse (Xml.members "member" xml))
    let to_query v =
      Query.to_query_list ScheduledUpdateGroupAction.to_query v
    let to_headers v =
      Headers.to_headers_list ScheduledUpdateGroupAction.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (ScheduledUpdateGroupAction.to_xml x))) v
    let to_json v = `List (List.map ScheduledUpdateGroupAction.to_json v)
    let of_json j = Json.to_list ScheduledUpdateGroupAction.of_json j
  end
module ScheduledUpdateGroupActionRequests =
  struct
    type t = ScheduledUpdateGroupActionRequest.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map ScheduledUpdateGroupActionRequest.parse
           (Xml.members "member" xml))
    let to_query v =
      Query.to_query_list ScheduledUpdateGroupActionRequest.to_query v
    let to_headers v =
      Headers.to_headers_list ScheduledUpdateGroupActionRequest.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (ScheduledUpdateGroupActionRequest.to_xml x))) v
    let to_json v =
      `List (List.map ScheduledUpdateGroupActionRequest.to_json v)
    let of_json j = Json.to_list ScheduledUpdateGroupActionRequest.of_json j
  end
module LoadBalancerStates =
  struct
    type t = LoadBalancerState.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map LoadBalancerState.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list LoadBalancerState.to_query v
    let to_headers v = Headers.to_headers_list LoadBalancerState.to_headers v
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (LoadBalancerState.to_xml x)))
        v
    let to_json v = `List (List.map LoadBalancerState.to_json v)
    let of_json j = Json.to_list LoadBalancerState.of_json j
  end
module MetricCollectionTypes =
  struct
    type t = MetricCollectionType.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map MetricCollectionType.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list MetricCollectionType.to_query v
    let to_headers v =
      Headers.to_headers_list MetricCollectionType.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (MetricCollectionType.to_xml x))) v
    let to_json v = `List (List.map MetricCollectionType.to_json v)
    let of_json j = Json.to_list MetricCollectionType.of_json j
  end
module MetricGranularityTypes =
  struct
    type t = MetricGranularityType.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map MetricGranularityType.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list MetricGranularityType.to_query v
    let to_headers v =
      Headers.to_headers_list MetricGranularityType.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (MetricGranularityType.to_xml x))) v
    let to_json v = `List (List.map MetricGranularityType.to_json v)
    let of_json j = Json.to_list MetricGranularityType.of_json j
  end
module LifecycleHookNames =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module Processes =
  struct
    type t = ProcessType.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map ProcessType.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list ProcessType.to_query v
    let to_headers v = Headers.to_headers_list ProcessType.to_headers v
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (ProcessType.to_xml x))) v
    let to_json v = `List (List.map ProcessType.to_json v)
    let of_json j = Json.to_list ProcessType.of_json j
  end
module ExitStandbyQuery =
  struct
    type t =
      {
      instance_ids: InstanceIds.t ;
      auto_scaling_group_name: String.t }
    let make ?(instance_ids= [])  ~auto_scaling_group_name  () =
      { instance_ids; auto_scaling_group_name }
    let parse xml =
      Some
        {
          instance_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "InstanceIds" xml)
                  InstanceIds.parse));
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "InstanceIds"
                       ([], (InstanceIds.to_xml [x])))) v.instance_ids))
           @
           [Some
              (Ezxmlm.make_tag "AutoScalingGroupName"
                 ([], (String.to_xml v.auto_scaling_group_name)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("auto_scaling_group_name",
                (String.to_json v.auto_scaling_group_name));
           Some ("instance_ids", (InstanceIds.to_json v.instance_ids))])
    let of_json j =
      {
        instance_ids =
          (InstanceIds.of_json
             (Util.of_option_exn (Json.lookup j "instance_ids")));
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")))
      }
  end
module RecordLifecycleActionHeartbeatAnswer =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module ActivityType =
  struct
    type t = {
      activity: Activity.t option }
    let make ?activity  () = { activity }
    let parse xml =
      Some
        {
          activity =
            (Util.option_bind (Xml.member "Activity" xml) Activity.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.activity
              (fun f -> Ezxmlm.make_tag "Activity" ([], (Activity.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.activity
              (fun f -> ("activity", (Activity.to_json f)))])
    let of_json j =
      {
        activity =
          (Util.option_map (Json.lookup j "activity") Activity.of_json)
      }
  end
module DeleteAutoScalingGroupType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t ;
      force_delete: Boolean.t option }
    let make ~auto_scaling_group_name  ?force_delete  () =
      { auto_scaling_group_name; force_delete }
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          force_delete =
            (Util.option_bind (Xml.member "ForceDelete" xml) Boolean.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "AutoScalingGroupName"
                  ([], (String.to_xml v.auto_scaling_group_name)))])
           @
           [Util.option_map v.force_delete
              (fun f ->
                 Ezxmlm.make_tag "ForceDelete" ([], (Boolean.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.force_delete
              (fun f -> ("force_delete", (Boolean.to_json f)));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name))])
    let of_json j =
      {
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        force_delete =
          (Util.option_map (Json.lookup j "force_delete") Boolean.of_json)
      }
  end
module DescribeTagsType =
  struct
    type t =
      {
      filters: Filters.t ;
      next_token: String.t option ;
      max_records: Integer.t option }
    let make ?(filters= [])  ?next_token  ?max_records  () =
      { filters; next_token; max_records }
    let parse xml =
      Some
        {
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filters" xml) Filters.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "Filters" ([], (Filters.to_xml [x]))))
                v.filters))
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_records
              (fun f -> Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_records
              (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Some ("filters", (Filters.to_json v.filters))])
    let of_json j =
      {
        filters =
          (Filters.of_json (Util.of_option_exn (Json.lookup j "filters")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json);
        max_records =
          (Util.option_map (Json.lookup j "max_records") Integer.of_json)
      }
  end
module PutLifecycleHookType =
  struct
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
    let make ~lifecycle_hook_name  ~auto_scaling_group_name 
      ?lifecycle_transition  ?role_a_r_n  ?notification_target_a_r_n 
      ?notification_metadata  ?heartbeat_timeout  ?default_result  () =
      {
        lifecycle_hook_name;
        auto_scaling_group_name;
        lifecycle_transition;
        role_a_r_n;
        notification_target_a_r_n;
        notification_metadata;
        heartbeat_timeout;
        default_result
      }
    let parse xml =
      Some
        {
          lifecycle_hook_name =
            (Xml.required "LifecycleHookName"
               (Util.option_bind (Xml.member "LifecycleHookName" xml)
                  String.parse));
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          lifecycle_transition =
            (Util.option_bind (Xml.member "LifecycleTransition" xml)
               String.parse);
          role_a_r_n =
            (Util.option_bind (Xml.member "RoleARN" xml) String.parse);
          notification_target_a_r_n =
            (Util.option_bind (Xml.member "NotificationTargetARN" xml)
               String.parse);
          notification_metadata =
            (Util.option_bind (Xml.member "NotificationMetadata" xml)
               String.parse);
          heartbeat_timeout =
            (Util.option_bind (Xml.member "HeartbeatTimeout" xml)
               Integer.parse);
          default_result =
            (Util.option_bind (Xml.member "DefaultResult" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((((((([] @
                  [Some
                     (Ezxmlm.make_tag "LifecycleHookName"
                        ([], (String.to_xml v.lifecycle_hook_name)))])
                 @
                 [Some
                    (Ezxmlm.make_tag "AutoScalingGroupName"
                       ([], (String.to_xml v.auto_scaling_group_name)))])
                @
                [Util.option_map v.lifecycle_transition
                   (fun f ->
                      Ezxmlm.make_tag "LifecycleTransition"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.role_a_r_n
                  (fun f -> Ezxmlm.make_tag "RoleARN" ([], (String.to_xml f)))])
              @
              [Util.option_map v.notification_target_a_r_n
                 (fun f ->
                    Ezxmlm.make_tag "NotificationTargetARN"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.notification_metadata
                (fun f ->
                   Ezxmlm.make_tag "NotificationMetadata"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.heartbeat_timeout
               (fun f ->
                  Ezxmlm.make_tag "HeartbeatTimeout" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.default_result
              (fun f ->
                 Ezxmlm.make_tag "DefaultResult" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.default_result
              (fun f -> ("default_result", (String.to_json f)));
           Util.option_map v.heartbeat_timeout
             (fun f -> ("heartbeat_timeout", (Integer.to_json f)));
           Util.option_map v.notification_metadata
             (fun f -> ("notification_metadata", (String.to_json f)));
           Util.option_map v.notification_target_a_r_n
             (fun f -> ("notification_target_a_r_n", (String.to_json f)));
           Util.option_map v.role_a_r_n
             (fun f -> ("role_a_r_n", (String.to_json f)));
           Util.option_map v.lifecycle_transition
             (fun f -> ("lifecycle_transition", (String.to_json f)));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name));
           Some
             ("lifecycle_hook_name", (String.to_json v.lifecycle_hook_name))])
    let of_json j =
      {
        lifecycle_hook_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "lifecycle_hook_name")));
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        lifecycle_transition =
          (Util.option_map (Json.lookup j "lifecycle_transition")
             String.of_json);
        role_a_r_n =
          (Util.option_map (Json.lookup j "role_a_r_n") String.of_json);
        notification_target_a_r_n =
          (Util.option_map (Json.lookup j "notification_target_a_r_n")
             String.of_json);
        notification_metadata =
          (Util.option_map (Json.lookup j "notification_metadata")
             String.of_json);
        heartbeat_timeout =
          (Util.option_map (Json.lookup j "heartbeat_timeout")
             Integer.of_json);
        default_result =
          (Util.option_map (Json.lookup j "default_result") String.of_json)
      }
  end
module AttachLoadBalancerTargetGroupsResultType =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module PutLifecycleHookAnswer =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module DeleteLifecycleHookType =
  struct
    type t =
      {
      lifecycle_hook_name: String.t ;
      auto_scaling_group_name: String.t }
    let make ~lifecycle_hook_name  ~auto_scaling_group_name  () =
      { lifecycle_hook_name; auto_scaling_group_name }
    let parse xml =
      Some
        {
          lifecycle_hook_name =
            (Xml.required "LifecycleHookName"
               (Util.option_bind (Xml.member "LifecycleHookName" xml)
                  String.parse));
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "LifecycleHookName"
                  ([], (String.to_xml v.lifecycle_hook_name)))])
           @
           [Some
              (Ezxmlm.make_tag "AutoScalingGroupName"
                 ([], (String.to_xml v.auto_scaling_group_name)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("auto_scaling_group_name",
                (String.to_json v.auto_scaling_group_name));
           Some
             ("lifecycle_hook_name", (String.to_json v.lifecycle_hook_name))])
    let of_json j =
      {
        lifecycle_hook_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "lifecycle_hook_name")));
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")))
      }
  end
module DetachInstancesQuery =
  struct
    type t =
      {
      instance_ids: InstanceIds.t ;
      auto_scaling_group_name: String.t ;
      should_decrement_desired_capacity: Boolean.t }
    let make ?(instance_ids= [])  ~auto_scaling_group_name 
      ~should_decrement_desired_capacity  () =
      {
        instance_ids;
        auto_scaling_group_name;
        should_decrement_desired_capacity
      }
    let parse xml =
      Some
        {
          instance_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "InstanceIds" xml)
                  InstanceIds.parse));
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          should_decrement_desired_capacity =
            (Xml.required "ShouldDecrementDesiredCapacity"
               (Util.option_bind
                  (Xml.member "ShouldDecrementDesiredCapacity" xml)
                  Boolean.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "InstanceIds"
                        ([], (InstanceIds.to_xml [x])))) v.instance_ids))
            @
            [Some
               (Ezxmlm.make_tag "AutoScalingGroupName"
                  ([], (String.to_xml v.auto_scaling_group_name)))])
           @
           [Some
              (Ezxmlm.make_tag "ShouldDecrementDesiredCapacity"
                 ([], (Boolean.to_xml v.should_decrement_desired_capacity)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("should_decrement_desired_capacity",
                (Boolean.to_json v.should_decrement_desired_capacity));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name));
           Some ("instance_ids", (InstanceIds.to_json v.instance_ids))])
    let of_json j =
      {
        instance_ids =
          (InstanceIds.of_json
             (Util.of_option_exn (Json.lookup j "instance_ids")));
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        should_decrement_desired_capacity =
          (Boolean.of_json
             (Util.of_option_exn
                (Json.lookup j "should_decrement_desired_capacity")))
      }
  end
module ScalingProcessQuery =
  struct
    type t =
      {
      auto_scaling_group_name: String.t ;
      scaling_processes: ProcessNames.t }
    let make ~auto_scaling_group_name  ?(scaling_processes= [])  () =
      { auto_scaling_group_name; scaling_processes }
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          scaling_processes =
            (Util.of_option []
               (Util.option_bind (Xml.member "ScalingProcesses" xml)
                  ProcessNames.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "AutoScalingGroupName"
                  ([], (String.to_xml v.auto_scaling_group_name)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "ScalingProcesses"
                      ([], (ProcessNames.to_xml [x])))) v.scaling_processes))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("scaling_processes",
                (ProcessNames.to_json v.scaling_processes));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name))])
    let of_json j =
      {
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        scaling_processes =
          (ProcessNames.of_json
             (Util.of_option_exn (Json.lookup j "scaling_processes")))
      }
  end
module DetachLoadBalancersType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t ;
      load_balancer_names: LoadBalancerNames.t }
    let make ~auto_scaling_group_name  ~load_balancer_names  () =
      { auto_scaling_group_name; load_balancer_names }
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          load_balancer_names =
            (Xml.required "LoadBalancerNames"
               (Util.option_bind (Xml.member "LoadBalancerNames" xml)
                  LoadBalancerNames.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "AutoScalingGroupName"
                  ([], (String.to_xml v.auto_scaling_group_name)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "LoadBalancerNames"
                      ([], (LoadBalancerNames.to_xml [x]))))
              v.load_balancer_names))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("load_balancer_names",
                (LoadBalancerNames.to_json v.load_balancer_names));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name))])
    let of_json j =
      {
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        load_balancer_names =
          (LoadBalancerNames.of_json
             (Util.of_option_exn (Json.lookup j "load_balancer_names")))
      }
  end
module ResourceInUseFault =
  struct
    type t = {
      message: String.t option }
    let make ?message  () = { message }
    let parse xml =
      Some
        {
          message =
            (Util.option_bind (Xml.member "message" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.message
              (fun f -> Ezxmlm.make_tag "message" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.message
              (fun f -> ("message", (String.to_json f)))])
    let of_json j =
      { message = (Util.option_map (Json.lookup j "message") String.of_json)
      }
  end
module AttachLoadBalancerTargetGroupsType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t ;
      target_group_a_r_ns: TargetGroupARNs.t }
    let make ~auto_scaling_group_name  ~target_group_a_r_ns  () =
      { auto_scaling_group_name; target_group_a_r_ns }
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          target_group_a_r_ns =
            (Xml.required "TargetGroupARNs"
               (Util.option_bind (Xml.member "TargetGroupARNs" xml)
                  TargetGroupARNs.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "AutoScalingGroupName"
                  ([], (String.to_xml v.auto_scaling_group_name)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "TargetGroupARNs"
                      ([], (TargetGroupARNs.to_xml [x]))))
              v.target_group_a_r_ns))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("target_group_a_r_ns",
                (TargetGroupARNs.to_json v.target_group_a_r_ns));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name))])
    let of_json j =
      {
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        target_group_a_r_ns =
          (TargetGroupARNs.of_json
             (Util.of_option_exn (Json.lookup j "target_group_a_r_ns")))
      }
  end
module DescribeLoadBalancersRequest =
  struct
    type t =
      {
      auto_scaling_group_name: String.t ;
      next_token: String.t option ;
      max_records: Integer.t option }
    let make ~auto_scaling_group_name  ?next_token  ?max_records  () =
      { auto_scaling_group_name; next_token; max_records }
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "AutoScalingGroupName"
                   ([], (String.to_xml v.auto_scaling_group_name)))])
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_records
              (fun f -> Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_records
              (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name))])
    let of_json j =
      {
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json);
        max_records =
          (Util.option_map (Json.lookup j "max_records") Integer.of_json)
      }
  end
module AttachLoadBalancersType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t ;
      load_balancer_names: LoadBalancerNames.t }
    let make ~auto_scaling_group_name  ~load_balancer_names  () =
      { auto_scaling_group_name; load_balancer_names }
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          load_balancer_names =
            (Xml.required "LoadBalancerNames"
               (Util.option_bind (Xml.member "LoadBalancerNames" xml)
                  LoadBalancerNames.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "AutoScalingGroupName"
                  ([], (String.to_xml v.auto_scaling_group_name)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "LoadBalancerNames"
                      ([], (LoadBalancerNames.to_xml [x]))))
              v.load_balancer_names))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("load_balancer_names",
                (LoadBalancerNames.to_json v.load_balancer_names));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name))])
    let of_json j =
      {
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        load_balancer_names =
          (LoadBalancerNames.of_json
             (Util.of_option_exn (Json.lookup j "load_balancer_names")))
      }
  end
module SetInstanceProtectionAnswer =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module DetachLoadBalancerTargetGroupsResultType =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module RecordLifecycleActionHeartbeatType =
  struct
    type t =
      {
      lifecycle_hook_name: String.t ;
      auto_scaling_group_name: String.t ;
      lifecycle_action_token: String.t option ;
      instance_id: String.t option }
    let make ~lifecycle_hook_name  ~auto_scaling_group_name 
      ?lifecycle_action_token  ?instance_id  () =
      {
        lifecycle_hook_name;
        auto_scaling_group_name;
        lifecycle_action_token;
        instance_id
      }
    let parse xml =
      Some
        {
          lifecycle_hook_name =
            (Xml.required "LifecycleHookName"
               (Util.option_bind (Xml.member "LifecycleHookName" xml)
                  String.parse));
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          lifecycle_action_token =
            (Util.option_bind (Xml.member "LifecycleActionToken" xml)
               String.parse);
          instance_id =
            (Util.option_bind (Xml.member "InstanceId" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "LifecycleHookName"
                    ([], (String.to_xml v.lifecycle_hook_name)))])
             @
             [Some
                (Ezxmlm.make_tag "AutoScalingGroupName"
                   ([], (String.to_xml v.auto_scaling_group_name)))])
            @
            [Util.option_map v.lifecycle_action_token
               (fun f ->
                  Ezxmlm.make_tag "LifecycleActionToken"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.instance_id
              (fun f -> Ezxmlm.make_tag "InstanceId" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.instance_id
              (fun f -> ("instance_id", (String.to_json f)));
           Util.option_map v.lifecycle_action_token
             (fun f -> ("lifecycle_action_token", (String.to_json f)));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name));
           Some
             ("lifecycle_hook_name", (String.to_json v.lifecycle_hook_name))])
    let of_json j =
      {
        lifecycle_hook_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "lifecycle_hook_name")));
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        lifecycle_action_token =
          (Util.option_map (Json.lookup j "lifecycle_action_token")
             String.of_json);
        instance_id =
          (Util.option_map (Json.lookup j "instance_id") String.of_json)
      }
  end
module AutoScalingInstancesType =
  struct
    type t =
      {
      auto_scaling_instances: AutoScalingInstances.t ;
      next_token: String.t option }
    let make ?(auto_scaling_instances= [])  ?next_token  () =
      { auto_scaling_instances; next_token }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("auto_scaling_instances",
               (AutoScalingInstances.to_json v.auto_scaling_instances))])
    let of_json j =
      {
        auto_scaling_instances =
          (AutoScalingInstances.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_instances")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module PutNotificationConfigurationType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t ;
      topic_a_r_n: String.t ;
      notification_types: AutoScalingNotificationTypes.t }
    let make ~auto_scaling_group_name  ~topic_a_r_n  ~notification_types  ()
      = { auto_scaling_group_name; topic_a_r_n; notification_types }
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          topic_a_r_n =
            (Xml.required "TopicARN"
               (Util.option_bind (Xml.member "TopicARN" xml) String.parse));
          notification_types =
            (Xml.required "NotificationTypes"
               (Util.option_bind (Xml.member "NotificationTypes" xml)
                  AutoScalingNotificationTypes.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "AutoScalingGroupName"
                   ([], (String.to_xml v.auto_scaling_group_name)))])
            @
            [Some
               (Ezxmlm.make_tag "TopicARN"
                  ([], (String.to_xml v.topic_a_r_n)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "NotificationTypes"
                      ([], (AutoScalingNotificationTypes.to_xml [x]))))
              v.notification_types))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("notification_types",
                (AutoScalingNotificationTypes.to_json v.notification_types));
           Some ("topic_a_r_n", (String.to_json v.topic_a_r_n));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name))])
    let of_json j =
      {
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        topic_a_r_n =
          (String.of_json (Util.of_option_exn (Json.lookup j "topic_a_r_n")));
        notification_types =
          (AutoScalingNotificationTypes.of_json
             (Util.of_option_exn (Json.lookup j "notification_types")))
      }
  end
module BatchPutScheduledUpdateGroupActionAnswer =
  struct
    type t =
      {
      failed_scheduled_update_group_actions:
        FailedScheduledUpdateGroupActionRequests.t }
    let make ?(failed_scheduled_update_group_actions= [])  () =
      { failed_scheduled_update_group_actions }
    let parse xml =
      Some
        {
          failed_scheduled_update_group_actions =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "FailedScheduledUpdateGroupActions" xml)
                  FailedScheduledUpdateGroupActionRequests.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("failed_scheduled_update_group_actions",
                (FailedScheduledUpdateGroupActionRequests.to_json
                   v.failed_scheduled_update_group_actions))])
    let of_json j =
      {
        failed_scheduled_update_group_actions =
          (FailedScheduledUpdateGroupActionRequests.of_json
             (Util.of_option_exn
                (Json.lookup j "failed_scheduled_update_group_actions")))
      }
  end
module PoliciesType =
  struct
    type t =
      {
      scaling_policies: ScalingPolicies.t ;
      next_token: String.t option }
    let make ?(scaling_policies= [])  ?next_token  () =
      { scaling_policies; next_token }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("scaling_policies",
               (ScalingPolicies.to_json v.scaling_policies))])
    let of_json j =
      {
        scaling_policies =
          (ScalingPolicies.of_json
             (Util.of_option_exn (Json.lookup j "scaling_policies")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module UpdateAutoScalingGroupType =
  struct
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        launch_configuration_name =
          (Util.option_map (Json.lookup j "launch_configuration_name")
             String.of_json);
        launch_template =
          (Util.option_map (Json.lookup j "launch_template")
             LaunchTemplateSpecification.of_json);
        mixed_instances_policy =
          (Util.option_map (Json.lookup j "mixed_instances_policy")
             MixedInstancesPolicy.of_json);
        min_size =
          (Util.option_map (Json.lookup j "min_size") Integer.of_json);
        max_size =
          (Util.option_map (Json.lookup j "max_size") Integer.of_json);
        desired_capacity =
          (Util.option_map (Json.lookup j "desired_capacity") Integer.of_json);
        default_cooldown =
          (Util.option_map (Json.lookup j "default_cooldown") Integer.of_json);
        availability_zones =
          (AvailabilityZones.of_json
             (Util.of_option_exn (Json.lookup j "availability_zones")));
        health_check_type =
          (Util.option_map (Json.lookup j "health_check_type") String.of_json);
        health_check_grace_period =
          (Util.option_map (Json.lookup j "health_check_grace_period")
             Integer.of_json);
        placement_group =
          (Util.option_map (Json.lookup j "placement_group") String.of_json);
        v_p_c_zone_identifier =
          (Util.option_map (Json.lookup j "v_p_c_zone_identifier")
             String.of_json);
        termination_policies =
          (TerminationPolicies.of_json
             (Util.of_option_exn (Json.lookup j "termination_policies")));
        new_instances_protected_from_scale_in =
          (Util.option_map
             (Json.lookup j "new_instances_protected_from_scale_in")
             Boolean.of_json);
        service_linked_role_a_r_n =
          (Util.option_map (Json.lookup j "service_linked_role_a_r_n")
             String.of_json);
        max_instance_lifetime =
          (Util.option_map (Json.lookup j "max_instance_lifetime")
             Integer.of_json)
      }
  end
module CreateAutoScalingGroupType =
  struct
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        launch_configuration_name =
          (Util.option_map (Json.lookup j "launch_configuration_name")
             String.of_json);
        launch_template =
          (Util.option_map (Json.lookup j "launch_template")
             LaunchTemplateSpecification.of_json);
        mixed_instances_policy =
          (Util.option_map (Json.lookup j "mixed_instances_policy")
             MixedInstancesPolicy.of_json);
        instance_id =
          (Util.option_map (Json.lookup j "instance_id") String.of_json);
        min_size =
          (Integer.of_json (Util.of_option_exn (Json.lookup j "min_size")));
        max_size =
          (Integer.of_json (Util.of_option_exn (Json.lookup j "max_size")));
        desired_capacity =
          (Util.option_map (Json.lookup j "desired_capacity") Integer.of_json);
        default_cooldown =
          (Util.option_map (Json.lookup j "default_cooldown") Integer.of_json);
        availability_zones =
          (AvailabilityZones.of_json
             (Util.of_option_exn (Json.lookup j "availability_zones")));
        load_balancer_names =
          (LoadBalancerNames.of_json
             (Util.of_option_exn (Json.lookup j "load_balancer_names")));
        target_group_a_r_ns =
          (TargetGroupARNs.of_json
             (Util.of_option_exn (Json.lookup j "target_group_a_r_ns")));
        health_check_type =
          (Util.option_map (Json.lookup j "health_check_type") String.of_json);
        health_check_grace_period =
          (Util.option_map (Json.lookup j "health_check_grace_period")
             Integer.of_json);
        placement_group =
          (Util.option_map (Json.lookup j "placement_group") String.of_json);
        v_p_c_zone_identifier =
          (Util.option_map (Json.lookup j "v_p_c_zone_identifier")
             String.of_json);
        termination_policies =
          (TerminationPolicies.of_json
             (Util.of_option_exn (Json.lookup j "termination_policies")));
        new_instances_protected_from_scale_in =
          (Util.option_map
             (Json.lookup j "new_instances_protected_from_scale_in")
             Boolean.of_json);
        lifecycle_hook_specification_list =
          (LifecycleHookSpecifications.of_json
             (Util.of_option_exn
                (Json.lookup j "lifecycle_hook_specification_list")));
        tags = (Tags.of_json (Util.of_option_exn (Json.lookup j "tags")));
        service_linked_role_a_r_n =
          (Util.option_map (Json.lookup j "service_linked_role_a_r_n")
             String.of_json);
        max_instance_lifetime =
          (Util.option_map (Json.lookup j "max_instance_lifetime")
             Integer.of_json)
      }
  end
module TagsType =
  struct
    type t = {
      tags: TagDescriptionList.t ;
      next_token: String.t option }
    let make ?(tags= [])  ?next_token  () = { tags; next_token }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("tags", (TagDescriptionList.to_json v.tags))])
    let of_json j =
      {
        tags =
          (TagDescriptionList.of_json
             (Util.of_option_exn (Json.lookup j "tags")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module AttachLoadBalancersResultType =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module DescribeScalingActivitiesType =
  struct
    type t =
      {
      activity_ids: ActivityIds.t ;
      auto_scaling_group_name: String.t option ;
      max_records: Integer.t option ;
      next_token: String.t option }
    let make ?(activity_ids= [])  ?auto_scaling_group_name  ?max_records 
      ?next_token  () =
      { activity_ids; auto_scaling_group_name; max_records; next_token }
    let parse xml =
      Some
        {
          activity_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "ActivityIds" xml)
                  ActivityIds.parse));
          auto_scaling_group_name =
            (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
               String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "ActivityIds"
                         ([], (ActivityIds.to_xml [x])))) v.activity_ids))
             @
             [Util.option_map v.auto_scaling_group_name
                (fun f ->
                   Ezxmlm.make_tag "AutoScalingGroupName"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.max_records
               (fun f ->
                  Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.auto_scaling_group_name
             (fun f -> ("auto_scaling_group_name", (String.to_json f)));
           Some ("activity_ids", (ActivityIds.to_json v.activity_ids))])
    let of_json j =
      {
        activity_ids =
          (ActivityIds.of_json
             (Util.of_option_exn (Json.lookup j "activity_ids")));
        auto_scaling_group_name =
          (Util.option_map (Json.lookup j "auto_scaling_group_name")
             String.of_json);
        max_records =
          (Util.option_map (Json.lookup j "max_records") Integer.of_json);
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module DeleteScheduledActionType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t ;
      scheduled_action_name: String.t }
    let make ~auto_scaling_group_name  ~scheduled_action_name  () =
      { auto_scaling_group_name; scheduled_action_name }
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          scheduled_action_name =
            (Xml.required "ScheduledActionName"
               (Util.option_bind (Xml.member "ScheduledActionName" xml)
                  String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "AutoScalingGroupName"
                  ([], (String.to_xml v.auto_scaling_group_name)))])
           @
           [Some
              (Ezxmlm.make_tag "ScheduledActionName"
                 ([], (String.to_xml v.scheduled_action_name)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("scheduled_action_name",
                (String.to_json v.scheduled_action_name));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name))])
    let of_json j =
      {
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        scheduled_action_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "scheduled_action_name")))
      }
  end
module DescribeLifecycleHooksAnswer =
  struct
    type t = {
      lifecycle_hooks: LifecycleHooks.t }
    let make ?(lifecycle_hooks= [])  () = { lifecycle_hooks }
    let parse xml =
      Some
        {
          lifecycle_hooks =
            (Util.of_option []
               (Util.option_bind (Xml.member "LifecycleHooks" xml)
                  LifecycleHooks.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "LifecycleHooks"
                      ([], (LifecycleHooks.to_xml [x])))) v.lifecycle_hooks))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("lifecycle_hooks", (LifecycleHooks.to_json v.lifecycle_hooks))])
    let of_json j =
      {
        lifecycle_hooks =
          (LifecycleHooks.of_json
             (Util.of_option_exn (Json.lookup j "lifecycle_hooks")))
      }
  end
module SetDesiredCapacityType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t ;
      desired_capacity: Integer.t ;
      honor_cooldown: Boolean.t option }
    let make ~auto_scaling_group_name  ~desired_capacity  ?honor_cooldown  ()
      = { auto_scaling_group_name; desired_capacity; honor_cooldown }
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          desired_capacity =
            (Xml.required "DesiredCapacity"
               (Util.option_bind (Xml.member "DesiredCapacity" xml)
                  Integer.parse));
          honor_cooldown =
            (Util.option_bind (Xml.member "HonorCooldown" xml) Boolean.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "AutoScalingGroupName"
                   ([], (String.to_xml v.auto_scaling_group_name)))])
            @
            [Some
               (Ezxmlm.make_tag "DesiredCapacity"
                  ([], (Integer.to_xml v.desired_capacity)))])
           @
           [Util.option_map v.honor_cooldown
              (fun f ->
                 Ezxmlm.make_tag "HonorCooldown" ([], (Boolean.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.honor_cooldown
              (fun f -> ("honor_cooldown", (Boolean.to_json f)));
           Some ("desired_capacity", (Integer.to_json v.desired_capacity));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name))])
    let of_json j =
      {
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        desired_capacity =
          (Integer.of_json
             (Util.of_option_exn (Json.lookup j "desired_capacity")));
        honor_cooldown =
          (Util.option_map (Json.lookup j "honor_cooldown") Boolean.of_json)
      }
  end
module DescribeLoadBalancerTargetGroupsResponse =
  struct
    type t =
      {
      load_balancer_target_groups: LoadBalancerTargetGroupStates.t ;
      next_token: String.t option }
    let make ?(load_balancer_target_groups= [])  ?next_token  () =
      { load_balancer_target_groups; next_token }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("load_balancer_target_groups",
               (LoadBalancerTargetGroupStates.to_json
                  v.load_balancer_target_groups))])
    let of_json j =
      {
        load_balancer_target_groups =
          (LoadBalancerTargetGroupStates.of_json
             (Util.of_option_exn
                (Json.lookup j "load_balancer_target_groups")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module DetachInstancesAnswer =
  struct
    type t = {
      activities: Activities.t }
    let make ?(activities= [])  () = { activities }
    let parse xml =
      Some
        {
          activities =
            (Util.of_option []
               (Util.option_bind (Xml.member "Activities" xml)
                  Activities.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Activities"
                      ([], (Activities.to_xml [x])))) v.activities))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("activities", (Activities.to_json v.activities))])
    let of_json j =
      {
        activities =
          (Activities.of_json
             (Util.of_option_exn (Json.lookup j "activities")))
      }
  end
module LaunchConfigurationNamesType =
  struct
    type t =
      {
      launch_configuration_names: LaunchConfigurationNames.t ;
      next_token: String.t option ;
      max_records: Integer.t option }
    let make ?(launch_configuration_names= [])  ?next_token  ?max_records  ()
      = { launch_configuration_names; next_token; max_records }
    let parse xml =
      Some
        {
          launch_configuration_names =
            (Util.of_option []
               (Util.option_bind (Xml.member "LaunchConfigurationNames" xml)
                  LaunchConfigurationNames.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "LaunchConfigurationNames"
                        ([], (LaunchConfigurationNames.to_xml [x]))))
                v.launch_configuration_names))
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_records
              (fun f -> Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_records
              (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Some
             ("launch_configuration_names",
               (LaunchConfigurationNames.to_json v.launch_configuration_names))])
    let of_json j =
      {
        launch_configuration_names =
          (LaunchConfigurationNames.of_json
             (Util.of_option_exn (Json.lookup j "launch_configuration_names")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json);
        max_records =
          (Util.option_map (Json.lookup j "max_records") Integer.of_json)
      }
  end
module DetachLoadBalancersResultType =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module LimitExceededFault =
  struct
    type t = {
      message: String.t option }
    let make ?message  () = { message }
    let parse xml =
      Some
        {
          message =
            (Util.option_bind (Xml.member "message" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.message
              (fun f -> Ezxmlm.make_tag "message" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.message
              (fun f -> ("message", (String.to_json f)))])
    let of_json j =
      { message = (Util.option_map (Json.lookup j "message") String.of_json)
      }
  end
module DescribeLifecycleHookTypesAnswer =
  struct
    type t = {
      lifecycle_hook_types: AutoScalingNotificationTypes.t }
    let make ?(lifecycle_hook_types= [])  () = { lifecycle_hook_types }
    let parse xml =
      Some
        {
          lifecycle_hook_types =
            (Util.of_option []
               (Util.option_bind (Xml.member "LifecycleHookTypes" xml)
                  AutoScalingNotificationTypes.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "LifecycleHookTypes"
                      ([], (AutoScalingNotificationTypes.to_xml [x]))))
              v.lifecycle_hook_types))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("lifecycle_hook_types",
                (AutoScalingNotificationTypes.to_json v.lifecycle_hook_types))])
    let of_json j =
      {
        lifecycle_hook_types =
          (AutoScalingNotificationTypes.of_json
             (Util.of_option_exn (Json.lookup j "lifecycle_hook_types")))
      }
  end
module CreateLaunchConfigurationType =
  struct
    type t =
      {
      launch_configuration_name: String.t ;
      image_id: String.t option ;
      key_name: String.t option ;
      security_groups: SecurityGroups.t ;
      classic_link_v_p_c_id: String.t option ;
      classic_link_v_p_c_security_groups: ClassicLinkVPCSecurityGroups.t ;
      user_data: String.t option ;
      instance_id: String.t option ;
      instance_type: String.t option ;
      kernel_id: String.t option ;
      ramdisk_id: String.t option ;
      block_device_mappings: BlockDeviceMappings.t ;
      instance_monitoring: InstanceMonitoring.t option ;
      spot_price: String.t option ;
      iam_instance_profile: String.t option ;
      ebs_optimized: Boolean.t option ;
      associate_public_ip_address: Boolean.t option ;
      placement_tenancy: String.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        launch_configuration_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "launch_configuration_name")));
        image_id =
          (Util.option_map (Json.lookup j "image_id") String.of_json);
        key_name =
          (Util.option_map (Json.lookup j "key_name") String.of_json);
        security_groups =
          (SecurityGroups.of_json
             (Util.of_option_exn (Json.lookup j "security_groups")));
        classic_link_v_p_c_id =
          (Util.option_map (Json.lookup j "classic_link_v_p_c_id")
             String.of_json);
        classic_link_v_p_c_security_groups =
          (ClassicLinkVPCSecurityGroups.of_json
             (Util.of_option_exn
                (Json.lookup j "classic_link_v_p_c_security_groups")));
        user_data =
          (Util.option_map (Json.lookup j "user_data") String.of_json);
        instance_id =
          (Util.option_map (Json.lookup j "instance_id") String.of_json);
        instance_type =
          (Util.option_map (Json.lookup j "instance_type") String.of_json);
        kernel_id =
          (Util.option_map (Json.lookup j "kernel_id") String.of_json);
        ramdisk_id =
          (Util.option_map (Json.lookup j "ramdisk_id") String.of_json);
        block_device_mappings =
          (BlockDeviceMappings.of_json
             (Util.of_option_exn (Json.lookup j "block_device_mappings")));
        instance_monitoring =
          (Util.option_map (Json.lookup j "instance_monitoring")
             InstanceMonitoring.of_json);
        spot_price =
          (Util.option_map (Json.lookup j "spot_price") String.of_json);
        iam_instance_profile =
          (Util.option_map (Json.lookup j "iam_instance_profile")
             String.of_json);
        ebs_optimized =
          (Util.option_map (Json.lookup j "ebs_optimized") Boolean.of_json);
        associate_public_ip_address =
          (Util.option_map (Json.lookup j "associate_public_ip_address")
             Boolean.of_json);
        placement_tenancy =
          (Util.option_map (Json.lookup j "placement_tenancy") String.of_json)
      }
  end
module PutScheduledUpdateGroupActionType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t ;
      scheduled_action_name: String.t ;
      time: DateTime.t option ;
      start_time: DateTime.t option ;
      end_time: DateTime.t option ;
      recurrence: String.t option ;
      min_size: Integer.t option ;
      max_size: Integer.t option ;
      desired_capacity: Integer.t option }
    let make ~auto_scaling_group_name  ~scheduled_action_name  ?time 
      ?start_time  ?end_time  ?recurrence  ?min_size  ?max_size 
      ?desired_capacity  () =
      {
        auto_scaling_group_name;
        scheduled_action_name;
        time;
        start_time;
        end_time;
        recurrence;
        min_size;
        max_size;
        desired_capacity
      }
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          scheduled_action_name =
            (Xml.required "ScheduledActionName"
               (Util.option_bind (Xml.member "ScheduledActionName" xml)
                  String.parse));
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Some
                      (Ezxmlm.make_tag "AutoScalingGroupName"
                         ([], (String.to_xml v.auto_scaling_group_name)))])
                  @
                  [Some
                     (Ezxmlm.make_tag "ScheduledActionName"
                        ([], (String.to_xml v.scheduled_action_name)))])
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
           Some
             ("scheduled_action_name",
               (String.to_json v.scheduled_action_name));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name))])
    let of_json j =
      {
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        scheduled_action_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "scheduled_action_name")));
        time = (Util.option_map (Json.lookup j "time") DateTime.of_json);
        start_time =
          (Util.option_map (Json.lookup j "start_time") DateTime.of_json);
        end_time =
          (Util.option_map (Json.lookup j "end_time") DateTime.of_json);
        recurrence =
          (Util.option_map (Json.lookup j "recurrence") String.of_json);
        min_size =
          (Util.option_map (Json.lookup j "min_size") Integer.of_json);
        max_size =
          (Util.option_map (Json.lookup j "max_size") Integer.of_json);
        desired_capacity =
          (Util.option_map (Json.lookup j "desired_capacity") Integer.of_json)
      }
  end
module AlreadyExistsFault =
  struct
    type t = {
      message: String.t option }
    let make ?message  () = { message }
    let parse xml =
      Some
        {
          message =
            (Util.option_bind (Xml.member "message" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.message
              (fun f -> Ezxmlm.make_tag "message" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.message
              (fun f -> ("message", (String.to_json f)))])
    let of_json j =
      { message = (Util.option_map (Json.lookup j "message") String.of_json)
      }
  end
module DeleteNotificationConfigurationType =
  struct
    type t = {
      auto_scaling_group_name: String.t ;
      topic_a_r_n: String.t }
    let make ~auto_scaling_group_name  ~topic_a_r_n  () =
      { auto_scaling_group_name; topic_a_r_n }
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          topic_a_r_n =
            (Xml.required "TopicARN"
               (Util.option_bind (Xml.member "TopicARN" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "AutoScalingGroupName"
                  ([], (String.to_xml v.auto_scaling_group_name)))])
           @
           [Some
              (Ezxmlm.make_tag "TopicARN" ([], (String.to_xml v.topic_a_r_n)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("topic_a_r_n", (String.to_json v.topic_a_r_n));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name))])
    let of_json j =
      {
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        topic_a_r_n =
          (String.of_json (Util.of_option_exn (Json.lookup j "topic_a_r_n")))
      }
  end
module DetachLoadBalancerTargetGroupsType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t ;
      target_group_a_r_ns: TargetGroupARNs.t }
    let make ~auto_scaling_group_name  ~target_group_a_r_ns  () =
      { auto_scaling_group_name; target_group_a_r_ns }
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          target_group_a_r_ns =
            (Xml.required "TargetGroupARNs"
               (Util.option_bind (Xml.member "TargetGroupARNs" xml)
                  TargetGroupARNs.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "AutoScalingGroupName"
                  ([], (String.to_xml v.auto_scaling_group_name)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "TargetGroupARNs"
                      ([], (TargetGroupARNs.to_xml [x]))))
              v.target_group_a_r_ns))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("target_group_a_r_ns",
                (TargetGroupARNs.to_json v.target_group_a_r_ns));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name))])
    let of_json j =
      {
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        target_group_a_r_ns =
          (TargetGroupARNs.of_json
             (Util.of_option_exn (Json.lookup j "target_group_a_r_ns")))
      }
  end
module DescribeAccountLimitsAnswer =
  struct
    type t =
      {
      max_number_of_auto_scaling_groups: Integer.t option ;
      max_number_of_launch_configurations: Integer.t option ;
      number_of_auto_scaling_groups: Integer.t option ;
      number_of_launch_configurations: Integer.t option }
    let make ?max_number_of_auto_scaling_groups 
      ?max_number_of_launch_configurations  ?number_of_auto_scaling_groups 
      ?number_of_launch_configurations  () =
      {
        max_number_of_auto_scaling_groups;
        max_number_of_launch_configurations;
        number_of_auto_scaling_groups;
        number_of_launch_configurations
      }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        max_number_of_auto_scaling_groups =
          (Util.option_map
             (Json.lookup j "max_number_of_auto_scaling_groups")
             Integer.of_json);
        max_number_of_launch_configurations =
          (Util.option_map
             (Json.lookup j "max_number_of_launch_configurations")
             Integer.of_json);
        number_of_auto_scaling_groups =
          (Util.option_map (Json.lookup j "number_of_auto_scaling_groups")
             Integer.of_json);
        number_of_launch_configurations =
          (Util.option_map (Json.lookup j "number_of_launch_configurations")
             Integer.of_json)
      }
  end
module ServiceLinkedRoleFailure =
  struct
    type t = {
      message: String.t option }
    let make ?message  () = { message }
    let parse xml =
      Some
        {
          message =
            (Util.option_bind (Xml.member "message" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.message
              (fun f -> Ezxmlm.make_tag "message" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.message
              (fun f -> ("message", (String.to_json f)))])
    let of_json j =
      { message = (Util.option_map (Json.lookup j "message") String.of_json)
      }
  end
module DeleteTagsType =
  struct
    type t = {
      tags: Tags.t }
    let make ~tags  () = { tags }
    let parse xml =
      Some
        {
          tags =
            (Xml.required "Tags"
               (Util.option_bind (Xml.member "Tags" xml) Tags.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x -> Some (Ezxmlm.make_tag "Tags" ([], (Tags.to_xml [x]))))
              v.tags))
    let to_json v =
      `Assoc (Util.list_filter_opt [Some ("tags", (Tags.to_json v.tags))])
    let of_json j =
      { tags = (Tags.of_json (Util.of_option_exn (Json.lookup j "tags"))) }
  end
module DescribeTerminationPolicyTypesAnswer =
  struct
    type t = {
      termination_policy_types: TerminationPolicies.t }
    let make ?(termination_policy_types= [])  () =
      { termination_policy_types }
    let parse xml =
      Some
        {
          termination_policy_types =
            (Util.of_option []
               (Util.option_bind (Xml.member "TerminationPolicyTypes" xml)
                  TerminationPolicies.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "TerminationPolicyTypes"
                      ([], (TerminationPolicies.to_xml [x]))))
              v.termination_policy_types))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("termination_policy_types",
                (TerminationPolicies.to_json v.termination_policy_types))])
    let of_json j =
      {
        termination_policy_types =
          (TerminationPolicies.of_json
             (Util.of_option_exn (Json.lookup j "termination_policy_types")))
      }
  end
module DescribeAdjustmentTypesAnswer =
  struct
    type t = {
      adjustment_types: AdjustmentTypes.t }
    let make ?(adjustment_types= [])  () = { adjustment_types }
    let parse xml =
      Some
        {
          adjustment_types =
            (Util.of_option []
               (Util.option_bind (Xml.member "AdjustmentTypes" xml)
                  AdjustmentTypes.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "AdjustmentTypes"
                      ([], (AdjustmentTypes.to_xml [x])))) v.adjustment_types))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("adjustment_types",
                (AdjustmentTypes.to_json v.adjustment_types))])
    let of_json j =
      {
        adjustment_types =
          (AdjustmentTypes.of_json
             (Util.of_option_exn (Json.lookup j "adjustment_types")))
      }
  end
module AutoScalingGroupsType =
  struct
    type t =
      {
      auto_scaling_groups: AutoScalingGroups.t ;
      next_token: String.t option }
    let make ~auto_scaling_groups  ?next_token  () =
      { auto_scaling_groups; next_token }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("auto_scaling_groups",
               (AutoScalingGroups.to_json v.auto_scaling_groups))])
    let of_json j =
      {
        auto_scaling_groups =
          (AutoScalingGroups.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_groups")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module ExecutePolicyType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t option ;
      policy_name: String.t ;
      honor_cooldown: Boolean.t option ;
      metric_value: Double.t option ;
      breach_threshold: Double.t option }
    let make ?auto_scaling_group_name  ~policy_name  ?honor_cooldown 
      ?metric_value  ?breach_threshold  () =
      {
        auto_scaling_group_name;
        policy_name;
        honor_cooldown;
        metric_value;
        breach_threshold
      }
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
               String.parse);
          policy_name =
            (Xml.required "PolicyName"
               (Util.option_bind (Xml.member "PolicyName" xml) String.parse));
          honor_cooldown =
            (Util.option_bind (Xml.member "HonorCooldown" xml) Boolean.parse);
          metric_value =
            (Util.option_bind (Xml.member "MetricValue" xml) Double.parse);
          breach_threshold =
            (Util.option_bind (Xml.member "BreachThreshold" xml) Double.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.auto_scaling_group_name
                  (fun f ->
                     Ezxmlm.make_tag "AutoScalingGroupName"
                       ([], (String.to_xml f)))])
              @
              [Some
                 (Ezxmlm.make_tag "PolicyName"
                    ([], (String.to_xml v.policy_name)))])
             @
             [Util.option_map v.honor_cooldown
                (fun f ->
                   Ezxmlm.make_tag "HonorCooldown" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.metric_value
               (fun f ->
                  Ezxmlm.make_tag "MetricValue" ([], (Double.to_xml f)))])
           @
           [Util.option_map v.breach_threshold
              (fun f ->
                 Ezxmlm.make_tag "BreachThreshold" ([], (Double.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.breach_threshold
              (fun f -> ("breach_threshold", (Double.to_json f)));
           Util.option_map v.metric_value
             (fun f -> ("metric_value", (Double.to_json f)));
           Util.option_map v.honor_cooldown
             (fun f -> ("honor_cooldown", (Boolean.to_json f)));
           Some ("policy_name", (String.to_json v.policy_name));
           Util.option_map v.auto_scaling_group_name
             (fun f -> ("auto_scaling_group_name", (String.to_json f)))])
    let of_json j =
      {
        auto_scaling_group_name =
          (Util.option_map (Json.lookup j "auto_scaling_group_name")
             String.of_json);
        policy_name =
          (String.of_json (Util.of_option_exn (Json.lookup j "policy_name")));
        honor_cooldown =
          (Util.option_map (Json.lookup j "honor_cooldown") Boolean.of_json);
        metric_value =
          (Util.option_map (Json.lookup j "metric_value") Double.of_json);
        breach_threshold =
          (Util.option_map (Json.lookup j "breach_threshold") Double.of_json)
      }
  end
module SetInstanceHealthQuery =
  struct
    type t =
      {
      instance_id: String.t ;
      health_status: String.t ;
      should_respect_grace_period: Boolean.t option }
    let make ~instance_id  ~health_status  ?should_respect_grace_period  () =
      { instance_id; health_status; should_respect_grace_period }
    let parse xml =
      Some
        {
          instance_id =
            (Xml.required "InstanceId"
               (Util.option_bind (Xml.member "InstanceId" xml) String.parse));
          health_status =
            (Xml.required "HealthStatus"
               (Util.option_bind (Xml.member "HealthStatus" xml) String.parse));
          should_respect_grace_period =
            (Util.option_bind (Xml.member "ShouldRespectGracePeriod" xml)
               Boolean.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "InstanceId"
                   ([], (String.to_xml v.instance_id)))])
            @
            [Some
               (Ezxmlm.make_tag "HealthStatus"
                  ([], (String.to_xml v.health_status)))])
           @
           [Util.option_map v.should_respect_grace_period
              (fun f ->
                 Ezxmlm.make_tag "ShouldRespectGracePeriod"
                   ([], (Boolean.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.should_respect_grace_period
              (fun f -> ("should_respect_grace_period", (Boolean.to_json f)));
           Some ("health_status", (String.to_json v.health_status));
           Some ("instance_id", (String.to_json v.instance_id))])
    let of_json j =
      {
        instance_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "instance_id")));
        health_status =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "health_status")));
        should_respect_grace_period =
          (Util.option_map (Json.lookup j "should_respect_grace_period")
             Boolean.of_json)
      }
  end
module PutScalingPolicyType =
  struct
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
    let make ~auto_scaling_group_name  ~policy_name  ?policy_type 
      ?adjustment_type  ?min_adjustment_step  ?min_adjustment_magnitude 
      ?scaling_adjustment  ?cooldown  ?metric_aggregation_type 
      ?(step_adjustments= [])  ?estimated_instance_warmup 
      ?target_tracking_configuration  () =
      {
        auto_scaling_group_name;
        policy_name;
        policy_type;
        adjustment_type;
        min_adjustment_step;
        min_adjustment_magnitude;
        scaling_adjustment;
        cooldown;
        metric_aggregation_type;
        step_adjustments;
        estimated_instance_warmup;
        target_tracking_configuration
      }
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          policy_name =
            (Xml.required "PolicyName"
               (Util.option_bind (Xml.member "PolicyName" xml) String.parse));
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
          metric_aggregation_type =
            (Util.option_bind (Xml.member "MetricAggregationType" xml)
               String.parse);
          step_adjustments =
            (Util.of_option []
               (Util.option_bind (Xml.member "StepAdjustments" xml)
                  StepAdjustments.parse));
          estimated_instance_warmup =
            (Util.option_bind (Xml.member "EstimatedInstanceWarmup" xml)
               Integer.parse);
          target_tracking_configuration =
            (Util.option_bind (Xml.member "TargetTrackingConfiguration" xml)
               TargetTrackingConfiguration.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((((((((((([] @
                      [Some
                         (Ezxmlm.make_tag "AutoScalingGroupName"
                            ([], (String.to_xml v.auto_scaling_group_name)))])
                     @
                     [Some
                        (Ezxmlm.make_tag "PolicyName"
                           ([], (String.to_xml v.policy_name)))])
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
              [Util.option_map v.metric_aggregation_type
                 (fun f ->
                    Ezxmlm.make_tag "MetricAggregationType"
                      ([], (String.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "StepAdjustments"
                        ([], (StepAdjustments.to_xml [x]))))
                v.step_adjustments))
            @
            [Util.option_map v.estimated_instance_warmup
               (fun f ->
                  Ezxmlm.make_tag "EstimatedInstanceWarmup"
                    ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.target_tracking_configuration
              (fun f ->
                 Ezxmlm.make_tag "TargetTrackingConfiguration"
                   ([], (TargetTrackingConfiguration.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.target_tracking_configuration
              (fun f ->
                 ("target_tracking_configuration",
                   (TargetTrackingConfiguration.to_json f)));
           Util.option_map v.estimated_instance_warmup
             (fun f -> ("estimated_instance_warmup", (Integer.to_json f)));
           Some
             ("step_adjustments",
               (StepAdjustments.to_json v.step_adjustments));
           Util.option_map v.metric_aggregation_type
             (fun f -> ("metric_aggregation_type", (String.to_json f)));
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
           Some ("policy_name", (String.to_json v.policy_name));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name))])
    let of_json j =
      {
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        policy_name =
          (String.of_json (Util.of_option_exn (Json.lookup j "policy_name")));
        policy_type =
          (Util.option_map (Json.lookup j "policy_type") String.of_json);
        adjustment_type =
          (Util.option_map (Json.lookup j "adjustment_type") String.of_json);
        min_adjustment_step =
          (Util.option_map (Json.lookup j "min_adjustment_step")
             Integer.of_json);
        min_adjustment_magnitude =
          (Util.option_map (Json.lookup j "min_adjustment_magnitude")
             Integer.of_json);
        scaling_adjustment =
          (Util.option_map (Json.lookup j "scaling_adjustment")
             Integer.of_json);
        cooldown =
          (Util.option_map (Json.lookup j "cooldown") Integer.of_json);
        metric_aggregation_type =
          (Util.option_map (Json.lookup j "metric_aggregation_type")
             String.of_json);
        step_adjustments =
          (StepAdjustments.of_json
             (Util.of_option_exn (Json.lookup j "step_adjustments")));
        estimated_instance_warmup =
          (Util.option_map (Json.lookup j "estimated_instance_warmup")
             Integer.of_json);
        target_tracking_configuration =
          (Util.option_map (Json.lookup j "target_tracking_configuration")
             TargetTrackingConfiguration.of_json)
      }
  end
module BatchDeleteScheduledActionType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t ;
      scheduled_action_names: ScheduledActionNames.t }
    let make ~auto_scaling_group_name  ~scheduled_action_names  () =
      { auto_scaling_group_name; scheduled_action_names }
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          scheduled_action_names =
            (Xml.required "ScheduledActionNames"
               (Util.option_bind (Xml.member "ScheduledActionNames" xml)
                  ScheduledActionNames.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "AutoScalingGroupName"
                  ([], (String.to_xml v.auto_scaling_group_name)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "ScheduledActionNames"
                      ([], (ScheduledActionNames.to_xml [x]))))
              v.scheduled_action_names))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("scheduled_action_names",
                (ScheduledActionNames.to_json v.scheduled_action_names));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name))])
    let of_json j =
      {
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        scheduled_action_names =
          (ScheduledActionNames.of_json
             (Util.of_option_exn (Json.lookup j "scheduled_action_names")))
      }
  end
module EnableMetricsCollectionQuery =
  struct
    type t =
      {
      auto_scaling_group_name: String.t ;
      metrics: Metrics.t ;
      granularity: String.t }
    let make ~auto_scaling_group_name  ?(metrics= [])  ~granularity  () =
      { auto_scaling_group_name; metrics; granularity }
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          metrics =
            (Util.of_option []
               (Util.option_bind (Xml.member "Metrics" xml) Metrics.parse));
          granularity =
            (Xml.required "Granularity"
               (Util.option_bind (Xml.member "Granularity" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "AutoScalingGroupName"
                   ([], (String.to_xml v.auto_scaling_group_name)))])
            @
            (List.map
               (fun x ->
                  Some (Ezxmlm.make_tag "Metrics" ([], (Metrics.to_xml [x]))))
               v.metrics))
           @
           [Some
              (Ezxmlm.make_tag "Granularity"
                 ([], (String.to_xml v.granularity)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("granularity", (String.to_json v.granularity));
           Some ("metrics", (Metrics.to_json v.metrics));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name))])
    let of_json j =
      {
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        metrics =
          (Metrics.of_json (Util.of_option_exn (Json.lookup j "metrics")));
        granularity =
          (String.of_json (Util.of_option_exn (Json.lookup j "granularity")))
      }
  end
module DescribeLoadBalancerTargetGroupsRequest =
  struct
    type t =
      {
      auto_scaling_group_name: String.t ;
      next_token: String.t option ;
      max_records: Integer.t option }
    let make ~auto_scaling_group_name  ?next_token  ?max_records  () =
      { auto_scaling_group_name; next_token; max_records }
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "AutoScalingGroupName"
                   ([], (String.to_xml v.auto_scaling_group_name)))])
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_records
              (fun f -> Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_records
              (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name))])
    let of_json j =
      {
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json);
        max_records =
          (Util.option_map (Json.lookup j "max_records") Integer.of_json)
      }
  end
module DescribePoliciesType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t option ;
      policy_names: PolicyNames.t ;
      policy_types: PolicyTypes.t ;
      next_token: String.t option ;
      max_records: Integer.t option }
    let make ?auto_scaling_group_name  ?(policy_names= [])  ?(policy_types=
      [])  ?next_token  ?max_records  () =
      {
        auto_scaling_group_name;
        policy_names;
        policy_types;
        next_token;
        max_records
      }
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
               String.parse);
          policy_names =
            (Util.of_option []
               (Util.option_bind (Xml.member "PolicyNames" xml)
                  PolicyNames.parse));
          policy_types =
            (Util.of_option []
               (Util.option_bind (Xml.member "PolicyTypes" xml)
                  PolicyTypes.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.auto_scaling_group_name
                  (fun f ->
                     Ezxmlm.make_tag "AutoScalingGroupName"
                       ([], (String.to_xml f)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "PolicyNames"
                         ([], (PolicyNames.to_xml [x])))) v.policy_names))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "PolicyTypes"
                        ([], (PolicyTypes.to_xml [x])))) v.policy_types))
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_records
              (fun f -> Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_records
              (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Some ("policy_types", (PolicyTypes.to_json v.policy_types));
           Some ("policy_names", (PolicyNames.to_json v.policy_names));
           Util.option_map v.auto_scaling_group_name
             (fun f -> ("auto_scaling_group_name", (String.to_json f)))])
    let of_json j =
      {
        auto_scaling_group_name =
          (Util.option_map (Json.lookup j "auto_scaling_group_name")
             String.of_json);
        policy_names =
          (PolicyNames.of_json
             (Util.of_option_exn (Json.lookup j "policy_names")));
        policy_types =
          (PolicyTypes.of_json
             (Util.of_option_exn (Json.lookup j "policy_types")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json);
        max_records =
          (Util.option_map (Json.lookup j "max_records") Integer.of_json)
      }
  end
module AttachInstancesQuery =
  struct
    type t =
      {
      instance_ids: InstanceIds.t ;
      auto_scaling_group_name: String.t }
    let make ?(instance_ids= [])  ~auto_scaling_group_name  () =
      { instance_ids; auto_scaling_group_name }
    let parse xml =
      Some
        {
          instance_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "InstanceIds" xml)
                  InstanceIds.parse));
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "InstanceIds"
                       ([], (InstanceIds.to_xml [x])))) v.instance_ids))
           @
           [Some
              (Ezxmlm.make_tag "AutoScalingGroupName"
                 ([], (String.to_xml v.auto_scaling_group_name)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("auto_scaling_group_name",
                (String.to_json v.auto_scaling_group_name));
           Some ("instance_ids", (InstanceIds.to_json v.instance_ids))])
    let of_json j =
      {
        instance_ids =
          (InstanceIds.of_json
             (Util.of_option_exn (Json.lookup j "instance_ids")));
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")))
      }
  end
module DescribeNotificationConfigurationsAnswer =
  struct
    type t =
      {
      notification_configurations: NotificationConfigurations.t ;
      next_token: String.t option }
    let make ~notification_configurations  ?next_token  () =
      { notification_configurations; next_token }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("notification_configurations",
               (NotificationConfigurations.to_json
                  v.notification_configurations))])
    let of_json j =
      {
        notification_configurations =
          (NotificationConfigurations.of_json
             (Util.of_option_exn
                (Json.lookup j "notification_configurations")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module TerminateInstanceInAutoScalingGroupType =
  struct
    type t =
      {
      instance_id: String.t ;
      should_decrement_desired_capacity: Boolean.t }
    let make ~instance_id  ~should_decrement_desired_capacity  () =
      { instance_id; should_decrement_desired_capacity }
    let parse xml =
      Some
        {
          instance_id =
            (Xml.required "InstanceId"
               (Util.option_bind (Xml.member "InstanceId" xml) String.parse));
          should_decrement_desired_capacity =
            (Xml.required "ShouldDecrementDesiredCapacity"
               (Util.option_bind
                  (Xml.member "ShouldDecrementDesiredCapacity" xml)
                  Boolean.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "InstanceId"
                  ([], (String.to_xml v.instance_id)))])
           @
           [Some
              (Ezxmlm.make_tag "ShouldDecrementDesiredCapacity"
                 ([], (Boolean.to_xml v.should_decrement_desired_capacity)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("should_decrement_desired_capacity",
                (Boolean.to_json v.should_decrement_desired_capacity));
           Some ("instance_id", (String.to_json v.instance_id))])
    let of_json j =
      {
        instance_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "instance_id")));
        should_decrement_desired_capacity =
          (Boolean.of_json
             (Util.of_option_exn
                (Json.lookup j "should_decrement_desired_capacity")))
      }
  end
module CreateOrUpdateTagsType =
  struct
    type t = {
      tags: Tags.t }
    let make ~tags  () = { tags }
    let parse xml =
      Some
        {
          tags =
            (Xml.required "Tags"
               (Util.option_bind (Xml.member "Tags" xml) Tags.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x -> Some (Ezxmlm.make_tag "Tags" ([], (Tags.to_xml [x]))))
              v.tags))
    let to_json v =
      `Assoc (Util.list_filter_opt [Some ("tags", (Tags.to_json v.tags))])
    let of_json j =
      { tags = (Tags.of_json (Util.of_option_exn (Json.lookup j "tags"))) }
  end
module InvalidNextToken =
  struct
    type t = {
      message: String.t option }
    let make ?message  () = { message }
    let parse xml =
      Some
        {
          message =
            (Util.option_bind (Xml.member "message" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.message
              (fun f -> Ezxmlm.make_tag "message" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.message
              (fun f -> ("message", (String.to_json f)))])
    let of_json j =
      { message = (Util.option_map (Json.lookup j "message") String.of_json)
      }
  end
module DeleteLifecycleHookAnswer =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module AutoScalingGroupNamesType =
  struct
    type t =
      {
      auto_scaling_group_names: AutoScalingGroupNames.t ;
      next_token: String.t option ;
      max_records: Integer.t option }
    let make ?(auto_scaling_group_names= [])  ?next_token  ?max_records  () =
      { auto_scaling_group_names; next_token; max_records }
    let parse xml =
      Some
        {
          auto_scaling_group_names =
            (Util.of_option []
               (Util.option_bind (Xml.member "AutoScalingGroupNames" xml)
                  AutoScalingGroupNames.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "AutoScalingGroupNames"
                        ([], (AutoScalingGroupNames.to_xml [x]))))
                v.auto_scaling_group_names))
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_records
              (fun f -> Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_records
              (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Some
             ("auto_scaling_group_names",
               (AutoScalingGroupNames.to_json v.auto_scaling_group_names))])
    let of_json j =
      {
        auto_scaling_group_names =
          (AutoScalingGroupNames.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_names")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json);
        max_records =
          (Util.option_map (Json.lookup j "max_records") Integer.of_json)
      }
  end
module LaunchConfigurationNameType =
  struct
    type t = {
      launch_configuration_name: String.t }
    let make ~launch_configuration_name  () = { launch_configuration_name }
    let parse xml =
      Some
        {
          launch_configuration_name =
            (Xml.required "LaunchConfigurationName"
               (Util.option_bind (Xml.member "LaunchConfigurationName" xml)
                  String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "LaunchConfigurationName"
                 ([], (String.to_xml v.launch_configuration_name)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("launch_configuration_name",
                (String.to_json v.launch_configuration_name))])
    let of_json j =
      {
        launch_configuration_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "launch_configuration_name")))
      }
  end
module DescribeNotificationConfigurationsType =
  struct
    type t =
      {
      auto_scaling_group_names: AutoScalingGroupNames.t ;
      next_token: String.t option ;
      max_records: Integer.t option }
    let make ?(auto_scaling_group_names= [])  ?next_token  ?max_records  () =
      { auto_scaling_group_names; next_token; max_records }
    let parse xml =
      Some
        {
          auto_scaling_group_names =
            (Util.of_option []
               (Util.option_bind (Xml.member "AutoScalingGroupNames" xml)
                  AutoScalingGroupNames.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "AutoScalingGroupNames"
                        ([], (AutoScalingGroupNames.to_xml [x]))))
                v.auto_scaling_group_names))
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_records
              (fun f -> Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_records
              (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Some
             ("auto_scaling_group_names",
               (AutoScalingGroupNames.to_json v.auto_scaling_group_names))])
    let of_json j =
      {
        auto_scaling_group_names =
          (AutoScalingGroupNames.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_names")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json);
        max_records =
          (Util.option_map (Json.lookup j "max_records") Integer.of_json)
      }
  end
module LaunchConfigurationsType =
  struct
    type t =
      {
      launch_configurations: LaunchConfigurations.t ;
      next_token: String.t option }
    let make ~launch_configurations  ?next_token  () =
      { launch_configurations; next_token }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("launch_configurations",
               (LaunchConfigurations.to_json v.launch_configurations))])
    let of_json j =
      {
        launch_configurations =
          (LaunchConfigurations.of_json
             (Util.of_option_exn (Json.lookup j "launch_configurations")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module ExitStandbyAnswer =
  struct
    type t = {
      activities: Activities.t }
    let make ?(activities= [])  () = { activities }
    let parse xml =
      Some
        {
          activities =
            (Util.of_option []
               (Util.option_bind (Xml.member "Activities" xml)
                  Activities.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Activities"
                      ([], (Activities.to_xml [x])))) v.activities))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("activities", (Activities.to_json v.activities))])
    let of_json j =
      {
        activities =
          (Activities.of_json
             (Util.of_option_exn (Json.lookup j "activities")))
      }
  end
module ScheduledActionsType =
  struct
    type t =
      {
      scheduled_update_group_actions: ScheduledUpdateGroupActions.t ;
      next_token: String.t option }
    let make ?(scheduled_update_group_actions= [])  ?next_token  () =
      { scheduled_update_group_actions; next_token }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("scheduled_update_group_actions",
               (ScheduledUpdateGroupActions.to_json
                  v.scheduled_update_group_actions))])
    let of_json j =
      {
        scheduled_update_group_actions =
          (ScheduledUpdateGroupActions.of_json
             (Util.of_option_exn
                (Json.lookup j "scheduled_update_group_actions")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module DescribeAutoScalingNotificationTypesAnswer =
  struct
    type t =
      {
      auto_scaling_notification_types: AutoScalingNotificationTypes.t }
    let make ?(auto_scaling_notification_types= [])  () =
      { auto_scaling_notification_types }
    let parse xml =
      Some
        {
          auto_scaling_notification_types =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "AutoScalingNotificationTypes" xml)
                  AutoScalingNotificationTypes.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "AutoScalingNotificationTypes"
                      ([], (AutoScalingNotificationTypes.to_xml [x]))))
              v.auto_scaling_notification_types))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("auto_scaling_notification_types",
                (AutoScalingNotificationTypes.to_json
                   v.auto_scaling_notification_types))])
    let of_json j =
      {
        auto_scaling_notification_types =
          (AutoScalingNotificationTypes.of_json
             (Util.of_option_exn
                (Json.lookup j "auto_scaling_notification_types")))
      }
  end
module BatchDeleteScheduledActionAnswer =
  struct
    type t =
      {
      failed_scheduled_actions: FailedScheduledUpdateGroupActionRequests.t }
    let make ?(failed_scheduled_actions= [])  () =
      { failed_scheduled_actions }
    let parse xml =
      Some
        {
          failed_scheduled_actions =
            (Util.of_option []
               (Util.option_bind (Xml.member "FailedScheduledActions" xml)
                  FailedScheduledUpdateGroupActionRequests.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("failed_scheduled_actions",
                (FailedScheduledUpdateGroupActionRequests.to_json
                   v.failed_scheduled_actions))])
    let of_json j =
      {
        failed_scheduled_actions =
          (FailedScheduledUpdateGroupActionRequests.of_json
             (Util.of_option_exn (Json.lookup j "failed_scheduled_actions")))
      }
  end
module BatchPutScheduledUpdateGroupActionType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t ;
      scheduled_update_group_actions: ScheduledUpdateGroupActionRequests.t }
    let make ~auto_scaling_group_name  ~scheduled_update_group_actions  () =
      { auto_scaling_group_name; scheduled_update_group_actions }
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          scheduled_update_group_actions =
            (Xml.required "ScheduledUpdateGroupActions"
               (Util.option_bind
                  (Xml.member "ScheduledUpdateGroupActions" xml)
                  ScheduledUpdateGroupActionRequests.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "AutoScalingGroupName"
                  ([], (String.to_xml v.auto_scaling_group_name)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "ScheduledUpdateGroupActions"
                      ([], (ScheduledUpdateGroupActionRequests.to_xml [x]))))
              v.scheduled_update_group_actions))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("scheduled_update_group_actions",
                (ScheduledUpdateGroupActionRequests.to_json
                   v.scheduled_update_group_actions));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name))])
    let of_json j =
      {
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        scheduled_update_group_actions =
          (ScheduledUpdateGroupActionRequests.of_json
             (Util.of_option_exn
                (Json.lookup j "scheduled_update_group_actions")))
      }
  end
module DescribeLoadBalancersResponse =
  struct
    type t =
      {
      load_balancers: LoadBalancerStates.t ;
      next_token: String.t option }
    let make ?(load_balancers= [])  ?next_token  () =
      { load_balancers; next_token }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("load_balancers",
               (LoadBalancerStates.to_json v.load_balancers))])
    let of_json j =
      {
        load_balancers =
          (LoadBalancerStates.of_json
             (Util.of_option_exn (Json.lookup j "load_balancers")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module ActivitiesType =
  struct
    type t = {
      activities: Activities.t ;
      next_token: String.t option }
    let make ~activities  ?next_token  () = { activities; next_token }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("activities", (Activities.to_json v.activities))])
    let of_json j =
      {
        activities =
          (Activities.of_json
             (Util.of_option_exn (Json.lookup j "activities")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module CompleteLifecycleActionAnswer =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module ScalingActivityInProgressFault =
  struct
    type t = {
      message: String.t option }
    let make ?message  () = { message }
    let parse xml =
      Some
        {
          message =
            (Util.option_bind (Xml.member "message" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.message
              (fun f -> Ezxmlm.make_tag "message" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.message
              (fun f -> ("message", (String.to_json f)))])
    let of_json j =
      { message = (Util.option_map (Json.lookup j "message") String.of_json)
      }
  end
module DeletePolicyType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t option ;
      policy_name: String.t }
    let make ?auto_scaling_group_name  ~policy_name  () =
      { auto_scaling_group_name; policy_name }
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
               String.parse);
          policy_name =
            (Xml.required "PolicyName"
               (Util.option_bind (Xml.member "PolicyName" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.auto_scaling_group_name
               (fun f ->
                  Ezxmlm.make_tag "AutoScalingGroupName"
                    ([], (String.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "PolicyName"
                 ([], (String.to_xml v.policy_name)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("policy_name", (String.to_json v.policy_name));
           Util.option_map v.auto_scaling_group_name
             (fun f -> ("auto_scaling_group_name", (String.to_json f)))])
    let of_json j =
      {
        auto_scaling_group_name =
          (Util.option_map (Json.lookup j "auto_scaling_group_name")
             String.of_json);
        policy_name =
          (String.of_json (Util.of_option_exn (Json.lookup j "policy_name")))
      }
  end
module PolicyARNType =
  struct
    type t = {
      policy_a_r_n: String.t option ;
      alarms: Alarms.t }
    let make ?policy_a_r_n  ?(alarms= [])  () = { policy_a_r_n; alarms }
    let parse xml =
      Some
        {
          policy_a_r_n =
            (Util.option_bind (Xml.member "PolicyARN" xml) String.parse);
          alarms =
            (Util.of_option []
               (Util.option_bind (Xml.member "Alarms" xml) Alarms.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("alarms", (Alarms.to_json v.alarms));
           Util.option_map v.policy_a_r_n
             (fun f -> ("policy_a_r_n", (String.to_json f)))])
    let of_json j =
      {
        policy_a_r_n =
          (Util.option_map (Json.lookup j "policy_a_r_n") String.of_json);
        alarms =
          (Alarms.of_json (Util.of_option_exn (Json.lookup j "alarms")))
      }
  end
module DescribeMetricCollectionTypesAnswer =
  struct
    type t =
      {
      metrics: MetricCollectionTypes.t ;
      granularities: MetricGranularityTypes.t }
    let make ?(metrics= [])  ?(granularities= [])  () =
      { metrics; granularities }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("granularities",
                (MetricGranularityTypes.to_json v.granularities));
           Some ("metrics", (MetricCollectionTypes.to_json v.metrics))])
    let of_json j =
      {
        metrics =
          (MetricCollectionTypes.of_json
             (Util.of_option_exn (Json.lookup j "metrics")));
        granularities =
          (MetricGranularityTypes.of_json
             (Util.of_option_exn (Json.lookup j "granularities")))
      }
  end
module EnterStandbyAnswer =
  struct
    type t = {
      activities: Activities.t }
    let make ?(activities= [])  () = { activities }
    let parse xml =
      Some
        {
          activities =
            (Util.of_option []
               (Util.option_bind (Xml.member "Activities" xml)
                  Activities.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Activities"
                      ([], (Activities.to_xml [x])))) v.activities))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("activities", (Activities.to_json v.activities))])
    let of_json j =
      {
        activities =
          (Activities.of_json
             (Util.of_option_exn (Json.lookup j "activities")))
      }
  end
module DescribeLifecycleHooksType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t ;
      lifecycle_hook_names: LifecycleHookNames.t }
    let make ~auto_scaling_group_name  ?(lifecycle_hook_names= [])  () =
      { auto_scaling_group_name; lifecycle_hook_names }
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          lifecycle_hook_names =
            (Util.of_option []
               (Util.option_bind (Xml.member "LifecycleHookNames" xml)
                  LifecycleHookNames.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "AutoScalingGroupName"
                  ([], (String.to_xml v.auto_scaling_group_name)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "LifecycleHookNames"
                      ([], (LifecycleHookNames.to_xml [x]))))
              v.lifecycle_hook_names))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("lifecycle_hook_names",
                (LifecycleHookNames.to_json v.lifecycle_hook_names));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name))])
    let of_json j =
      {
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        lifecycle_hook_names =
          (LifecycleHookNames.of_json
             (Util.of_option_exn (Json.lookup j "lifecycle_hook_names")))
      }
  end
module DisableMetricsCollectionQuery =
  struct
    type t = {
      auto_scaling_group_name: String.t ;
      metrics: Metrics.t }
    let make ~auto_scaling_group_name  ?(metrics= [])  () =
      { auto_scaling_group_name; metrics }
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          metrics =
            (Util.of_option []
               (Util.option_bind (Xml.member "Metrics" xml) Metrics.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "AutoScalingGroupName"
                  ([], (String.to_xml v.auto_scaling_group_name)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Metrics" ([], (Metrics.to_xml [x]))))
              v.metrics))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("metrics", (Metrics.to_json v.metrics));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name))])
    let of_json j =
      {
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        metrics =
          (Metrics.of_json (Util.of_option_exn (Json.lookup j "metrics")))
      }
  end
module DescribeAutoScalingInstancesType =
  struct
    type t =
      {
      instance_ids: InstanceIds.t ;
      max_records: Integer.t option ;
      next_token: String.t option }
    let make ?(instance_ids= [])  ?max_records  ?next_token  () =
      { instance_ids; max_records; next_token }
    let parse xml =
      Some
        {
          instance_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "InstanceIds" xml)
                  InstanceIds.parse));
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "InstanceIds"
                        ([], (InstanceIds.to_xml [x])))) v.instance_ids))
            @
            [Util.option_map v.max_records
               (fun f ->
                  Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Some ("instance_ids", (InstanceIds.to_json v.instance_ids))])
    let of_json j =
      {
        instance_ids =
          (InstanceIds.of_json
             (Util.of_option_exn (Json.lookup j "instance_ids")));
        max_records =
          (Util.option_map (Json.lookup j "max_records") Integer.of_json);
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module ProcessesType =
  struct
    type t = {
      processes: Processes.t }
    let make ?(processes= [])  () = { processes }
    let parse xml =
      Some
        {
          processes =
            (Util.of_option []
               (Util.option_bind (Xml.member "Processes" xml) Processes.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Processes" ([], (Processes.to_xml [x]))))
              v.processes))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("processes", (Processes.to_json v.processes))])
    let of_json j =
      {
        processes =
          (Processes.of_json (Util.of_option_exn (Json.lookup j "processes")))
      }
  end
module CompleteLifecycleActionType =
  struct
    type t =
      {
      lifecycle_hook_name: String.t ;
      auto_scaling_group_name: String.t ;
      lifecycle_action_token: String.t option ;
      lifecycle_action_result: String.t ;
      instance_id: String.t option }
    let make ~lifecycle_hook_name  ~auto_scaling_group_name 
      ?lifecycle_action_token  ~lifecycle_action_result  ?instance_id  () =
      {
        lifecycle_hook_name;
        auto_scaling_group_name;
        lifecycle_action_token;
        lifecycle_action_result;
        instance_id
      }
    let parse xml =
      Some
        {
          lifecycle_hook_name =
            (Xml.required "LifecycleHookName"
               (Util.option_bind (Xml.member "LifecycleHookName" xml)
                  String.parse));
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          lifecycle_action_token =
            (Util.option_bind (Xml.member "LifecycleActionToken" xml)
               String.parse);
          lifecycle_action_result =
            (Xml.required "LifecycleActionResult"
               (Util.option_bind (Xml.member "LifecycleActionResult" xml)
                  String.parse));
          instance_id =
            (Util.option_bind (Xml.member "InstanceId" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "LifecycleHookName"
                     ([], (String.to_xml v.lifecycle_hook_name)))])
              @
              [Some
                 (Ezxmlm.make_tag "AutoScalingGroupName"
                    ([], (String.to_xml v.auto_scaling_group_name)))])
             @
             [Util.option_map v.lifecycle_action_token
                (fun f ->
                   Ezxmlm.make_tag "LifecycleActionToken"
                     ([], (String.to_xml f)))])
            @
            [Some
               (Ezxmlm.make_tag "LifecycleActionResult"
                  ([], (String.to_xml v.lifecycle_action_result)))])
           @
           [Util.option_map v.instance_id
              (fun f -> Ezxmlm.make_tag "InstanceId" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.instance_id
              (fun f -> ("instance_id", (String.to_json f)));
           Some
             ("lifecycle_action_result",
               (String.to_json v.lifecycle_action_result));
           Util.option_map v.lifecycle_action_token
             (fun f -> ("lifecycle_action_token", (String.to_json f)));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name));
           Some
             ("lifecycle_hook_name", (String.to_json v.lifecycle_hook_name))])
    let of_json j =
      {
        lifecycle_hook_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "lifecycle_hook_name")));
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        lifecycle_action_token =
          (Util.option_map (Json.lookup j "lifecycle_action_token")
             String.of_json);
        lifecycle_action_result =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "lifecycle_action_result")));
        instance_id =
          (Util.option_map (Json.lookup j "instance_id") String.of_json)
      }
  end
module EnterStandbyQuery =
  struct
    type t =
      {
      instance_ids: InstanceIds.t ;
      auto_scaling_group_name: String.t ;
      should_decrement_desired_capacity: Boolean.t }
    let make ?(instance_ids= [])  ~auto_scaling_group_name 
      ~should_decrement_desired_capacity  () =
      {
        instance_ids;
        auto_scaling_group_name;
        should_decrement_desired_capacity
      }
    let parse xml =
      Some
        {
          instance_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "InstanceIds" xml)
                  InstanceIds.parse));
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          should_decrement_desired_capacity =
            (Xml.required "ShouldDecrementDesiredCapacity"
               (Util.option_bind
                  (Xml.member "ShouldDecrementDesiredCapacity" xml)
                  Boolean.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "InstanceIds"
                        ([], (InstanceIds.to_xml [x])))) v.instance_ids))
            @
            [Some
               (Ezxmlm.make_tag "AutoScalingGroupName"
                  ([], (String.to_xml v.auto_scaling_group_name)))])
           @
           [Some
              (Ezxmlm.make_tag "ShouldDecrementDesiredCapacity"
                 ([], (Boolean.to_xml v.should_decrement_desired_capacity)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("should_decrement_desired_capacity",
                (Boolean.to_json v.should_decrement_desired_capacity));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name));
           Some ("instance_ids", (InstanceIds.to_json v.instance_ids))])
    let of_json j =
      {
        instance_ids =
          (InstanceIds.of_json
             (Util.of_option_exn (Json.lookup j "instance_ids")));
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        should_decrement_desired_capacity =
          (Boolean.of_json
             (Util.of_option_exn
                (Json.lookup j "should_decrement_desired_capacity")))
      }
  end
module DescribeScheduledActionsType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t option ;
      scheduled_action_names: ScheduledActionNames.t ;
      start_time: DateTime.t option ;
      end_time: DateTime.t option ;
      next_token: String.t option ;
      max_records: Integer.t option }
    let make ?auto_scaling_group_name  ?(scheduled_action_names= []) 
      ?start_time  ?end_time  ?next_token  ?max_records  () =
      {
        auto_scaling_group_name;
        scheduled_action_names;
        start_time;
        end_time;
        next_token;
        max_records
      }
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
               String.parse);
          scheduled_action_names =
            (Util.of_option []
               (Util.option_bind (Xml.member "ScheduledActionNames" xml)
                  ScheduledActionNames.parse));
          start_time =
            (Util.option_bind (Xml.member "StartTime" xml) DateTime.parse);
          end_time =
            (Util.option_bind (Xml.member "EndTime" xml) DateTime.parse);
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.auto_scaling_group_name
                   (fun f ->
                      Ezxmlm.make_tag "AutoScalingGroupName"
                        ([], (String.to_xml f)))])
               @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "ScheduledActionNames"
                          ([], (ScheduledActionNames.to_xml [x]))))
                  v.scheduled_action_names))
              @
              [Util.option_map v.start_time
                 (fun f ->
                    Ezxmlm.make_tag "StartTime" ([], (DateTime.to_xml f)))])
             @
             [Util.option_map v.end_time
                (fun f -> Ezxmlm.make_tag "EndTime" ([], (DateTime.to_xml f)))])
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_records
              (fun f -> Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_records
              (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.end_time
             (fun f -> ("end_time", (DateTime.to_json f)));
           Util.option_map v.start_time
             (fun f -> ("start_time", (DateTime.to_json f)));
           Some
             ("scheduled_action_names",
               (ScheduledActionNames.to_json v.scheduled_action_names));
           Util.option_map v.auto_scaling_group_name
             (fun f -> ("auto_scaling_group_name", (String.to_json f)))])
    let of_json j =
      {
        auto_scaling_group_name =
          (Util.option_map (Json.lookup j "auto_scaling_group_name")
             String.of_json);
        scheduled_action_names =
          (ScheduledActionNames.of_json
             (Util.of_option_exn (Json.lookup j "scheduled_action_names")));
        start_time =
          (Util.option_map (Json.lookup j "start_time") DateTime.of_json);
        end_time =
          (Util.option_map (Json.lookup j "end_time") DateTime.of_json);
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json);
        max_records =
          (Util.option_map (Json.lookup j "max_records") Integer.of_json)
      }
  end
module ResourceContentionFault =
  struct
    type t = {
      message: String.t option }
    let make ?message  () = { message }
    let parse xml =
      Some
        {
          message =
            (Util.option_bind (Xml.member "message" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.message
              (fun f -> Ezxmlm.make_tag "message" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.message
              (fun f -> ("message", (String.to_json f)))])
    let of_json j =
      { message = (Util.option_map (Json.lookup j "message") String.of_json)
      }
  end
module SetInstanceProtectionQuery =
  struct
    type t =
      {
      instance_ids: InstanceIds.t ;
      auto_scaling_group_name: String.t ;
      protected_from_scale_in: Boolean.t }
    let make ~instance_ids  ~auto_scaling_group_name 
      ~protected_from_scale_in  () =
      { instance_ids; auto_scaling_group_name; protected_from_scale_in }
    let parse xml =
      Some
        {
          instance_ids =
            (Xml.required "InstanceIds"
               (Util.option_bind (Xml.member "InstanceIds" xml)
                  InstanceIds.parse));
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          protected_from_scale_in =
            (Xml.required "ProtectedFromScaleIn"
               (Util.option_bind (Xml.member "ProtectedFromScaleIn" xml)
                  Boolean.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "InstanceIds"
                        ([], (InstanceIds.to_xml [x])))) v.instance_ids))
            @
            [Some
               (Ezxmlm.make_tag "AutoScalingGroupName"
                  ([], (String.to_xml v.auto_scaling_group_name)))])
           @
           [Some
              (Ezxmlm.make_tag "ProtectedFromScaleIn"
                 ([], (Boolean.to_xml v.protected_from_scale_in)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("protected_from_scale_in",
                (Boolean.to_json v.protected_from_scale_in));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name));
           Some ("instance_ids", (InstanceIds.to_json v.instance_ids))])
    let of_json j =
      {
        instance_ids =
          (InstanceIds.of_json
             (Util.of_option_exn (Json.lookup j "instance_ids")));
        auto_scaling_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "auto_scaling_group_name")));
        protected_from_scale_in =
          (Boolean.of_json
             (Util.of_option_exn (Json.lookup j "protected_from_scale_in")))
      }
  end