(** "<p>Modifies the options for a VPN tunnel in an AWS Site-to-Site VPN connection. You can modify multiple options for a tunnel in a single request, but you can only modify one tunnel at a time. For more information, see <a href=\"https://docs.aws.amazon.com/vpn/latest/s2svpn/VPNTunnels.html\">Site-to-Site VPN Tunnel Options for Your Site-to-Site VPN Connection</a> in the <i>AWS Site-to-Site VPN User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyVpnTunnelOptionsRequest :
sig
  type t =
    {
    vpn_connection_id: String.t ;
    vpn_tunnel_outside_ip_address: String.t ;
    tunnel_options: ModifyVpnTunnelOptionsSpecification.t ;
    dry_run: Boolean.t option }
  val make :
    vpn_connection_id:String.t ->
      vpn_tunnel_outside_ip_address:String.t ->
        tunnel_options:ModifyVpnTunnelOptionsSpecification.t ->
          ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyVpnTunnelOptionsResult = ModifyVpnTunnelOptionsResult
type input = ModifyVpnTunnelOptionsRequest.t
type output = ModifyVpnTunnelOptionsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error