(** "<p>Unassigns one or more IPv6 addresses from a network interface.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module UnassignIpv6AddressesRequest :
sig
  type t =
    {
    ipv6_addresses: Ipv6AddressList.t ;
    network_interface_id: String.t }
  val make :
    ipv6_addresses:Ipv6AddressList.t ->
      network_interface_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module UnassignIpv6AddressesResult = UnassignIpv6AddressesResult
type input = UnassignIpv6AddressesRequest.t
type output = UnassignIpv6AddressesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error