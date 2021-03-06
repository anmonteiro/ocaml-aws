(** "<p>[IPv6 only] Creates an egress-only internet gateway for your VPC. An egress-only internet gateway is used to enable outbound communication over IPv6 from instances in your VPC to the internet, and prevents hosts outside of your VPC from initiating an IPv6 connection with your instance.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateEgressOnlyInternetGatewayRequest :
sig
  type t =
    {
    client_token: String.t option ;
    dry_run: Boolean.t option ;
    vpc_id: String.t }
  val make :
    ?client_token:String.t ->
      ?dry_run:Boolean.t -> vpc_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateEgressOnlyInternetGatewayResult =
CreateEgressOnlyInternetGatewayResult
type input = CreateEgressOnlyInternetGatewayRequest.t
type output = CreateEgressOnlyInternetGatewayResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error