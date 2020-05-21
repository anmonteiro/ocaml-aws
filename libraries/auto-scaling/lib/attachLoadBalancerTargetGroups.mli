(** "<p>Attaches one or more target groups to the specified Auto Scaling group.</p> <p>To describe the target groups for an Auto Scaling group, use <a>DescribeLoadBalancerTargetGroups</a>. To detach the target group from the Auto Scaling group, use <a>DetachLoadBalancerTargetGroups</a>.</p> <p>With Application Load Balancers and Network Load Balancers, instances are registered as targets with a target group. With Classic Load Balancers, instances are registered with the load balancer. For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/attach-load-balancer-asg.html\">Attaching a Load Balancer to Your Auto Scaling Group</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AttachLoadBalancerTargetGroupsType :
sig
  type t =
    {
    auto_scaling_group_name: String.t ;
    target_group_a_r_ns: TargetGroupARNs.t }
  val make :
    auto_scaling_group_name:String.t ->
      target_group_a_r_ns:TargetGroupARNs.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = AttachLoadBalancerTargetGroupsType.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error