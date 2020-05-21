(** "<p>Lists available reserved cache node offerings.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeReservedCacheNodesOfferingsMessage :
sig
  type t =
    {
    reserved_cache_nodes_offering_id: String.t option ;
    cache_node_type: String.t option ;
    duration: String.t option ;
    product_description: String.t option ;
    offering_type: String.t option ;
    max_records: Integer.t option ;
    marker: String.t option }[@@ocaml.doc
                               "<p>Represents the input of a <code>DescribeReservedCacheNodesOfferings</code> operation.</p>"]
  val make :
    ?reserved_cache_nodes_offering_id:String.t ->
      ?cache_node_type:String.t ->
        ?duration:String.t ->
          ?product_description:String.t ->
            ?offering_type:String.t ->
              ?max_records:Integer.t -> ?marker:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ReservedCacheNodesOfferingMessage = ReservedCacheNodesOfferingMessage
type input = DescribeReservedCacheNodesOfferingsMessage.t
type output = ReservedCacheNodesOfferingMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error