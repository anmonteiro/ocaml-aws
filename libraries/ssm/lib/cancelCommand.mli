(** "<p>Attempts to cancel the command specified by the Command ID. There is no guarantee that the command will be terminated and the underlying process stopped.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CancelCommandRequest :
sig
  type t = {
    command_id: String.t ;
    instance_ids: InstanceIdList.t }[@@ocaml.doc "<p/>"]
  val make :
    command_id:String.t -> ?instance_ids:InstanceIdList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module Output = Aws.BaseTypes.Unit
type input = CancelCommandRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error