(** "<p>Modifies the target gateway of an AWS Site-to-Site VPN connection. The following migration options are available:</p> <ul> <li> <p>An existing virtual private gateway to a new virtual private gateway</p> </li> <li> <p>An existing virtual private gateway to a transit gateway</p> </li> <li> <p>An existing transit gateway to a new transit gateway</p> </li> <li> <p>An existing transit gateway to a virtual private gateway</p> </li> </ul> <p>Before you perform the migration to the new gateway, you must configure the new gateway. Use <a>CreateVpnGateway</a> to create a virtual private gateway, or <a>CreateTransitGateway</a> to create a transit gateway.</p> <p>This step is required when you migrate from a virtual private gateway with static routes to a transit gateway. </p> <p>You must delete the static routes before you migrate to the new gateway.</p> <p>Keep a copy of the static route before you delete it. You will need to add back these routes to the transit gateway after the VPN connection migration is complete.</p> <p>After you migrate to the new gateway, you might need to modify your VPC route table. Use <a>CreateRoute</a> and <a>DeleteRoute</a> to make the changes described in <a href=\"https://docs.aws.amazon.com/vpn/latest/s2svpn/modify-vpn-target.html#step-update-routing\">VPN Gateway Target Modification Required VPC Route Table Updates</a> in the <i>AWS Site-to-Site VPN User Guide</i>.</p> <p> When the new gateway is a transit gateway, modify the transit gateway route table to allow traffic between the VPC and the AWS Site-to-Site VPN connection. Use <a>CreateTransitGatewayRoute</a> to add the routes.</p> <p> If you deleted VPN static routes, you must add the static routes to the transit gateway route table.</p> <p>After you perform this operation, the AWS VPN endpoint's IP addresses on the AWS side and the tunnel options remain intact. Your s2slong; connection will be temporarily unavailable for approximately 10 minutes while we provision the new endpoints </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyVpnConnectionRequest :
sig
  type t =
    {
    vpn_connection_id: String.t ;
    transit_gateway_id: String.t option ;
    customer_gateway_id: String.t option ;
    vpn_gateway_id: String.t option ;
    dry_run: Boolean.t option }
  val make :
    vpn_connection_id:String.t ->
      ?transit_gateway_id:String.t ->
        ?customer_gateway_id:String.t ->
          ?vpn_gateway_id:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyVpnConnectionResult = ModifyVpnConnectionResult
type input = ModifyVpnConnectionRequest.t
type output = ModifyVpnConnectionResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error