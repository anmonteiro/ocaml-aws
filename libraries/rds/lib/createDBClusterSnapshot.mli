(** "<p>Creates a snapshot of a DB cluster. For more information on Amazon Aurora, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html\"> What Is Amazon Aurora?</a> in the <i>Amazon Aurora User Guide.</i> </p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateDBClusterSnapshotMessage :
sig
  type t =
    {
    d_b_cluster_snapshot_identifier: String.t ;
    d_b_cluster_identifier: String.t ;
    tags: TagList.t }[@@ocaml.doc "<p/>"]
  val make :
    d_b_cluster_snapshot_identifier:String.t ->
      d_b_cluster_identifier:String.t -> ?tags:TagList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateDBClusterSnapshotResult = CreateDBClusterSnapshotResult
type input = CreateDBClusterSnapshotMessage.t
type output = CreateDBClusterSnapshotResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error