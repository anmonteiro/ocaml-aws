(** "<p>Detaches one or more target groups from the specified Auto Scaling group.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DetachLoadBalancerTargetGroupsType :
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
type input = DetachLoadBalancerTargetGroupsType.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error