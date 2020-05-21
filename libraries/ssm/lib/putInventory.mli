(** "<p>Bulk update custom inventory items on one more instance. The request adds an inventory item, if it doesn't already exist, or updates an inventory item, if it does exist.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PutInventoryRequest :
sig
  type t = {
    instance_id: String.t ;
    items: InventoryItemList.t }
  val make : instance_id:String.t -> items:InventoryItemList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module PutInventoryResult = PutInventoryResult
type input = PutInventoryRequest.t
type output = PutInventoryResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error