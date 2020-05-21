(** "<p>An invocation is copy of a command sent to a specific instance. A command can apply to one or more instances. A command invocation applies to one instance. For example, if a user runs SendCommand against three instances, then a command invocation is created for each requested instance ID. ListCommandInvocations provide status about command execution.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListCommandInvocationsRequest :
sig
  type t =
    {
    command_id: String.t option ;
    instance_id: String.t option ;
    max_results: Integer.t option ;
    next_token: String.t option ;
    filters: CommandFilterList.t ;
    details: Boolean.t option }
  val make :
    ?command_id:String.t ->
      ?instance_id:String.t ->
        ?max_results:Integer.t ->
          ?next_token:String.t ->
            ?filters:CommandFilterList.t -> ?details:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module ListCommandInvocationsResult = ListCommandInvocationsResult
type input = ListCommandInvocationsRequest.t
type output = ListCommandInvocationsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error