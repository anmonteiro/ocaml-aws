(** "<p>Promotes a Read Replica DB cluster to a standalone DB cluster.</p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PromoteReadReplicaDBClusterMessage :
sig
  type t = {
    d_b_cluster_identifier: String.t }[@@ocaml.doc "<p/>"]
  val make : d_b_cluster_identifier:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module PromoteReadReplicaDBClusterResult = PromoteReadReplicaDBClusterResult
type input = PromoteReadReplicaDBClusterMessage.t
type output = PromoteReadReplicaDBClusterResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error