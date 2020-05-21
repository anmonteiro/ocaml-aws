(** "<p>Initiates execution of an Automation document.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module StartAutomationExecutionRequest :
sig
  type t =
    {
    document_name: String.t ;
    document_version: String.t option ;
    parameters: AutomationParameterMap.t option ;
    client_token: String.t option ;
    mode: ExecutionMode.t option ;
    target_parameter_name: String.t option ;
    targets: Targets.t ;
    target_maps: TargetMaps.t ;
    max_concurrency: String.t option ;
    max_errors: String.t option ;
    target_locations: TargetLocations.t ;
    tags: TagList.t }
  val make :
    document_name:String.t ->
      ?document_version:String.t ->
        ?parameters:AutomationParameterMap.t ->
          ?client_token:String.t ->
            ?mode:ExecutionMode.t ->
              ?target_parameter_name:String.t ->
                ?targets:Targets.t ->
                  ?target_maps:TargetMaps.t ->
                    ?max_concurrency:String.t ->
                      ?max_errors:String.t ->
                        ?target_locations:TargetLocations.t ->
                          ?tags:TagList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module StartAutomationExecutionResult = StartAutomationExecutionResult
type input = StartAutomationExecutionRequest.t
type output = StartAutomationExecutionResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error