(** "<p>Disassociates a CIDR block from a VPC. To disassociate the CIDR block, you must specify its association ID. You can get the association ID by using <a>DescribeVpcs</a>. You must detach or delete all gateways and resources that are associated with the CIDR block before you can disassociate it. </p> <p>You cannot disassociate the CIDR block with which you originally created the VPC (the primary CIDR block).</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DisassociateVpcCidrBlockRequest :
sig
  type t = {
    association_id: String.t }
  val make : association_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DisassociateVpcCidrBlockResult = DisassociateVpcCidrBlockResult
type input = DisassociateVpcCidrBlockRequest.t
type output = DisassociateVpcCidrBlockResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error