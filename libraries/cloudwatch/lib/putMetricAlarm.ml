open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutMetricAlarmInput =
  struct
    type t =
      {
      alarm_name: String.t
        [@ocaml.doc
          "<p>The name for the alarm. This name must be unique within your AWS account.</p>"];
      alarm_description: String.t option
        [@ocaml.doc "<p>The description for the alarm.</p>"];
      actions_enabled: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether actions should be executed during any changes to the alarm state. The default is <code>TRUE</code>.</p>"];
      o_k_actions: ResourceList.t
        [@ocaml.doc
          "<p>The actions to execute when this alarm transitions to an <code>OK</code> state from any other state. Each action is specified as an Amazon Resource Name (ARN).</p> <p>Valid Values: <code>arn:aws:automate:<i>region</i>:ec2:stop</code> | <code>arn:aws:automate:<i>region</i>:ec2:terminate</code> | <code>arn:aws:automate:<i>region</i>:ec2:recover</code> | <code>arn:aws:automate:<i>region</i>:ec2:reboot</code> | <code>arn:aws:sns:<i>region</i>:<i>account-id</i>:<i>sns-topic-name</i> </code> | <code>arn:aws:autoscaling:<i>region</i>:<i>account-id</i>:scalingPolicy:<i>policy-id</i>autoScalingGroupName/<i>group-friendly-name</i>:policyName/<i>policy-friendly-name</i> </code> </p> <p>Valid Values (for use with IAM roles): <code>arn:aws:swf:<i>region</i>:<i>account-id</i>:action/actions/AWS_EC2.InstanceId.Stop/1.0</code> | <code>arn:aws:swf:<i>region</i>:<i>account-id</i>:action/actions/AWS_EC2.InstanceId.Terminate/1.0</code> | <code>arn:aws:swf:<i>region</i>:<i>account-id</i>:action/actions/AWS_EC2.InstanceId.Reboot/1.0</code> </p>"];
      alarm_actions: ResourceList.t
        [@ocaml.doc
          "<p>The actions to execute when this alarm transitions to the <code>ALARM</code> state from any other state. Each action is specified as an Amazon Resource Name (ARN).</p> <p>Valid Values: <code>arn:aws:automate:<i>region</i>:ec2:stop</code> | <code>arn:aws:automate:<i>region</i>:ec2:terminate</code> | <code>arn:aws:automate:<i>region</i>:ec2:recover</code> | <code>arn:aws:automate:<i>region</i>:ec2:reboot</code> | <code>arn:aws:sns:<i>region</i>:<i>account-id</i>:<i>sns-topic-name</i> </code> | <code>arn:aws:autoscaling:<i>region</i>:<i>account-id</i>:scalingPolicy:<i>policy-id</i>autoScalingGroupName/<i>group-friendly-name</i>:policyName/<i>policy-friendly-name</i> </code> </p> <p>Valid Values (for use with IAM roles): <code>arn:aws:swf:<i>region</i>:<i>account-id</i>:action/actions/AWS_EC2.InstanceId.Stop/1.0</code> | <code>arn:aws:swf:<i>region</i>:<i>account-id</i>:action/actions/AWS_EC2.InstanceId.Terminate/1.0</code> | <code>arn:aws:swf:<i>region</i>:<i>account-id</i>:action/actions/AWS_EC2.InstanceId.Reboot/1.0</code> </p>"];
      insufficient_data_actions: ResourceList.t
        [@ocaml.doc
          "<p>The actions to execute when this alarm transitions to the <code>INSUFFICIENT_DATA</code> state from any other state. Each action is specified as an Amazon Resource Name (ARN).</p> <p>Valid Values: <code>arn:aws:automate:<i>region</i>:ec2:stop</code> | <code>arn:aws:automate:<i>region</i>:ec2:terminate</code> | <code>arn:aws:automate:<i>region</i>:ec2:recover</code> | <code>arn:aws:automate:<i>region</i>:ec2:reboot</code> | <code>arn:aws:sns:<i>region</i>:<i>account-id</i>:<i>sns-topic-name</i> </code> | <code>arn:aws:autoscaling:<i>region</i>:<i>account-id</i>:scalingPolicy:<i>policy-id</i>autoScalingGroupName/<i>group-friendly-name</i>:policyName/<i>policy-friendly-name</i> </code> </p> <p>Valid Values (for use with IAM roles): <code>&gt;arn:aws:swf:<i>region</i>:<i>account-id</i>:action/actions/AWS_EC2.InstanceId.Stop/1.0</code> | <code>arn:aws:swf:<i>region</i>:<i>account-id</i>:action/actions/AWS_EC2.InstanceId.Terminate/1.0</code> | <code>arn:aws:swf:<i>region</i>:<i>account-id</i>:action/actions/AWS_EC2.InstanceId.Reboot/1.0</code> </p>"];
      metric_name: String.t option
        [@ocaml.doc
          "<p>The name for the metric associated with the alarm. For each <code>PutMetricAlarm</code> operation, you must specify either <code>MetricName</code> or a <code>Metrics</code> array.</p> <p>If you are creating an alarm based on a math expression, you cannot specify this parameter, or any of the <code>Dimensions</code>, <code>Period</code>, <code>Namespace</code>, <code>Statistic</code>, or <code>ExtendedStatistic</code> parameters. Instead, you specify all this information in the <code>Metrics</code> array.</p>"];
      namespace: String.t option
        [@ocaml.doc
          "<p>The namespace for the metric associated specified in <code>MetricName</code>.</p>"];
      statistic: Statistic.t option
        [@ocaml.doc
          "<p>The statistic for the metric specified in <code>MetricName</code>, other than percentile. For percentile statistics, use <code>ExtendedStatistic</code>. When you call <code>PutMetricAlarm</code> and specify a <code>MetricName</code>, you must specify either <code>Statistic</code> or <code>ExtendedStatistic,</code> but not both.</p>"];
      extended_statistic: String.t option
        [@ocaml.doc
          "<p>The percentile statistic for the metric specified in <code>MetricName</code>. Specify a value between p0.0 and p100. When you call <code>PutMetricAlarm</code> and specify a <code>MetricName</code>, you must specify either <code>Statistic</code> or <code>ExtendedStatistic,</code> but not both.</p>"];
      dimensions: Dimensions.t
        [@ocaml.doc
          "<p>The dimensions for the metric specified in <code>MetricName</code>.</p>"];
      period: Integer.t option
        [@ocaml.doc
          "<p>The length, in seconds, used each time the metric specified in <code>MetricName</code> is evaluated. Valid values are 10, 30, and any multiple of 60.</p> <p> <code>Period</code> is required for alarms based on static thresholds. If you are creating an alarm based on a metric math expression, you specify the period for each metric within the objects in the <code>Metrics</code> array.</p> <p>Be sure to specify 10 or 30 only for metrics that are stored by a <code>PutMetricData</code> call with a <code>StorageResolution</code> of 1. If you specify a period of 10 or 30 for a metric that does not have sub-minute resolution, the alarm still attempts to gather data at the period rate that you specify. In this case, it does not receive data for the attempts that do not correspond to a one-minute data resolution, and the alarm may often lapse into INSUFFICENT_DATA status. Specifying 10 or 30 also sets this alarm as a high-resolution alarm, which has a higher charge than other alarms. For more information about pricing, see <a href=\"https://aws.amazon.com/cloudwatch/pricing/\">Amazon CloudWatch Pricing</a>.</p> <p>An alarm's total current evaluation period can be no longer than one day, so <code>Period</code> multiplied by <code>EvaluationPeriods</code> cannot be more than 86,400 seconds.</p>"];
      unit: StandardUnit.t option
        [@ocaml.doc
          "<p>The unit of measure for the statistic. For example, the units for the Amazon EC2 NetworkIn metric are Bytes because NetworkIn tracks the number of bytes that an instance receives on all network interfaces. You can also specify a unit when you create a custom metric. Units help provide conceptual meaning to your data. Metric data points that specify a unit of measure, such as Percent, are aggregated separately.</p> <p>If you don't specify <code>Unit</code>, CloudWatch retrieves all unit types that have been published for the metric and attempts to evaluate the alarm. Usually metrics are published with only one unit, so the alarm will work as intended.</p> <p>However, if the metric is published with multiple types of units and you don't specify a unit, the alarm's behavior is not defined and will behave un-predictably.</p> <p>We recommend omitting <code>Unit</code> so that you don't inadvertently specify an incorrect unit that is not published for this metric. Doing so causes the alarm to be stuck in the <code>INSUFFICIENT DATA</code> state.</p>"];
      evaluation_periods: Integer.t
        [@ocaml.doc
          "<p>The number of periods over which data is compared to the specified threshold. If you are setting an alarm that requires that a number of consecutive data points be breaching to trigger the alarm, this value specifies that number. If you are setting an \"M out of N\" alarm, this value is the N.</p> <p>An alarm's total current evaluation period can be no longer than one day, so this number multiplied by <code>Period</code> cannot be more than 86,400 seconds.</p>"];
      datapoints_to_alarm: Integer.t option
        [@ocaml.doc
          "<p>The number of data points that must be breaching to trigger the alarm. This is used only if you are setting an \"M out of N\" alarm. In that case, this value is the M. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html#alarm-evaluation\">Evaluating an Alarm</a> in the <i>Amazon CloudWatch User Guide</i>.</p>"];
      threshold: Double.t option
        [@ocaml.doc
          "<p>The value against which the specified statistic is compared.</p> <p>This parameter is required for alarms based on static thresholds, but should not be used for alarms based on anomaly detection models.</p>"];
      comparison_operator: ComparisonOperator.t
        [@ocaml.doc
          "<p> The arithmetic operation to use when comparing the specified statistic and threshold. The specified statistic value is used as the first operand.</p> <p>The values <code>LessThanLowerOrGreaterThanUpperThreshold</code>, <code>LessThanLowerThreshold</code>, and <code>GreaterThanUpperThreshold</code> are used only for alarms based on anomaly detection models.</p>"];
      treat_missing_data: String.t option
        [@ocaml.doc
          "<p> Sets how this alarm is to handle missing data points. If <code>TreatMissingData</code> is omitted, the default behavior of <code>missing</code> is used. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html#alarms-and-missing-data\">Configuring How CloudWatch Alarms Treats Missing Data</a>.</p> <p>Valid Values: <code>breaching | notBreaching | ignore | missing</code> </p>"];
      evaluate_low_sample_count_percentile: String.t option
        [@ocaml.doc
          "<p> Used only for alarms based on percentiles. If you specify <code>ignore</code>, the alarm state does not change during periods with too few data points to be statistically significant. If you specify <code>evaluate</code> or omit this parameter, the alarm is always evaluated and possibly changes state no matter how many data points are available. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html#percentiles-with-low-samples\">Percentile-Based CloudWatch Alarms and Low Data Samples</a>.</p> <p>Valid Values: <code>evaluate | ignore</code> </p>"];
      metrics: MetricDataQueries.t
        [@ocaml.doc
          "<p>An array of <code>MetricDataQuery</code> structures that enable you to create an alarm based on the result of a metric math expression. For each <code>PutMetricAlarm</code> operation, you must specify either <code>MetricName</code> or a <code>Metrics</code> array.</p> <p>Each item in the <code>Metrics</code> array either retrieves a metric or performs a math expression.</p> <p>One item in the <code>Metrics</code> array is the expression that the alarm watches. You designate this expression by setting <code>ReturnValue</code> to true for this object in the array. For more information, see <a>MetricDataQuery</a>.</p> <p>If you use the <code>Metrics</code> parameter, you cannot include the <code>MetricName</code>, <code>Dimensions</code>, <code>Period</code>, <code>Namespace</code>, <code>Statistic</code>, or <code>ExtendedStatistic</code> parameters of <code>PutMetricAlarm</code> in the same operation. Instead, you retrieve the metrics you are using in your math expression as part of the <code>Metrics</code> array.</p>"];
      tags: TagList.t
        [@ocaml.doc
          "<p>A list of key-value pairs to associate with the alarm. You can associate as many as 50 tags with an alarm.</p> <p>Tags can help you organize and categorize your resources. You can also use them to scope user permissions, by granting a user permission to access or change only resources with certain tag values.</p>"];
      threshold_metric_id: String.t option
        [@ocaml.doc
          "<p>If this is an alarm based on an anomaly detection model, make this value match the ID of the <code>ANOMALY_DETECTION_BAND</code> function.</p> <p>For an example of how to use this parameter, see the <b>Anomaly Detection Model Alarm</b> example on this page.</p> <p>If your alarm uses this parameter, it cannot have Auto Scaling actions.</p>"]}
    let make ~alarm_name  ?alarm_description  ?actions_enabled 
      ?(o_k_actions= [])  ?(alarm_actions= [])  ?(insufficient_data_actions=
      [])  ?metric_name  ?namespace  ?statistic  ?extended_statistic 
      ?(dimensions= [])  ?period  ?unit  ~evaluation_periods 
      ?datapoints_to_alarm  ?threshold  ~comparison_operator 
      ?treat_missing_data  ?evaluate_low_sample_count_percentile  ?(metrics=
      [])  ?(tags= [])  ?threshold_metric_id  () =
      {
        alarm_name;
        alarm_description;
        actions_enabled;
        o_k_actions;
        alarm_actions;
        insufficient_data_actions;
        metric_name;
        namespace;
        statistic;
        extended_statistic;
        dimensions;
        period;
        unit;
        evaluation_periods;
        datapoints_to_alarm;
        threshold;
        comparison_operator;
        treat_missing_data;
        evaluate_low_sample_count_percentile;
        metrics;
        tags;
        threshold_metric_id
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.threshold_metric_id
              (fun f -> ("threshold_metric_id", (String.to_json f)));
           Some ("tags", (TagList.to_json v.tags));
           Some ("metrics", (MetricDataQueries.to_json v.metrics));
           Util.option_map v.evaluate_low_sample_count_percentile
             (fun f ->
                ("evaluate_low_sample_count_percentile", (String.to_json f)));
           Util.option_map v.treat_missing_data
             (fun f -> ("treat_missing_data", (String.to_json f)));
           Some
             ("comparison_operator",
               (ComparisonOperator.to_json v.comparison_operator));
           Util.option_map v.threshold
             (fun f -> ("threshold", (Double.to_json f)));
           Util.option_map v.datapoints_to_alarm
             (fun f -> ("datapoints_to_alarm", (Integer.to_json f)));
           Some
             ("evaluation_periods", (Integer.to_json v.evaluation_periods));
           Util.option_map v.unit
             (fun f -> ("unit", (StandardUnit.to_json f)));
           Util.option_map v.period
             (fun f -> ("period", (Integer.to_json f)));
           Some ("dimensions", (Dimensions.to_json v.dimensions));
           Util.option_map v.extended_statistic
             (fun f -> ("extended_statistic", (String.to_json f)));
           Util.option_map v.statistic
             (fun f -> ("statistic", (Statistic.to_json f)));
           Util.option_map v.namespace
             (fun f -> ("namespace", (String.to_json f)));
           Util.option_map v.metric_name
             (fun f -> ("metric_name", (String.to_json f)));
           Some
             ("insufficient_data_actions",
               (ResourceList.to_json v.insufficient_data_actions));
           Some ("alarm_actions", (ResourceList.to_json v.alarm_actions));
           Some ("o_k_actions", (ResourceList.to_json v.o_k_actions));
           Util.option_map v.actions_enabled
             (fun f -> ("actions_enabled", (Boolean.to_json f)));
           Util.option_map v.alarm_description
             (fun f -> ("alarm_description", (String.to_json f)));
           Some ("alarm_name", (String.to_json v.alarm_name))])
    let parse xml =
      Some
        {
          alarm_name =
            (Xml.required "AlarmName"
               (Util.option_bind (Xml.member "AlarmName" xml) String.parse));
          alarm_description =
            (Util.option_bind (Xml.member "AlarmDescription" xml)
               String.parse);
          actions_enabled =
            (Util.option_bind (Xml.member "ActionsEnabled" xml) Boolean.parse);
          o_k_actions =
            (Util.of_option []
               (Util.option_bind (Xml.member "OKActions" xml)
                  ResourceList.parse));
          alarm_actions =
            (Util.of_option []
               (Util.option_bind (Xml.member "AlarmActions" xml)
                  ResourceList.parse));
          insufficient_data_actions =
            (Util.of_option []
               (Util.option_bind (Xml.member "InsufficientDataActions" xml)
                  ResourceList.parse));
          metric_name =
            (Util.option_bind (Xml.member "MetricName" xml) String.parse);
          namespace =
            (Util.option_bind (Xml.member "Namespace" xml) String.parse);
          statistic =
            (Util.option_bind (Xml.member "Statistic" xml) Statistic.parse);
          extended_statistic =
            (Util.option_bind (Xml.member "ExtendedStatistic" xml)
               String.parse);
          dimensions =
            (Util.of_option []
               (Util.option_bind (Xml.member "Dimensions" xml)
                  Dimensions.parse));
          period = (Util.option_bind (Xml.member "Period" xml) Integer.parse);
          unit =
            (Util.option_bind (Xml.member "Unit" xml) StandardUnit.parse);
          evaluation_periods =
            (Xml.required "EvaluationPeriods"
               (Util.option_bind (Xml.member "EvaluationPeriods" xml)
                  Integer.parse));
          datapoints_to_alarm =
            (Util.option_bind (Xml.member "DatapointsToAlarm" xml)
               Integer.parse);
          threshold =
            (Util.option_bind (Xml.member "Threshold" xml) Double.parse);
          comparison_operator =
            (Xml.required "ComparisonOperator"
               (Util.option_bind (Xml.member "ComparisonOperator" xml)
                  ComparisonOperator.parse));
          treat_missing_data =
            (Util.option_bind (Xml.member "TreatMissingData" xml)
               String.parse);
          evaluate_low_sample_count_percentile =
            (Util.option_bind
               (Xml.member "EvaluateLowSampleCountPercentile" xml)
               String.parse);
          metrics =
            (Util.of_option []
               (Util.option_bind (Xml.member "Metrics" xml)
                  MetricDataQueries.parse));
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse));
          threshold_metric_id =
            (Util.option_bind (Xml.member "ThresholdMetricId" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((((((((((([] @
                                [Some
                                   (Ezxmlm.make_tag "AlarmName"
                                      ([], (String.to_xml v.alarm_name)))])
                               @
                               [Util.option_map v.alarm_description
                                  (fun f ->
                                     Ezxmlm.make_tag "AlarmDescription"
                                       ([], (String.to_xml f)))])
                              @
                              [Util.option_map v.actions_enabled
                                 (fun f ->
                                    Ezxmlm.make_tag "ActionsEnabled"
                                      ([], (Boolean.to_xml f)))])
                             @
                             (List.map
                                (fun x ->
                                   Some
                                     (Ezxmlm.make_tag "OKActions"
                                        ([], (ResourceList.to_xml [x]))))
                                v.o_k_actions))
                            @
                            (List.map
                               (fun x ->
                                  Some
                                    (Ezxmlm.make_tag "AlarmActions"
                                       ([], (ResourceList.to_xml [x]))))
                               v.alarm_actions))
                           @
                           (List.map
                              (fun x ->
                                 Some
                                   (Ezxmlm.make_tag "InsufficientDataActions"
                                      ([], (ResourceList.to_xml [x]))))
                              v.insufficient_data_actions))
                          @
                          [Util.option_map v.metric_name
                             (fun f ->
                                Ezxmlm.make_tag "MetricName"
                                  ([], (String.to_xml f)))])
                         @
                         [Util.option_map v.namespace
                            (fun f ->
                               Ezxmlm.make_tag "Namespace"
                                 ([], (String.to_xml f)))])
                        @
                        [Util.option_map v.statistic
                           (fun f ->
                              Ezxmlm.make_tag "Statistic"
                                ([], (Statistic.to_xml f)))])
                       @
                       [Util.option_map v.extended_statistic
                          (fun f ->
                             Ezxmlm.make_tag "ExtendedStatistic"
                               ([], (String.to_xml f)))])
                      @
                      (List.map
                         (fun x ->
                            Some
                              (Ezxmlm.make_tag "Dimensions"
                                 ([], (Dimensions.to_xml [x])))) v.dimensions))
                     @
                     [Util.option_map v.period
                        (fun f ->
                           Ezxmlm.make_tag "Period" ([], (Integer.to_xml f)))])
                    @
                    [Util.option_map v.unit
                       (fun f ->
                          Ezxmlm.make_tag "Unit"
                            ([], (StandardUnit.to_xml f)))])
                   @
                   [Some
                      (Ezxmlm.make_tag "EvaluationPeriods"
                         ([], (Integer.to_xml v.evaluation_periods)))])
                  @
                  [Util.option_map v.datapoints_to_alarm
                     (fun f ->
                        Ezxmlm.make_tag "DatapointsToAlarm"
                          ([], (Integer.to_xml f)))])
                 @
                 [Util.option_map v.threshold
                    (fun f ->
                       Ezxmlm.make_tag "Threshold" ([], (Double.to_xml f)))])
                @
                [Some
                   (Ezxmlm.make_tag "ComparisonOperator"
                      ([], (ComparisonOperator.to_xml v.comparison_operator)))])
               @
               [Util.option_map v.treat_missing_data
                  (fun f ->
                     Ezxmlm.make_tag "TreatMissingData"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.evaluate_low_sample_count_percentile
                 (fun f ->
                    Ezxmlm.make_tag "EvaluateLowSampleCountPercentile"
                      ([], (String.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "Metrics"
                        ([], (MetricDataQueries.to_xml [x])))) v.metrics))
            @
            (List.map
               (fun x ->
                  Some (Ezxmlm.make_tag "Tags" ([], (TagList.to_xml [x]))))
               v.tags))
           @
           [Util.option_map v.threshold_metric_id
              (fun f ->
                 Ezxmlm.make_tag "ThresholdMetricId" ([], (String.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = PutMetricAlarmInput.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "monitoring"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-08-01"]); ("Action", ["PutMetricAlarm"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (PutMetricAlarmInput.to_query req))))) in
  (`POST, uri, (Headers.render (PutMetricAlarmInput.to_headers req)), "")
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