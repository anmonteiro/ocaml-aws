(** "<p>Provides information to AWS about your VPN customer gateway device. The customer gateway is the appliance at your end of the VPN connection. (The device on the AWS side of the VPN connection is the virtual private gateway.) You must provide the Internet-routable IP address of the customer gateway's external interface. The IP address must be static and can be behind a device performing network address translation (NAT).</p> <p>For devices that use Border Gateway Protocol (BGP), you can also provide the device's BGP Autonomous System Number (ASN). You can use an existing ASN assigned to your network. If you don't have an ASN already, you can use a private ASN (in the 64512 - 65534 range).</p> <note> <p>Amazon EC2 supports all 2-byte ASN numbers in the range of 1 - 65534, with the exception of 7224, which is reserved in the <code>us-east-1</code> Region, and 9059, which is reserved in the <code>eu-west-1</code> Region.</p> </note> <p>For more information, see <a href=\"https://docs.aws.amazon.com/vpn/latest/s2svpn/VPC_VPN.html\">AWS Site-to-Site VPN</a> in the <i>AWS Site-to-Site VPN User Guide</i>.</p> <important> <p>To create more than one customer gateway with the same VPN type, IP address, and BGP ASN, specify a unique device name for each customer gateway. Identical requests return information about the existing customer gateway and do not create new customer gateways.</p> </important>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateCustomerGatewayRequest :
sig
  type t =
    {
    bgp_asn: Integer.t ;
    public_ip: String.t option ;
    certificate_arn: String.t option ;
    type_: GatewayType.t ;
    device_name: String.t option ;
    dry_run: Boolean.t option }[@@ocaml.doc
                                 "<p>Contains the parameters for CreateCustomerGateway.</p>"]
  val make :
    bgp_asn:Integer.t ->
      ?public_ip:String.t ->
        ?certificate_arn:String.t ->
          type_:GatewayType.t ->
            ?device_name:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateCustomerGatewayResult = CreateCustomerGatewayResult
type input = CreateCustomerGatewayRequest.t
type output = CreateCustomerGatewayResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error