(** "<p>Disables fast snapshot restores for the specified snapshots in the specified Availability Zones.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DisableFastSnapshotRestoresRequest :
sig
  type t =
    {
    availability_zones: AvailabilityZoneStringList.t ;
    source_snapshot_ids: SnapshotIdStringList.t ;
    dry_run: Boolean.t option }
  val make :
    availability_zones:AvailabilityZoneStringList.t ->
      source_snapshot_ids:SnapshotIdStringList.t ->
        ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DisableFastSnapshotRestoresResult = DisableFastSnapshotRestoresResult
type input = DisableFastSnapshotRestoresRequest.t
type output = DisableFastSnapshotRestoresResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error