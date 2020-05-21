(** "<p>Sends a signal to an Automation execution to change the current behavior or status of the execution. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module SendAutomationSignalRequest :
sig
  type t =
    {
    automation_execution_id: String.t ;
    signal_type: SignalType.t ;
    payload: AutomationParameterMap.t option }
  val make :
    automation_execution_id:String.t ->
      signal_type:SignalType.t ->
        ?payload:AutomationParameterMap.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module Output = Aws.BaseTypes.Unit
type input = SendAutomationSignalRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error