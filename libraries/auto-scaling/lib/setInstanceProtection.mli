(** "<p>Updates the instance protection settings of the specified instances.</p> <p>For more information about preventing instances that are part of an Auto Scaling group from terminating on scale in, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-instance-termination.html#instance-protection\">Instance Protection</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module SetInstanceProtectionQuery :
sig
  type t =
    {
    instance_ids: InstanceIds.t ;
    auto_scaling_group_name: String.t ;
    protected_from_scale_in: Boolean.t }
  val make :
    instance_ids:InstanceIds.t ->
      auto_scaling_group_name:String.t ->
        protected_from_scale_in:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = SetInstanceProtectionQuery.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error