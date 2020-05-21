(** "<p>Applies a pending maintenance action to a resource (for example, to a DB instance).</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ApplyPendingMaintenanceActionMessage :
sig
  type t =
    {
    resource_identifier: String.t ;
    apply_action: String.t ;
    opt_in_type: String.t }[@@ocaml.doc "<p/>"]
  val make :
    resource_identifier:String.t ->
      apply_action:String.t -> opt_in_type:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ApplyPendingMaintenanceActionResult =
ApplyPendingMaintenanceActionResult
type input = ApplyPendingMaintenanceActionMessage.t
type output = ApplyPendingMaintenanceActionResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error