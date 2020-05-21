(** "<p>Creates a DBSnapshot. The source DBInstance must be in \"available\" state.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateDBSnapshotMessage :
sig
  type t =
    {
    d_b_snapshot_identifier: String.t ;
    d_b_instance_identifier: String.t ;
    tags: TagList.t }[@@ocaml.doc "<p/>"]
  val make :
    d_b_snapshot_identifier:String.t ->
      d_b_instance_identifier:String.t -> ?tags:TagList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateDBSnapshotResult = CreateDBSnapshotResult
type input = CreateDBSnapshotMessage.t
type output = CreateDBSnapshotResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error