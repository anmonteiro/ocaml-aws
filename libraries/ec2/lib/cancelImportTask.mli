(** "<p>Cancels an in-process import virtual machine or import snapshot task.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CancelImportTaskRequest :
sig
  type t =
    {
    cancel_reason: String.t option ;
    dry_run: Boolean.t option ;
    import_task_id: String.t option }
  val make :
    ?cancel_reason:String.t ->
      ?dry_run:Boolean.t -> ?import_task_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CancelImportTaskResult = CancelImportTaskResult
type input = CancelImportTaskRequest.t
type output = CancelImportTaskResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error