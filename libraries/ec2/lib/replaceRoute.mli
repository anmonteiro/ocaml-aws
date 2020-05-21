(** "<p>Replaces an existing route within a route table in a VPC. You must provide only one of the following: internet gateway, virtual private gateway, NAT instance, NAT gateway, VPC peering connection, network interface, egress-only internet gateway, or transit gateway.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html\">Route Tables</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ReplaceRouteRequest :
sig
  type t =
    {
    destination_cidr_block: String.t option ;
    destination_ipv6_cidr_block: String.t option ;
    dry_run: Boolean.t option ;
    egress_only_internet_gateway_id: String.t option ;
    gateway_id: String.t option ;
    instance_id: String.t option ;
    local_target: Boolean.t option ;
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
                ?local_target:Boolean.t ->
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
module Output = Aws.BaseTypes.Unit
type input = ReplaceRouteRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error