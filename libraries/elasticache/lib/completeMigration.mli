(** "<p>Complete the migration of data.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CompleteMigrationMessage :
sig
  type t = {
    replication_group_id: String.t ;
    force: Boolean.t option }
  val make : replication_group_id:String.t -> ?force:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CompleteMigrationResponse = CompleteMigrationResponse
type input = CompleteMigrationMessage.t
type output = CompleteMigrationResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error