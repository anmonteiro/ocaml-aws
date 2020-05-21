(** "<p>Associates the specified subnets and transit gateway attachments with the specified transit gateway multicast domain.</p> <p>The transit gateway attachment must be in the available state before you can add a resource. Use <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeTransitGatewayAttachments.html\">DescribeTransitGatewayAttachments</a> to see the state of the attachment.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AssociateTransitGatewayMulticastDomainRequest :
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
module AssociateTransitGatewayMulticastDomainResult =
AssociateTransitGatewayMulticastDomainResult
type input = AssociateTransitGatewayMulticastDomainRequest.t
type output = AssociateTransitGatewayMulticastDomainResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error