(** "<p>Imports a disk into an EBS snapshot.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ImportSnapshotRequest :
sig
  type t =
    {
    client_data: ClientData.t option ;
    client_token: String.t option ;
    description: String.t option ;
    disk_container: SnapshotDiskContainer.t option ;
    dry_run: Boolean.t option ;
    encrypted: Boolean.t option ;
    kms_key_id: String.t option ;
    role_name: String.t option }
  val make :
    ?client_data:ClientData.t ->
      ?client_token:String.t ->
        ?description:String.t ->
          ?disk_container:SnapshotDiskContainer.t ->
            ?dry_run:Boolean.t ->
              ?encrypted:Boolean.t ->
                ?kms_key_id:String.t -> ?role_name:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ImportSnapshotResult = ImportSnapshotResult
type input = ImportSnapshotRequest.t
type output = ImportSnapshotResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error