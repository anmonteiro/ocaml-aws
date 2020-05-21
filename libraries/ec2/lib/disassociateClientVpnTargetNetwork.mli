(** "<p>Disassociates a target network from the specified Client VPN endpoint. When you disassociate the last target network from a Client VPN, the following happens:</p> <ul> <li> <p>The route that was automatically added for the VPC is deleted</p> </li> <li> <p>All active client connections are terminated</p> </li> <li> <p>New client connections are disallowed</p> </li> <li> <p>The Client VPN endpoint's status changes to <code>pending-associate</code> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DisassociateClientVpnTargetNetworkRequest :
sig
  type t =
    {
    client_vpn_endpoint_id: String.t ;
    association_id: String.t ;
    dry_run: Boolean.t option }
  val make :
    client_vpn_endpoint_id:String.t ->
      association_id:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DisassociateClientVpnTargetNetworkResult =
DisassociateClientVpnTargetNetworkResult
type input = DisassociateClientVpnTargetNetworkRequest.t
type output = DisassociateClientVpnTargetNetworkResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error