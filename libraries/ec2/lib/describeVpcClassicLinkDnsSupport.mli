(** "<p>Describes the ClassicLink DNS support status of one or more VPCs. If enabled, the DNS hostname of a linked EC2-Classic instance resolves to its private IP address when addressed from an instance in the VPC to which it's linked. Similarly, the DNS hostname of an instance in a VPC resolves to its private IP address when addressed from a linked EC2-Classic instance. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/vpc-classiclink.html\">ClassicLink</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeVpcClassicLinkDnsSupportRequest :
sig
  type t =
    {
    max_results: Integer.t option ;
    next_token: String.t option ;
    vpc_ids: VpcClassicLinkIdList.t }
  val make :
    ?max_results:Integer.t ->
      ?next_token:String.t -> ?vpc_ids:VpcClassicLinkIdList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeVpcClassicLinkDnsSupportResult =
DescribeVpcClassicLinkDnsSupportResult
type input = DescribeVpcClassicLinkDnsSupportRequest.t
type output = DescribeVpcClassicLinkDnsSupportResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error