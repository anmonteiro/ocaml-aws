(** "<p>Modifies the VPN tunnel endpoint certificate.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyVpnTunnelCertificateRequest :
sig
  type t =
    {
    vpn_connection_id: String.t ;
    vpn_tunnel_outside_ip_address: String.t ;
    dry_run: Boolean.t option }
  val make :
    vpn_connection_id:String.t ->
      vpn_tunnel_outside_ip_address:String.t ->
        ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyVpnTunnelCertificateResult = ModifyVpnTunnelCertificateResult
type input = ModifyVpnTunnelCertificateRequest.t
type output = ModifyVpnTunnelCertificateResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error