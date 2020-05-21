(** "<p> Detaches an Aurora secondary cluster from an Aurora global database cluster. The cluster becomes a standalone cluster with read-write capability instead of being read-only and receiving data from a primary cluster in a different region. </p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RemoveFromGlobalClusterMessage :
sig
  type t =
    {
    global_cluster_identifier: String.t option ;
    db_cluster_identifier: String.t option }
  val make :
    ?global_cluster_identifier:String.t ->
      ?db_cluster_identifier:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module RemoveFromGlobalClusterResult = RemoveFromGlobalClusterResult
type input = RemoveFromGlobalClusterMessage.t
type output = RemoveFromGlobalClusterResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error