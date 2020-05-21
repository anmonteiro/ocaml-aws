(** "<p>Modifies the specified VPC attachment.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyTransitGatewayVpcAttachmentRequest :
sig
  type t =
    {
    transit_gateway_attachment_id: String.t ;
    add_subnet_ids: ValueStringList.t ;
    remove_subnet_ids: ValueStringList.t ;
    options: ModifyTransitGatewayVpcAttachmentRequestOptions.t option ;
    dry_run: Boolean.t option }
  val make :
    transit_gateway_attachment_id:String.t ->
      ?add_subnet_ids:ValueStringList.t ->
        ?remove_subnet_ids:ValueStringList.t ->
          ?options:ModifyTransitGatewayVpcAttachmentRequestOptions.t ->
            ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyTransitGatewayVpcAttachmentResult =
ModifyTransitGatewayVpcAttachmentResult
type input = ModifyTransitGatewayVpcAttachmentRequest.t
type output = ModifyTransitGatewayVpcAttachmentResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error