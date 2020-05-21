open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutScalingPolicyType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      policy_name: String.t [@ocaml.doc "<p>The name of the policy.</p>"];
      policy_type: String.t option
        [@ocaml.doc
          "<p>The policy type. The valid values are <code>SimpleScaling</code>, <code>StepScaling</code>, and <code>TargetTrackingScaling</code>. If the policy type is null, the value is treated as <code>SimpleScaling</code>.</p>"];
      adjustment_type: String.t option
        [@ocaml.doc
          "<p>Specifies whether the <code>ScalingAdjustment</code> parameter is an absolute number or a percentage of the current capacity. The valid values are <code>ChangeInCapacity</code>, <code>ExactCapacity</code>, and <code>PercentChangeInCapacity</code>.</p> <p>Valid only if the policy type is <code>StepScaling</code> or <code>SimpleScaling</code>. For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-scaling-simple-step.html#as-scaling-adjustment\">Scaling Adjustment Types</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"];
      min_adjustment_step: Integer.t option
        [@ocaml.doc
          "<p>Available for backward compatibility. Use <code>MinAdjustmentMagnitude</code> instead.</p>"];
      min_adjustment_magnitude: Integer.t option
        [@ocaml.doc
          "<p>The minimum number of instances to scale. If the value of <code>AdjustmentType</code> is <code>PercentChangeInCapacity</code>, the scaling policy changes the <code>DesiredCapacity</code> of the Auto Scaling group by at least this many instances. Otherwise, the error is <code>ValidationError</code>.</p> <p>This property replaces the <code>MinAdjustmentStep</code> property. For example, suppose that you create a step scaling policy to scale out an Auto Scaling group by 25 percent and you specify a <code>MinAdjustmentMagnitude</code> of 2. If the group has 4 instances and the scaling policy is performed, 25 percent of 4 is 1. However, because you specified a <code>MinAdjustmentMagnitude</code> of 2, Amazon EC2 Auto Scaling scales out the group by 2 instances.</p> <p>Valid only if the policy type is <code>SimpleScaling</code> or <code>StepScaling</code>.</p>"];
      scaling_adjustment: Integer.t option
        [@ocaml.doc
          "<p>The amount by which a simple scaling policy scales the Auto Scaling group in response to an alarm breach. The adjustment is based on the value that you specified in the <code>AdjustmentType</code> parameter (either an absolute number or a percentage). A positive value adds to the current capacity and a negative value subtracts from the current capacity. For exact capacity, you must specify a positive value.</p> <p>Conditional: If you specify <code>SimpleScaling</code> for the policy type, you must specify this parameter. (Not used with any other policy type.) </p>"];
      cooldown: Integer.t option
        [@ocaml.doc
          "<p>The amount of time, in seconds, after a scaling activity completes before any further dynamic scaling activities can start. If this parameter is not specified, the default cooldown period for the group applies.</p> <p>Valid only if the policy type is <code>SimpleScaling</code>. For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/Cooldown.html\">Scaling Cooldowns</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"];
      metric_aggregation_type: String.t option
        [@ocaml.doc
          "<p>The aggregation type for the CloudWatch metrics. The valid values are <code>Minimum</code>, <code>Maximum</code>, and <code>Average</code>. If the aggregation type is null, the value is treated as <code>Average</code>.</p> <p>Valid only if the policy type is <code>StepScaling</code>.</p>"];
      step_adjustments: StepAdjustments.t
        [@ocaml.doc
          "<p>A set of adjustments that enable you to scale based on the size of the alarm breach.</p> <p>Conditional: If you specify <code>StepScaling</code> for the policy type, you must specify this parameter. (Not used with any other policy type.) </p>"];
      estimated_instance_warmup: Integer.t option
        [@ocaml.doc
          "<p>The estimated time, in seconds, until a newly launched instance can contribute to the CloudWatch metrics. The default is to use the value specified for the default cooldown period for the group.</p> <p>Valid only if the policy type is <code>StepScaling</code> or <code>TargetTrackingScaling</code>.</p>"];
      target_tracking_configuration: TargetTrackingConfiguration.t option
        [@ocaml.doc
          "<p>A target tracking scaling policy. Includes support for predefined or customized metrics.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_TargetTrackingConfiguration.html\">TargetTrackingConfiguration</a> in the <i>Amazon EC2 Auto Scaling API Reference</i>.</p> <p>Conditional: If you specify <code>TargetTrackingScaling</code> for the policy type, you must specify this parameter. (Not used with any other policy type.) </p>"]}
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end
module PolicyARNType = PolicyARNType
type input = PutScalingPolicyType.t
type output = PolicyARNType.t
type error = Errors_internal.t
let streaming = false
let service = "autoscaling"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2011-01-01"]); ("Action", ["PutScalingPolicy"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (PutScalingPolicyType.to_query req))))) in
  (`POST, uri, (Headers.render (PutScalingPolicyType.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "PutScalingPolicyResponse" (snd xml))
        (Xml.member "PutScalingPolicyResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp PolicyARNType.parse)
          (BadResponse
             { body; message = "Could not find well formed PolicyARNType." })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing PolicyARNType - missing field in body or children: "
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