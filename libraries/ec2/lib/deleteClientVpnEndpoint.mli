(** "<p>Deletes the specified Client VPN endpoint. You must disassociate all target networks before you can delete a Client VPN endpoint.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteClientVpnEndpointRequest :
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
module DeleteClientVpnEndpointResult = DeleteClientVpnEndpointResult
type input = DeleteClientVpnEndpointRequest.t
type output = DeleteClientVpnEndpointResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error