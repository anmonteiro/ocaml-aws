(** "<p>Attaches the specified VPC to the specified transit gateway.</p> <p>If you attach a VPC with a CIDR range that overlaps the CIDR range of a VPC that is already attached, the new VPC CIDR range is not propagated to the default propagation route table.</p> <p>To send VPC traffic to an attached transit gateway, add a route to the VPC route table using <a>CreateRoute</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateTransitGatewayVpcAttachmentRequest :
sig
  type t =
    {
    transit_gateway_id: String.t ;
    vpc_id: String.t ;
    subnet_ids: ValueStringList.t ;
    options: CreateTransitGatewayVpcAttachmentRequestOptions.t option ;
    tag_specifications: TagSpecificationList.t ;
    dry_run: Boolean.t option }
  val make :
    transit_gateway_id:String.t ->
      vpc_id:String.t ->
        subnet_ids:ValueStringList.t ->
          ?options:CreateTransitGatewayVpcAttachmentRequestOptions.t ->
            ?tag_specifications:TagSpecificationList.t ->
              ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateTransitGatewayVpcAttachmentResult =
CreateTransitGatewayVpcAttachmentResult
type input = CreateTransitGatewayVpcAttachmentRequest.t
type output = CreateTransitGatewayVpcAttachmentResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error