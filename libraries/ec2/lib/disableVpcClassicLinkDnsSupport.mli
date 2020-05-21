(** "<p>Disables ClassicLink DNS support for a VPC. If disabled, DNS hostnames resolve to public IP addresses when addressed between a linked EC2-Classic instance and instances in the VPC to which it's linked. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/vpc-classiclink.html\">ClassicLink</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DisableVpcClassicLinkDnsSupportRequest :
sig
  type t = {
    vpc_id: String.t option }
  val make : ?vpc_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DisableVpcClassicLinkDnsSupportResult =
DisableVpcClassicLinkDnsSupportResult
type input = DisableVpcClassicLinkDnsSupportRequest.t
type output = DisableVpcClassicLinkDnsSupportResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error