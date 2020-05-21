(** "<p>Allows you to purchase a reserved cache node offering.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PurchaseReservedCacheNodesOfferingMessage :
sig
  type t =
    {
    reserved_cache_nodes_offering_id: String.t ;
    reserved_cache_node_id: String.t option ;
    cache_node_count: Integer.t option }[@@ocaml.doc
                                          "<p>Represents the input of a <code>PurchaseReservedCacheNodesOffering</code> operation.</p>"]
  val make :
    reserved_cache_nodes_offering_id:String.t ->
      ?reserved_cache_node_id:String.t ->
        ?cache_node_count:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module PurchaseReservedCacheNodesOfferingResult =
PurchaseReservedCacheNodesOfferingResult
type input = PurchaseReservedCacheNodesOfferingMessage.t
type output = PurchaseReservedCacheNodesOfferingResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error