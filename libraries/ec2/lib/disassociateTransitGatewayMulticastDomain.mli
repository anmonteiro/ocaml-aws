(** "<p>Disassociates the specified subnets from the transit gateway multicast domain. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DisassociateTransitGatewayMulticastDomainRequest :
sig
  type t =
    {
    transit_gateway_multicast_domain_id: String.t option ;
    transit_gateway_attachment_id: String.t option ;
    subnet_ids: ValueStringList.t ;
    dry_run: Boolean.t option }
  val make :
    ?transit_gateway_multicast_domain_id:String.t ->
      ?transit_gateway_attachment_id:String.t ->
        ?subnet_ids:ValueStringList.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DisassociateTransitGatewayMulticastDomainResult =
DisassociateTransitGatewayMulticastDomainResult
type input = DisassociateTransitGatewayMulticastDomainRequest.t
type output = DisassociateTransitGatewayMulticastDomainResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error