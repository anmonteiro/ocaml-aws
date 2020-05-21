(** "<p>Creates a copy of an entire cluster or replication group at a specific moment in time.</p> <note> <p>This operation is valid for Redis only.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateSnapshotMessage :
sig
  type t =
    {
    replication_group_id: String.t option ;
    cache_cluster_id: String.t option ;
    snapshot_name: String.t ;
    kms_key_id: String.t option }[@@ocaml.doc
                                   "<p>Represents the input of a <code>CreateSnapshot</code> operation.</p>"]
  val make :
    ?replication_group_id:String.t ->
      ?cache_cluster_id:String.t ->
        snapshot_name:String.t -> ?kms_key_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateSnapshotResult = CreateSnapshotResult
type input = CreateSnapshotMessage.t
type output = CreateSnapshotResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error