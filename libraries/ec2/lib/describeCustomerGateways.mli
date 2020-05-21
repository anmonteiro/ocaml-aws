(** "<p>Describes one or more of your VPN customer gateways.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/vpn/latest/s2svpn/VPC_VPN.html\">AWS Site-to-Site VPN</a> in the <i>AWS Site-to-Site VPN User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeCustomerGatewaysRequest :
sig
  type t =
    {
    customer_gateway_ids: CustomerGatewayIdStringList.t ;
    filters: FilterList.t ;
    dry_run: Boolean.t option }[@@ocaml.doc
                                 "<p>Contains the parameters for DescribeCustomerGateways.</p>"]
  val make :
    ?customer_gateway_ids:CustomerGatewayIdStringList.t ->
      ?filters:FilterList.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeCustomerGatewaysResult = DescribeCustomerGatewaysResult
type input = DescribeCustomerGatewaysRequest.t
type output = DescribeCustomerGatewaysResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error