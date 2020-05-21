(** "<p>Returns detailed information about command execution for an invocation or plugin. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetCommandInvocationRequest :
sig
  type t =
    {
    command_id: String.t ;
    instance_id: String.t ;
    plugin_name: String.t option }
  val make :
    command_id:String.t ->
      instance_id:String.t -> ?plugin_name:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module GetCommandInvocationResult = GetCommandInvocationResult
type input = GetCommandInvocationRequest.t
type output = GetCommandInvocationResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error