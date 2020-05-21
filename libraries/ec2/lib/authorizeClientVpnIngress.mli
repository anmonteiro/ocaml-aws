(** "<p>Adds an ingress authorization rule to a Client VPN endpoint. Ingress authorization rules act as firewall rules that grant access to networks. You must configure ingress authorization rules to enable clients to access resources in AWS or on-premises networks.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AuthorizeClientVpnIngressRequest :
sig
  type t =
    {
    client_vpn_endpoint_id: String.t ;
    target_network_cidr: String.t ;
    access_group_id: String.t option ;
    authorize_all_groups: Boolean.t option ;
    description: String.t option ;
    client_token: String.t option ;
    dry_run: Boolean.t option }
  val make :
    client_vpn_endpoint_id:String.t ->
      target_network_cidr:String.t ->
        ?access_group_id:String.t ->
          ?authorize_all_groups:Boolean.t ->
            ?description:String.t ->
              ?client_token:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module AuthorizeClientVpnIngressResult = AuthorizeClientVpnIngressResult
type input = AuthorizeClientVpnIngressRequest.t
type output = AuthorizeClientVpnIngressResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error