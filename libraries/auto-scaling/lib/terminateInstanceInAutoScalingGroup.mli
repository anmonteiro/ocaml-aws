(** "<p>Terminates the specified instance and optionally adjusts the desired group size.</p> <p>This call simply makes a termination request. The instance is not terminated immediately.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module TerminateInstanceInAutoScalingGroupType :
sig
  type t =
    {
    instance_id: String.t ;
    should_decrement_desired_capacity: Boolean.t }
  val make :
    instance_id:String.t ->
      should_decrement_desired_capacity:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ActivityType = ActivityType
type input = TerminateInstanceInAutoScalingGroupType.t
type output = ActivityType.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error