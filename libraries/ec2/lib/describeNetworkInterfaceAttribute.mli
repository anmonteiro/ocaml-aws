(** "<p>Describes a network interface attribute. You can specify only one attribute at a time.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeNetworkInterfaceAttributeRequest :
sig
  type t =
    {
    attribute: NetworkInterfaceAttribute.t option ;
    dry_run: Boolean.t option ;
    network_interface_id: String.t }[@@ocaml.doc
                                      "<p>Contains the parameters for DescribeNetworkInterfaceAttribute.</p>"]
  val make :
    ?attribute:NetworkInterfaceAttribute.t ->
      ?dry_run:Boolean.t -> network_interface_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeNetworkInterfaceAttributeResult =
DescribeNetworkInterfaceAttributeResult
type input = DescribeNetworkInterfaceAttributeRequest.t
type output = DescribeNetworkInterfaceAttributeResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error