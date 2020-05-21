(** "<p>Creates or updates an alarm and associates it with the specified metric, metric math expression, or anomaly detection model.</p> <p>Alarms based on anomaly detection models cannot have Auto Scaling actions.</p> <p>When this operation creates an alarm, the alarm state is immediately set to <code>INSUFFICIENT_DATA</code>. The alarm is then evaluated and its state is set appropriately. Any actions associated with the new state are then executed.</p> <p>When you update an existing alarm, its state is left unchanged, but the update completely overwrites the previous configuration of the alarm.</p> <p>If you are an IAM user, you must have Amazon EC2 permissions for some alarm operations:</p> <ul> <li> <p> <code>iam:CreateServiceLinkedRole</code> for all alarms with EC2 actions</p> </li> <li> <p> <code>ec2:DescribeInstanceStatus</code> and <code>ec2:DescribeInstances</code> for all alarms on EC2 instance status metrics</p> </li> <li> <p> <code>ec2:StopInstances</code> for alarms with stop actions</p> </li> <li> <p> <code>ec2:TerminateInstances</code> for alarms with terminate actions</p> </li> <li> <p>No specific permissions are needed for alarms with recover actions</p> </li> </ul> <p>If you have read/write permissions for Amazon CloudWatch but not for Amazon EC2, you can still create an alarm, but the stop or terminate actions are not performed. However, if you are later granted the required permissions, the alarm actions that you created earlier are performed.</p> <p>If you are using an IAM role (for example, an EC2 instance profile), you cannot stop or terminate the instance using alarm actions. However, you can still see the alarm state and perform any other actions such as Amazon SNS notifications or Auto Scaling policies.</p> <p>If you are using temporary security credentials granted using AWS STS, you cannot stop or terminate an EC2 instance using alarm actions.</p> <p>The first time you create an alarm in the AWS Management Console, the CLI, or by using the PutMetricAlarm API, CloudWatch creates the necessary service-linked role for you. The service-linked role is called <code>AWSServiceRoleForCloudWatchEvents</code>. For more information, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_terms-and-concepts.html#iam-term-service-linked-role\">AWS service-linked role</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PutMetricAlarmInput :
sig
  type t =
    {
    alarm_name: String.t ;
    alarm_description: String.t option ;
    actions_enabled: Boolean.t option ;
    o_k_actions: ResourceList.t ;
    alarm_actions: ResourceList.t ;
    insufficient_data_actions: ResourceList.t ;
    metric_name: String.t option ;
    namespace: String.t option ;
    statistic: Statistic.t option ;
    extended_statistic: String.t option ;
    dimensions: Dimensions.t ;
    period: Integer.t option ;
    unit: StandardUnit.t option ;
    evaluation_periods: Integer.t ;
    datapoints_to_alarm: Integer.t option ;
    threshold: Double.t option ;
    comparison_operator: ComparisonOperator.t ;
    treat_missing_data: String.t option ;
    evaluate_low_sample_count_percentile: String.t option ;
    metrics: MetricDataQueries.t ;
    tags: TagList.t ;
    threshold_metric_id: String.t option }
  val make :
    alarm_name:String.t ->
      ?alarm_description:String.t ->
        ?actions_enabled:Boolean.t ->
          ?o_k_actions:ResourceList.t ->
            ?alarm_actions:ResourceList.t ->
              ?insufficient_data_actions:ResourceList.t ->
                ?metric_name:String.t ->
                  ?namespace:String.t ->
                    ?statistic:Statistic.t ->
                      ?extended_statistic:String.t ->
                        ?dimensions:Dimensions.t ->
                          ?period:Integer.t ->
                            ?unit:StandardUnit.t ->
                              evaluation_periods:Integer.t ->
                                ?datapoints_to_alarm:Integer.t ->
                                  ?threshold:Double.t ->
                                    comparison_operator:ComparisonOperator.t
                                      ->
                                      ?treat_missing_data:String.t ->
                                        ?evaluate_low_sample_count_percentile:String.t
                                          ->
                                          ?metrics:MetricDataQueries.t ->
                                            ?tags:TagList.t ->
                                              ?threshold_metric_id:String.t
                                                -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = PutMetricAlarmInput.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error