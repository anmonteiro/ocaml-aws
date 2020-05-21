(** "<p>Modifies the specified attribute of the specified VPC.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyVpcAttributeRequest :
sig
  type t =
    {
    enable_dns_hostnames: AttributeBooleanValue.t option ;
    enable_dns_support: AttributeBooleanValue.t option ;
    vpc_id: String.t }
  val make :
    ?enable_dns_hostnames:AttributeBooleanValue.t ->
      ?enable_dns_support:AttributeBooleanValue.t ->
        vpc_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = ModifyVpcAttributeRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error