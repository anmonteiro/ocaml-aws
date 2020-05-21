(** "<p>Deletes an existing replication group. By default, this operation deletes the entire replication group, including the primary/primaries and all of the read replicas. If the replication group has only one primary, you can optionally delete only the read replicas, while retaining the primary by setting <code>RetainPrimaryCluster=true</code>.</p> <p>When you receive a successful response from this operation, Amazon ElastiCache immediately begins deleting the selected resources; you cannot cancel or revert this operation.</p> <note> <p>This operation is valid for Redis only.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteReplicationGroupMessage :
sig
  type t =
    {
    replication_group_id: String.t ;
    retain_primary_cluster: Boolean.t option ;
    final_snapshot_identifier: String.t option }[@@ocaml.doc
                                                  "<p>Represents the input of a <code>DeleteReplicationGroup</code> operation.</p>"]
  val make :
    replication_group_id:String.t ->
      ?retain_primary_cluster:Boolean.t ->
        ?final_snapshot_identifier:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DeleteReplicationGroupResult = DeleteReplicationGroupResult
type input = DeleteReplicationGroupMessage.t
type output = DeleteReplicationGroupResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error