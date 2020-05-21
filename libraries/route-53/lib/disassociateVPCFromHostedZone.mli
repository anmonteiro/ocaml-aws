(** "<p>Disassociates a VPC from a Amazon Route 53 private hosted zone. Note the following:</p> <ul> <li> <p>You can't disassociate the last VPC from a private hosted zone.</p> </li> <li> <p>You can't convert a private hosted zone into a public hosted zone.</p> </li> <li> <p>You can submit a <code>DisassociateVPCFromHostedZone</code> request using either the account that created the hosted zone or the account that created the VPC.</p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DisassociateVPCFromHostedZoneRequest :
sig
  type t =
    {
    hosted_zone_id: String.t ;
    v_p_c: VPC.t ;
    comment: String.t option }[@@ocaml.doc
                                "<p>A complex type that contains information about the VPC that you want to disassociate from a specified private hosted zone.</p>"]
  val make :
    hosted_zone_id:String.t -> v_p_c:VPC.t -> ?comment:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DisassociateVPCFromHostedZoneResponse =
DisassociateVPCFromHostedZoneResponse
type input = DisassociateVPCFromHostedZoneRequest.t
type output = DisassociateVPCFromHostedZoneResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error