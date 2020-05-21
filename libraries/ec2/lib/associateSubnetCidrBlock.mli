(** "<p>Associates a CIDR block with your subnet. You can only associate a single IPv6 CIDR block with your subnet. An IPv6 CIDR block must have a prefix length of /64.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AssociateSubnetCidrBlockRequest :
sig
  type t = {
    ipv6_cidr_block: String.t ;
    subnet_id: String.t }
  val make : ipv6_cidr_block:String.t -> subnet_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module AssociateSubnetCidrBlockResult = AssociateSubnetCidrBlockResult
type input = AssociateSubnetCidrBlockRequest.t
type output = AssociateSubnetCidrBlockResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error