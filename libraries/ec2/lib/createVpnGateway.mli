(** "<p>Creates a virtual private gateway. A virtual private gateway is the endpoint on the VPC side of your VPN connection. You can create a virtual private gateway before creating the VPC itself.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/vpn/latest/s2svpn/VPC_VPN.html\">AWS Site-to-Site VPN</a> in the <i>AWS Site-to-Site VPN User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateVpnGatewayRequest :
sig
  type t =
    {
    availability_zone: String.t option ;
    type_: GatewayType.t ;
    amazon_side_asn: Long.t option ;
    dry_run: Boolean.t option }[@@ocaml.doc
                                 "<p>Contains the parameters for CreateVpnGateway.</p>"]
  val make :
    ?availability_zone:String.t ->
      type_:GatewayType.t ->
        ?amazon_side_asn:Long.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateVpnGatewayResult = CreateVpnGatewayResult
type input = CreateVpnGatewayRequest.t
type output = CreateVpnGatewayResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error