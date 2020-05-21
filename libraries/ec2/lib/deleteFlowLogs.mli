(** "<p>Deletes one or more flow logs.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteFlowLogsRequest :
sig
  type t = {
    dry_run: Boolean.t option ;
    flow_log_ids: ValueStringList.t }
  val make :
    ?dry_run:Boolean.t -> flow_log_ids:ValueStringList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DeleteFlowLogsResult = DeleteFlowLogsResult
type input = DeleteFlowLogsRequest.t
type output = DeleteFlowLogsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error