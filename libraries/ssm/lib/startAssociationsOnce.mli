(** "<p>Use this API action to run an association immediately and only one time. This action can be helpful when troubleshooting associations.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module StartAssociationsOnceRequest :
sig
  type t = {
    association_ids: AssociationIdList.t }
  val make : association_ids:AssociationIdList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module Output = Aws.BaseTypes.Unit
type input = StartAssociationsOnceRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error