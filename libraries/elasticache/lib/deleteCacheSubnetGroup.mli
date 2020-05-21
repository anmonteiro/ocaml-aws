(** "<p>Deletes a cache subnet group.</p> <note> <p>You cannot delete a cache subnet group if it is associated with any clusters.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteCacheSubnetGroupMessage :
sig
  type t = {
    cache_subnet_group_name: String.t }[@@ocaml.doc
                                         "<p>Represents the input of a <code>DeleteCacheSubnetGroup</code> operation.</p>"]
  val make : cache_subnet_group_name:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = DeleteCacheSubnetGroupMessage.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error