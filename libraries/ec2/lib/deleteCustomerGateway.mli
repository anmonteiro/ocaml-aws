(** "<p>Deletes the specified customer gateway. You must delete the VPN connection before you can delete the customer gateway.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteCustomerGatewayRequest :
sig
  type t = {
    customer_gateway_id: String.t ;
    dry_run: Boolean.t option }[@@ocaml.doc
                                 "<p>Contains the parameters for DeleteCustomerGateway.</p>"]
  val make : customer_gateway_id:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = DeleteCustomerGatewayRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error