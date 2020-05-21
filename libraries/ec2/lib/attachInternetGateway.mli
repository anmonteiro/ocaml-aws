(** "<p>Attaches an internet gateway or a virtual private gateway to a VPC, enabling connectivity between the internet and the VPC. For more information about your VPC and internet gateway, see the <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/\">Amazon Virtual Private Cloud User Guide</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AttachInternetGatewayRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    internet_gateway_id: String.t ;
    vpc_id: String.t }
  val make :
    ?dry_run:Boolean.t ->
      internet_gateway_id:String.t -> vpc_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = AttachInternetGatewayRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error