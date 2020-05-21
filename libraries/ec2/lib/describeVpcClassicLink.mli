(** "<p>Describes the ClassicLink status of one or more VPCs.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeVpcClassicLinkRequest :
sig
  type t =
    {
    filters: FilterList.t ;
    dry_run: Boolean.t option ;
    vpc_ids: VpcClassicLinkIdList.t }
  val make :
    ?filters:FilterList.t ->
      ?dry_run:Boolean.t -> ?vpc_ids:VpcClassicLinkIdList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeVpcClassicLinkResult = DescribeVpcClassicLinkResult
type input = DescribeVpcClassicLinkRequest.t
type output = DescribeVpcClassicLinkResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error