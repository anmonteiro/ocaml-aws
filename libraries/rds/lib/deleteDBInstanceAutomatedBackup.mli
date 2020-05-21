(** "<p>Deletes automated backups based on the source instance's <code>DbiResourceId</code> value or the restorable instance's resource ID.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteDBInstanceAutomatedBackupMessage :
sig
  type t = {
    dbi_resource_id: String.t }[@@ocaml.doc
                                 "<p>Parameter input for the <code>DeleteDBInstanceAutomatedBackup</code> operation. </p>"]
  val make : dbi_resource_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DeleteDBInstanceAutomatedBackupResult =
DeleteDBInstanceAutomatedBackupResult
type input = DeleteDBInstanceAutomatedBackupMessage.t
type output = DeleteDBInstanceAutomatedBackupResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error