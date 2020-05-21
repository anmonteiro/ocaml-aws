(** "<p>Describes one or more Auto Scaling instances.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeAutoScalingInstancesType :
sig
  type t =
    {
    instance_ids: InstanceIds.t ;
    max_records: Integer.t option ;
    next_token: String.t option }
  val make :
    ?instance_ids:InstanceIds.t ->
      ?max_records:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module AutoScalingInstancesType = AutoScalingInstancesType
type input = DescribeAutoScalingInstancesType.t
type output = AutoScalingInstancesType.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error