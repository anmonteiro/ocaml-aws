(** "<p>Assigns one or more IPv6 addresses to the specified network interface. You can specify one or more specific IPv6 addresses, or you can specify the number of IPv6 addresses to be automatically assigned from within the subnet's IPv6 CIDR block range. You can assign as many IPv6 addresses to a network interface as you can assign private IPv4 addresses, and the limit varies per instance type. For information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-eni.html#AvailableIpPerENI\">IP Addresses Per Network Interface Per Instance Type</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AssignIpv6AddressesRequest :
sig
  type t =
    {
    ipv6_address_count: Integer.t option ;
    ipv6_addresses: Ipv6AddressList.t ;
    network_interface_id: String.t }
  val make :
    ?ipv6_address_count:Integer.t ->
      ?ipv6_addresses:Ipv6AddressList.t ->
        network_interface_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module AssignIpv6AddressesResult = AssignIpv6AddressesResult
type input = AssignIpv6AddressesRequest.t
type output = AssignIpv6AddressesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error