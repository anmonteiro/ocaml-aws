(** "<p>Creates a NAT gateway in the specified public subnet. This action creates a network interface in the specified subnet with a private IP address from the IP address range of the subnet. Internet-bound traffic from a private subnet can be routed to the NAT gateway, therefore enabling instances in the private subnet to connect to the internet. For more information, see <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html\">NAT Gateways</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateNatGatewayRequest :
sig
  type t =
    {
    allocation_id: String.t ;
    client_token: String.t option ;
    subnet_id: String.t }
  val make :
    allocation_id:String.t ->
      ?client_token:String.t -> subnet_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateNatGatewayResult = CreateNatGatewayResult
type input = CreateNatGatewayRequest.t
type output = CreateNatGatewayResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error