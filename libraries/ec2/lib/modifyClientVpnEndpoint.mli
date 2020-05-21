(** "<p>Modifies the specified Client VPN endpoint. You can only modify an endpoint's server certificate information, client connection logging information, DNS server, and description. Modifying the DNS server resets existing client connections.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyClientVpnEndpointRequest :
sig
  type t =
    {
    client_vpn_endpoint_id: String.t ;
    server_certificate_arn: String.t option ;
    connection_log_options: ConnectionLogOptions.t option ;
    dns_servers: DnsServersOptionsModifyStructure.t option ;
    description: String.t option ;
    split_tunnel: Boolean.t option ;
    dry_run: Boolean.t option }
  val make :
    client_vpn_endpoint_id:String.t ->
      ?server_certificate_arn:String.t ->
        ?connection_log_options:ConnectionLogOptions.t ->
          ?dns_servers:DnsServersOptionsModifyStructure.t ->
            ?description:String.t ->
              ?split_tunnel:Boolean.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyClientVpnEndpointResult = ModifyClientVpnEndpointResult
type input = ModifyClientVpnEndpointRequest.t
type output = ModifyClientVpnEndpointResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error