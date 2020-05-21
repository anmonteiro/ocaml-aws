(** "<p>Describes the lifecycle hooks for the specified Auto Scaling group.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeLifecycleHooksType :
sig
  type t =
    {
    auto_scaling_group_name: String.t ;
    lifecycle_hook_names: LifecycleHookNames.t }
  val make :
    auto_scaling_group_name:String.t ->
      ?lifecycle_hook_names:LifecycleHookNames.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeLifecycleHooksAnswer = DescribeLifecycleHooksAnswer
type input = DescribeLifecycleHooksType.t
type output = DescribeLifecycleHooksAnswer.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error