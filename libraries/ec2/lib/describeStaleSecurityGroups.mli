(** "<p>[VPC only] Describes the stale security group rules for security groups in a specified VPC. Rules are stale when they reference a deleted security group in a peer VPC, or a security group in a peer VPC for which the VPC peering connection has been deleted.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeStaleSecurityGroupsRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    max_results: Integer.t option ;
    next_token: String.t option ;
    vpc_id: String.t }
  val make :
    ?dry_run:Boolean.t ->
      ?max_results:Integer.t ->
        ?next_token:String.t -> vpc_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeStaleSecurityGroupsResult = DescribeStaleSecurityGroupsResult
type input = DescribeStaleSecurityGroupsRequest.t
type output = DescribeStaleSecurityGroupsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error