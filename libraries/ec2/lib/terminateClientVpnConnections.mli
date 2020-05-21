(** "<p>Terminates active Client VPN endpoint connections. This action can be used to terminate a specific client connection, or up to five connections established by a specific user.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module TerminateClientVpnConnectionsRequest :
sig
  type t =
    {
    client_vpn_endpoint_id: String.t ;
    connection_id: String.t option ;
    username: String.t option ;
    dry_run: Boolean.t option }
  val make :
    client_vpn_endpoint_id:String.t ->
      ?connection_id:String.t ->
        ?username:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module TerminateClientVpnConnectionsResult =
TerminateClientVpnConnectionsResult
type input = TerminateClientVpnConnectionsRequest.t
type output = TerminateClientVpnConnectionsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error