(** "<p>Adds a route to a network to a Client VPN endpoint. Each Client VPN endpoint has a route table that describes the available destination network routes. Each route in the route table specifies the path for tra\239\172\131c to speci\239\172\129c resources or networks.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateClientVpnRouteRequest :
sig
  type t =
    {
    client_vpn_endpoint_id: String.t ;
    destination_cidr_block: String.t ;
    target_vpc_subnet_id: String.t ;
    description: String.t option ;
    client_token: String.t option ;
    dry_run: Boolean.t option }
  val make :
    client_vpn_endpoint_id:String.t ->
      destination_cidr_block:String.t ->
        target_vpc_subnet_id:String.t ->
          ?description:String.t ->
            ?client_token:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateClientVpnRouteResult = CreateClientVpnRouteResult
type input = CreateClientVpnRouteRequest.t
type output = CreateClientVpnRouteResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error