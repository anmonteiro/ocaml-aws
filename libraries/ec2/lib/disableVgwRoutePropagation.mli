(** "<p>Disables a virtual private gateway (VGW) from propagating routes to a specified route table of a VPC.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DisableVgwRoutePropagationRequest :
sig
  type t = {
    gateway_id: String.t ;
    route_table_id: String.t }[@@ocaml.doc
                                "<p>Contains the parameters for DisableVgwRoutePropagation.</p>"]
  val make : gateway_id:String.t -> route_table_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = DisableVgwRoutePropagationRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error