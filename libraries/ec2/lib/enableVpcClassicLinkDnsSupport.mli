(** "<p>Enables a VPC to support DNS hostname resolution for ClassicLink. If enabled, the DNS hostname of a linked EC2-Classic instance resolves to its private IP address when addressed from an instance in the VPC to which it's linked. Similarly, the DNS hostname of an instance in a VPC resolves to its private IP address when addressed from a linked EC2-Classic instance. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/vpc-classiclink.html\">ClassicLink</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module EnableVpcClassicLinkDnsSupportRequest :
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
module EnableVpcClassicLinkDnsSupportResult =
EnableVpcClassicLinkDnsSupportResult
type input = EnableVpcClassicLinkDnsSupportRequest.t
type output = EnableVpcClassicLinkDnsSupportResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error