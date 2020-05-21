(** "<p>Detaches a network interface from an instance.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DetachNetworkInterfaceRequest :
sig
  type t =
    {
    attachment_id: String.t ;
    dry_run: Boolean.t option ;
    force: Boolean.t option }[@@ocaml.doc
                               "<p>Contains the parameters for DetachNetworkInterface.</p>"]
  val make :
    attachment_id:String.t ->
      ?dry_run:Boolean.t -> ?force:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = DetachNetworkInterfaceRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error