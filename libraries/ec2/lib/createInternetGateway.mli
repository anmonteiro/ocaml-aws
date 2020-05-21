(** "<p>Creates an internet gateway for use with a VPC. After creating the internet gateway, you attach it to a VPC using <a>AttachInternetGateway</a>.</p> <p>For more information about your VPC and internet gateway, see the <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/\">Amazon Virtual Private Cloud User Guide</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateInternetGatewayRequest :
sig
  type t = {
    dry_run: Boolean.t option }
  val make : ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateInternetGatewayResult = CreateInternetGatewayResult
type input = CreateInternetGatewayRequest.t
type output = CreateInternetGatewayResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error