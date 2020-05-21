(** "<p>Creates a transit gateway.</p> <p>You can use a transit gateway to interconnect your virtual private clouds (VPC) and on-premises networks. After the transit gateway enters the <code>available</code> state, you can attach your VPCs and VPN connections to the transit gateway.</p> <p>To attach your VPCs, use <a>CreateTransitGatewayVpcAttachment</a>.</p> <p>To attach a VPN connection, use <a>CreateCustomerGateway</a> to create a customer gateway and specify the ID of the customer gateway and the ID of the transit gateway in a call to <a>CreateVpnConnection</a>.</p> <p>When you create a transit gateway, we create a default transit gateway route table and use it as the default association route table and the default propagation route table. You can use <a>CreateTransitGatewayRouteTable</a> to create additional transit gateway route tables. If you disable automatic route propagation, we do not create a default transit gateway route table. You can use <a>EnableTransitGatewayRouteTablePropagation</a> to propagate routes from a resource attachment to a transit gateway route table. If you disable automatic associations, you can use <a>AssociateTransitGatewayRouteTable</a> to associate a resource attachment with a transit gateway route table.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateTransitGatewayRequest :
sig
  type t =
    {
    description: String.t option ;
    options: TransitGatewayRequestOptions.t option ;
    tag_specifications: TagSpecificationList.t ;
    dry_run: Boolean.t option }
  val make :
    ?description:String.t ->
      ?options:TransitGatewayRequestOptions.t ->
        ?tag_specifications:TagSpecificationList.t ->
          ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateTransitGatewayResult = CreateTransitGatewayResult
type input = CreateTransitGatewayRequest.t
type output = CreateTransitGatewayResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error