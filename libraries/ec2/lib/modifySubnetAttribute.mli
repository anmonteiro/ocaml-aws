(** "<p>Modifies a subnet attribute. You can only modify one attribute at a time.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifySubnetAttributeRequest :
sig
  type t =
    {
    assign_ipv6_address_on_creation: AttributeBooleanValue.t option ;
    map_public_ip_on_launch: AttributeBooleanValue.t option ;
    subnet_id: String.t }
  val make :
    ?assign_ipv6_address_on_creation:AttributeBooleanValue.t ->
      ?map_public_ip_on_launch:AttributeBooleanValue.t ->
        subnet_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = ModifySubnetAttributeRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error