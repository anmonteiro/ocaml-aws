(** "<p>Deletes a route from a Client VPN endpoint. You can only delete routes that you manually added using the <b>CreateClientVpnRoute</b> action. You cannot delete routes that were automatically added when associating a subnet. To remove routes that have been automatically added, disassociate the target subnet from the Client VPN endpoint.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteClientVpnRouteRequest :
sig
  type t =
    {
    client_vpn_endpoint_id: String.t ;
    target_vpc_subnet_id: String.t option ;
    destination_cidr_block: String.t ;
    dry_run: Boolean.t option }
  val make :
    client_vpn_endpoint_id:String.t ->
      ?target_vpc_subnet_id:String.t ->
        destination_cidr_block:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DeleteClientVpnRouteResult = DeleteClientVpnRouteResult
type input = DeleteClientVpnRouteRequest.t
type output = DeleteClientVpnRouteResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error