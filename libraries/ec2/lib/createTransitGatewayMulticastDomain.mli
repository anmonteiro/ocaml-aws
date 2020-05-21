(** "<p>Creates a multicast domain using the specified transit gateway.</p> <p>The transit gateway must be in the available state before you create a domain. Use <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeTransitGateways.html\">DescribeTransitGateways</a> to see the state of transit gateway.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateTransitGatewayMulticastDomainRequest :
sig
  type t =
    {
    transit_gateway_id: String.t ;
    tag_specifications: TagSpecificationList.t ;
    dry_run: Boolean.t option }
  val make :
    transit_gateway_id:String.t ->
      ?tag_specifications:TagSpecificationList.t ->
        ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateTransitGatewayMulticastDomainResult =
CreateTransitGatewayMulticastDomainResult
type input = CreateTransitGatewayMulticastDomainRequest.t
type output = CreateTransitGatewayMulticastDomainResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error