(** "<p>Describes one or more of your virtual private gateways.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/vpn/latest/s2svpn/VPC_VPN.html\">AWS Site-to-Site VPN</a> in the <i>AWS Site-to-Site VPN User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeVpnGatewaysRequest :
sig
  type t =
    {
    filters: FilterList.t ;
    vpn_gateway_ids: VpnGatewayIdStringList.t ;
    dry_run: Boolean.t option }[@@ocaml.doc
                                 "<p>Contains the parameters for DescribeVpnGateways.</p>"]
  val make :
    ?filters:FilterList.t ->
      ?vpn_gateway_ids:VpnGatewayIdStringList.t ->
        ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeVpnGatewaysResult = DescribeVpnGatewaysResult
type input = DescribeVpnGatewaysRequest.t
type output = DescribeVpnGatewaysResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error