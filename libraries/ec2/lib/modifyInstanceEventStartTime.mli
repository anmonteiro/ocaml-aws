(** "<p>Modifies the start time for a scheduled Amazon EC2 instance event.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyInstanceEventStartTimeRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    instance_id: String.t ;
    instance_event_id: String.t ;
    not_before: DateTime.t }
  val make :
    ?dry_run:Boolean.t ->
      instance_id:String.t ->
        instance_event_id:String.t -> not_before:DateTime.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyInstanceEventStartTimeResult =
ModifyInstanceEventStartTimeResult
type input = ModifyInstanceEventStartTimeRequest.t
type output = ModifyInstanceEventStartTimeResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error