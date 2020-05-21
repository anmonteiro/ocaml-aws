(** "<p>Determines whether a product code is associated with an instance. This action can only be used by the owner of the product code. It is useful when a product code owner must verify whether another user's instance is eligible for support.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ConfirmProductInstanceRequest :
sig
  type t =
    {
    instance_id: String.t ;
    product_code: String.t ;
    dry_run: Boolean.t option }
  val make :
    instance_id:String.t ->
      product_code:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ConfirmProductInstanceResult = ConfirmProductInstanceResult
type input = ConfirmProductInstanceRequest.t
type output = ConfirmProductInstanceResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error