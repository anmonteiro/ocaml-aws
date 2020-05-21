open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ExecutePolicyType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t option
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      policy_name: String.t
        [@ocaml.doc "<p>The name or ARN of the policy.</p>"];
      honor_cooldown: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether Amazon EC2 Auto Scaling waits for the cooldown period to complete before executing the policy.</p> <p>This parameter is not supported if the policy type is <code>StepScaling</code> or <code>TargetTrackingScaling</code>.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/Cooldown.html\">Scaling Cooldowns</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>"];
      metric_value: Double.t option
        [@ocaml.doc
          "<p>The metric value to compare to <code>BreachThreshold</code>. This enables you to execute a policy of type <code>StepScaling</code> and determine which step adjustment to use. For example, if the breach threshold is 50 and you want to use a step adjustment with a lower bound of 0 and an upper bound of 10, you can set the metric value to 59.</p> <p>If you specify a metric value that doesn't correspond to a step adjustment for the policy, the call returns an error.</p> <p>Conditional: This parameter is required if the policy type is <code>StepScaling</code> and not supported otherwise.</p>"];
      breach_threshold: Double.t option
        [@ocaml.doc
          "<p>The breach threshold for the alarm.</p> <p>Conditional: This parameter is required if the policy type is <code>StepScaling</code> and not supported otherwise.</p>"]}
    let make ?auto_scaling_group_name  ~policy_name  ?honor_cooldown 
      ?metric_value  ?breach_threshold  () =
      {
        auto_scaling_group_name;
        policy_name;
        honor_cooldown;
        metric_value;
        breach_threshold
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end
module Output = Aws.BaseTypes.Unit
type input = ExecutePolicyType.t
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
         [("Version", ["2011-01-01"]); ("Action", ["ExecutePolicy"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ExecutePolicyType.to_query req))))) in
  (`POST, uri, (Headers.render (ExecutePolicyType.to_headers req)), "")
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