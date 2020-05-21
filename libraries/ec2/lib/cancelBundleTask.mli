(** "<p>Cancels a bundling operation for an instance store-backed Windows instance.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CancelBundleTaskRequest :
sig
  type t = {
    bundle_id: String.t ;
    dry_run: Boolean.t option }[@@ocaml.doc
                                 "<p>Contains the parameters for CancelBundleTask.</p>"]
  val make : bundle_id:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CancelBundleTaskResult = CancelBundleTaskResult
type input = CancelBundleTaskRequest.t
type output = CancelBundleTaskResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error