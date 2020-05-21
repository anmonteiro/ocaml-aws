(** "<p>Removes an ingress authorization rule from a Client VPN endpoint. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RevokeClientVpnIngressRequest :
sig
  type t =
    {
    client_vpn_endpoint_id: String.t ;
    target_network_cidr: String.t ;
    access_group_id: String.t option ;
    revoke_all_groups: Boolean.t option ;
    dry_run: Boolean.t option }
  val make :
    client_vpn_endpoint_id:String.t ->
      target_network_cidr:String.t ->
        ?access_group_id:String.t ->
          ?revoke_all_groups:Boolean.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module RevokeClientVpnIngressResult = RevokeClientVpnIngressResult
type input = RevokeClientVpnIngressRequest.t
type output = RevokeClientVpnIngressResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error