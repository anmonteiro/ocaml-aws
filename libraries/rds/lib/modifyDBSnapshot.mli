(** "<p>Updates a manual DB snapshot, which can be encrypted or not encrypted, with a new engine version. </p> <p>Amazon RDS supports upgrading DB snapshots for MySQL, Oracle, and PostgreSQL. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyDBSnapshotMessage :
sig
  type t =
    {
    d_b_snapshot_identifier: String.t ;
    engine_version: String.t option ;
    option_group_name: String.t option }
  val make :
    d_b_snapshot_identifier:String.t ->
      ?engine_version:String.t -> ?option_group_name:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyDBSnapshotResult = ModifyDBSnapshotResult
type input = ModifyDBSnapshotMessage.t
type output = ModifyDBSnapshotResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error