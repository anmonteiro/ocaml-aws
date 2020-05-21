(** "<p>Retrieve a JPG-format screenshot of a running instance to help with troubleshooting.</p> <p>The returned content is Base64-encoded.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetConsoleScreenshotRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    instance_id: String.t ;
    wake_up: Boolean.t option }
  val make :
    ?dry_run:Boolean.t ->
      instance_id:String.t -> ?wake_up:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module GetConsoleScreenshotResult = GetConsoleScreenshotResult
type input = GetConsoleScreenshotRequest.t
type output = GetConsoleScreenshotResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error