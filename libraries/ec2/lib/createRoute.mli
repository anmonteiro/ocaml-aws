(** "<p>Creates a route in a route table within a VPC.</p> <p>You must specify one of the following targets: internet gateway or virtual private gateway, NAT instance, NAT gateway, VPC peering connection, network interface, egress-only internet gateway, or transit gateway.</p> <p>When determining how to route traffic, we use the route with the most specific match. For example, traffic is destined for the IPv4 address <code>192.0.2.3</code>, and the route table includes the following two IPv4 routes:</p> <ul> <li> <p> <code>192.0.2.0/24</code> (goes to some target A)</p> </li> <li> <p> <code>192.0.2.0/28</code> (goes to some target B)</p> </li> </ul> <p>Both routes apply to the traffic destined for <code>192.0.2.3</code>. However, the second route in the list covers a smaller number of IP addresses and is therefore more specific, so we use that route to determine where to target the traffic.</p> <p>For more information about route tables, see <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html\">Route Tables</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateRouteRequest :
sig
  type t =
    {
    destination_cidr_block: String.t option ;
    destination_ipv6_cidr_block: String.t option ;
    dry_run: Boolean.t option ;
    egress_only_internet_gateway_id: String.t option ;
    gateway_id: String.t option ;
    instance_id: String.t option ;
    nat_gateway_id: String.t option ;
    transit_gateway_id: String.t option ;
    local_gateway_id: String.t option ;
    network_interface_id: String.t option ;
    route_table_id: String.t ;
    vpc_peering_connection_id: String.t option }
  val make :
    ?destination_cidr_block:String.t ->
      ?destination_ipv6_cidr_block:String.t ->
        ?dry_run:Boolean.t ->
          ?egress_only_internet_gateway_id:String.t ->
            ?gateway_id:String.t ->
              ?instance_id:String.t ->
                ?nat_gateway_id:String.t ->
                  ?transit_gateway_id:String.t ->
                    ?local_gateway_id:String.t ->
                      ?network_interface_id:String.t ->
                        route_table_id:String.t ->
                          ?vpc_peering_connection_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateRouteResult = CreateRouteResult
type input = CreateRouteRequest.t
type output = CreateRouteResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error