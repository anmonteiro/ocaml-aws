(** "<p>Applies a security group to the association between the target network and the Client VPN endpoint. This action replaces the existing security groups with the specified security groups.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ApplySecurityGroupsToClientVpnTargetNetworkRequest :
sig
  type t =
    {
    client_vpn_endpoint_id: String.t ;
    vpc_id: String.t ;
    security_group_ids: ClientVpnSecurityGroupIdSet.t ;
    dry_run: Boolean.t option }
  val make :
    client_vpn_endpoint_id:String.t ->
      vpc_id:String.t ->
        security_group_ids:ClientVpnSecurityGroupIdSet.t ->
          ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ApplySecurityGroupsToClientVpnTargetNetworkResult =
ApplySecurityGroupsToClientVpnTargetNetworkResult
type input = ApplySecurityGroupsToClientVpnTargetNetworkRequest.t
type output = ApplySecurityGroupsToClientVpnTargetNetworkResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error