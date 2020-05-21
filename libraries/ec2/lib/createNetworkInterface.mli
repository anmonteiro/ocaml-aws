(** "<p>Creates a network interface in the specified subnet.</p> <p>For more information about network interfaces, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-eni.html\">Elastic Network Interfaces</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateNetworkInterfaceRequest :
sig
  type t =
    {
    description: String.t option ;
    dry_run: Boolean.t option ;
    groups: SecurityGroupIdStringList.t ;
    ipv6_address_count: Integer.t option ;
    ipv6_addresses: InstanceIpv6AddressList.t ;
    private_ip_address: String.t option ;
    private_ip_addresses: PrivateIpAddressSpecificationList.t ;
    secondary_private_ip_address_count: Integer.t option ;
    interface_type: NetworkInterfaceCreationType.t option ;
    subnet_id: String.t }[@@ocaml.doc
                           "<p>Contains the parameters for CreateNetworkInterface.</p>"]
  val make :
    ?description:String.t ->
      ?dry_run:Boolean.t ->
        ?groups:SecurityGroupIdStringList.t ->
          ?ipv6_address_count:Integer.t ->
            ?ipv6_addresses:InstanceIpv6AddressList.t ->
              ?private_ip_address:String.t ->
                ?private_ip_addresses:PrivateIpAddressSpecificationList.t ->
                  ?secondary_private_ip_address_count:Integer.t ->
                    ?interface_type:NetworkInterfaceCreationType.t ->
                      subnet_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateNetworkInterfaceResult = CreateNetworkInterfaceResult
type input = CreateNetworkInterfaceRequest.t
type output = CreateNetworkInterfaceResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error