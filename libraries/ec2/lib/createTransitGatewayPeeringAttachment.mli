(** "<p>Requests a transit gateway peering attachment between the specified transit gateway (requester) and a peer transit gateway (accepter). The transit gateways must be in different Regions. The peer transit gateway can be in your account or a different AWS account. </p> <p>After you create the peering attachment, the owner of the accepter transit gateway must accept the attachment request.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateTransitGatewayPeeringAttachmentRequest :
sig
  type t =
    {
    transit_gateway_id: String.t ;
    peer_transit_gateway_id: String.t ;
    peer_account_id: String.t ;
    peer_region: String.t ;
    tag_specifications: TagSpecificationList.t ;
    dry_run: Boolean.t option }
  val make :
    transit_gateway_id:String.t ->
      peer_transit_gateway_id:String.t ->
        peer_account_id:String.t ->
          peer_region:String.t ->
            ?tag_specifications:TagSpecificationList.t ->
              ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateTransitGatewayPeeringAttachmentResult =
CreateTransitGatewayPeeringAttachmentResult
type input = CreateTransitGatewayPeeringAttachmentRequest.t
type output = CreateTransitGatewayPeeringAttachmentResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error