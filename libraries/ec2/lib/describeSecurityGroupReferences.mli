(** "<p>[VPC only] Describes the VPCs on the other side of a VPC peering connection that are referencing the security groups you've specified in this request.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeSecurityGroupReferencesRequest :
sig
  type t = {
    dry_run: Boolean.t option ;
    group_id: GroupIds.t }
  val make : ?dry_run:Boolean.t -> group_id:GroupIds.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeSecurityGroupReferencesResult =
DescribeSecurityGroupReferencesResult
type input = DescribeSecurityGroupReferencesRequest.t
type output = DescribeSecurityGroupReferencesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error