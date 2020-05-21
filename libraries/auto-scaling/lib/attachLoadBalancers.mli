(** "<p>Attaches one or more Classic Load Balancers to the specified Auto Scaling group.</p> <p>To attach an Application Load Balancer or a Network Load Balancer instead, see <a>AttachLoadBalancerTargetGroups</a>.</p> <p>To describe the load balancers for an Auto Scaling group, use <a>DescribeLoadBalancers</a>. To detach the load balancer from the Auto Scaling group, use <a>DetachLoadBalancers</a>.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/attach-load-balancer-asg.html\">Attaching a Load Balancer to Your Auto Scaling Group</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AttachLoadBalancersType :
sig
  type t =
    {
    auto_scaling_group_name: String.t ;
    load_balancer_names: LoadBalancerNames.t }
  val make :
    auto_scaling_group_name:String.t ->
      load_balancer_names:LoadBalancerNames.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = AttachLoadBalancersType.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error