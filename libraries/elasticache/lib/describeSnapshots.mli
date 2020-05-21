(** "<p>Returns information about cluster or replication group snapshots. By default, <code>DescribeSnapshots</code> lists all of your snapshots; it can optionally describe a single snapshot, or just the snapshots associated with a particular cache cluster.</p> <note> <p>This operation is valid for Redis only.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeSnapshotsMessage :
sig
  type t =
    {
    replication_group_id: String.t option ;
    cache_cluster_id: String.t option ;
    snapshot_name: String.t option ;
    snapshot_source: String.t option ;
    marker: String.t option ;
    max_records: Integer.t option ;
    show_node_group_config: Boolean.t option }[@@ocaml.doc
                                                "<p>Represents the input of a <code>DescribeSnapshotsMessage</code> operation.</p>"]
  val make :
    ?replication_group_id:String.t ->
      ?cache_cluster_id:String.t ->
        ?snapshot_name:String.t ->
          ?snapshot_source:String.t ->
            ?marker:String.t ->
              ?max_records:Integer.t ->
                ?show_node_group_config:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeSnapshotsListMessage = DescribeSnapshotsListMessage
type input = DescribeSnapshotsMessage.t
type output = DescribeSnapshotsListMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error