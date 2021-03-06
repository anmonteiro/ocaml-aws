(** "<p>Returns high-level aggregated patch compliance state for a patch group.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribePatchGroupStateRequest :
sig
  type t = {
    patch_group: String.t }
  val make : patch_group:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module DescribePatchGroupStateResult = DescribePatchGroupStateResult
type input = DescribePatchGroupStateRequest.t
type output = DescribePatchGroupStateResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error