(** "<p>Creates a static route associated with a VPN connection between an existing virtual private gateway and a VPN customer gateway. The static route allows traffic to be routed from the virtual private gateway to the VPN customer gateway.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/vpn/latest/s2svpn/VPC_VPN.html\">AWS Site-to-Site VPN</a> in the <i>AWS Site-to-Site VPN User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateVpnConnectionRouteRequest :
sig
  type t = {
    destination_cidr_block: String.t ;
    vpn_connection_id: String.t }[@@ocaml.doc
                                   "<p>Contains the parameters for CreateVpnConnectionRoute.</p>"]
  val make :
    destination_cidr_block:String.t ->
      vpn_connection_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = CreateVpnConnectionRouteRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error