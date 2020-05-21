(** "<p>Attaches a network interface to an instance.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AttachNetworkInterfaceRequest :
sig
  type t =
    {
    device_index: Integer.t ;
    dry_run: Boolean.t option ;
    instance_id: String.t ;
    network_interface_id: String.t }[@@ocaml.doc
                                      "<p>Contains the parameters for AttachNetworkInterface.</p>"]
  val make :
    device_index:Integer.t ->
      ?dry_run:Boolean.t ->
        instance_id:String.t -> network_interface_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module AttachNetworkInterfaceResult = AttachNetworkInterfaceResult
type input = AttachNetworkInterfaceRequest.t
type output = AttachNetworkInterfaceResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error