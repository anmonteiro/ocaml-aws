(** "<p> </p> <p> Creates an Aurora global database spread across multiple regions. The global database contains a single primary cluster with read-write capability, and a read-only secondary cluster that receives data from the primary cluster through high-speed replication performed by the Aurora storage subsystem. </p> <p> You can create a global database that is initially empty, and then add a primary cluster and a secondary cluster to it. Or you can specify an existing Aurora cluster during the create operation, and this cluster becomes the primary cluster of the global database. </p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateGlobalClusterMessage :
sig
  type t =
    {
    global_cluster_identifier: String.t option ;
    source_d_b_cluster_identifier: String.t option ;
    engine: String.t option ;
    engine_version: String.t option ;
    deletion_protection: Boolean.t option ;
    database_name: String.t option ;
    storage_encrypted: Boolean.t option }
  val make :
    ?global_cluster_identifier:String.t ->
      ?source_d_b_cluster_identifier:String.t ->
        ?engine:String.t ->
          ?engine_version:String.t ->
            ?deletion_protection:Boolean.t ->
              ?database_name:String.t ->
                ?storage_encrypted:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateGlobalClusterResult = CreateGlobalClusterResult
type input = CreateGlobalClusterMessage.t
type output = CreateGlobalClusterResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error