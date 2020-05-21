(** "<p>Assigns one or more secondary private IP addresses to the specified network interface.</p> <p>You can specify one or more specific secondary IP addresses, or you can specify the number of secondary IP addresses to be automatically assigned within the subnet's CIDR block range. The number of secondary IP addresses that you can assign to an instance varies by instance type. For information about instance types, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html\">Instance Types</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>. For more information about Elastic IP addresses, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html\">Elastic IP Addresses</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p> <p>When you move a secondary private IP address to another network interface, any Elastic IP address that is associated with the IP address is also moved.</p> <p>Remapping an IP address is an asynchronous operation. When you move an IP address from one network interface to another, check <code>network/interfaces/macs/mac/local-ipv4s</code> in the instance metadata to confirm that the remapping is complete.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AssignPrivateIpAddressesRequest :
sig
  type t =
    {
    allow_reassignment: Boolean.t option ;
    network_interface_id: String.t ;
    private_ip_addresses: PrivateIpAddressStringList.t ;
    secondary_private_ip_address_count: Integer.t option }[@@ocaml.doc
                                                            "<p>Contains the parameters for AssignPrivateIpAddresses.</p>"]
  val make :
    ?allow_reassignment:Boolean.t ->
      network_interface_id:String.t ->
        ?private_ip_addresses:PrivateIpAddressStringList.t ->
          ?secondary_private_ip_address_count:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module AssignPrivateIpAddressesResult = AssignPrivateIpAddressesResult
type input = AssignPrivateIpAddressesRequest.t
type output = AssignPrivateIpAddressesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error