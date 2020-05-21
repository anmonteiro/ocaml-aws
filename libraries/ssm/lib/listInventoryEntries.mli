(** "<p>A list of inventory items returned by the request.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListInventoryEntriesRequest :
sig
  type t =
    {
    instance_id: String.t ;
    type_name: String.t ;
    filters: InventoryFilterList.t ;
    next_token: String.t option ;
    max_results: Integer.t option }
  val make :
    instance_id:String.t ->
      type_name:String.t ->
        ?filters:InventoryFilterList.t ->
          ?next_token:String.t -> ?max_results:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module ListInventoryEntriesResult = ListInventoryEntriesResult
type input = ListInventoryEntriesRequest.t
type output = ListInventoryEntriesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error