(** "<p>Creates a VPN connection between an existing virtual private gateway and a VPN customer gateway. The supported connection type is <code>ipsec.1</code>.</p> <p>The response includes information that you need to give to your network administrator to configure your customer gateway.</p> <important> <p>We strongly recommend that you use HTTPS when calling this operation because the response contains sensitive cryptographic information for configuring your customer gateway.</p> </important> <p>If you decide to shut down your VPN connection for any reason and later create a new VPN connection, you must reconfigure your customer gateway with the new information returned from this call.</p> <p>This is an idempotent operation. If you perform the operation more than once, Amazon EC2 doesn't return an error.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/vpn/latest/s2svpn/VPC_VPN.html\">AWS Site-to-Site VPN</a> in the <i>AWS Site-to-Site VPN User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateVpnConnectionRequest :
sig
  type t =
    {
    customer_gateway_id: String.t ;
    type_: String.t ;
    vpn_gateway_id: String.t option ;
    transit_gateway_id: String.t option ;
    dry_run: Boolean.t option ;
    options: VpnConnectionOptionsSpecification.t option }[@@ocaml.doc
                                                           "<p>Contains the parameters for CreateVpnConnection.</p>"]
  val make :
    customer_gateway_id:String.t ->
      type_:String.t ->
        ?vpn_gateway_id:String.t ->
          ?transit_gateway_id:String.t ->
            ?dry_run:Boolean.t ->
              ?options:VpnConnectionOptionsSpecification.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateVpnConnectionResult = CreateVpnConnectionResult
type input = CreateVpnConnectionRequest.t
type output = CreateVpnConnectionResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error