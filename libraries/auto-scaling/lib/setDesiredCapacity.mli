(** "<p>Sets the size of the specified Auto Scaling group.</p> <p>For more information about desired capacity, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/what-is-amazon-ec2-auto-scaling.html\">What Is Amazon EC2 Auto Scaling?</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module SetDesiredCapacityType :
sig
  type t =
    {
    auto_scaling_group_name: String.t ;
    desired_capacity: Integer.t ;
    honor_cooldown: Boolean.t option }
  val make :
    auto_scaling_group_name:String.t ->
      desired_capacity:Integer.t -> ?honor_cooldown:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = SetDesiredCapacityType.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error