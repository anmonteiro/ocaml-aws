(** "<p>Describes the load balancers for the specified Auto Scaling group.</p> <p>This operation describes only Classic Load Balancers. If you have Application Load Balancers or Network Load Balancers, use <a>DescribeLoadBalancerTargetGroups</a> instead.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeLoadBalancersRequest :
sig
  type t =
    {
    auto_scaling_group_name: String.t ;
    next_token: String.t option ;
    max_records: Integer.t option }
  val make :
    auto_scaling_group_name:String.t ->
      ?next_token:String.t -> ?max_records:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeLoadBalancersResponse = DescribeLoadBalancersResponse
type input = DescribeLoadBalancersRequest.t
type output = DescribeLoadBalancersResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error