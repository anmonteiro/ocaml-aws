(** "<p>Downloads the contents of the Client VPN endpoint configuration file for the specified Client VPN endpoint. The Client VPN endpoint configuration file includes the Client VPN endpoint and certificate information clients need to establish a connection with the Client VPN endpoint.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ExportClientVpnClientConfigurationRequest :
sig
  type t = {
    client_vpn_endpoint_id: String.t ;
    dry_run: Boolean.t option }
  val make :
    client_vpn_endpoint_id:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ExportClientVpnClientConfigurationResult =
ExportClientVpnClientConfigurationResult
type input = ExportClientVpnClientConfigurationRequest.t
type output = ExportClientVpnClientConfigurationResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error