(** "<p>Return a list of inventory type names for the account, or return a list of attribute names for a specific Inventory item type. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetInventorySchemaRequest :
sig
  type t =
    {
    type_name: String.t option ;
    next_token: String.t option ;
    max_results: Integer.t option ;
    aggregator: Boolean.t option ;
    sub_type: Boolean.t option }
  val make :
    ?type_name:String.t ->
      ?next_token:String.t ->
        ?max_results:Integer.t ->
          ?aggregator:Boolean.t -> ?sub_type:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module GetInventorySchemaResult = GetInventorySchemaResult
type input = GetInventorySchemaRequest.t
type output = GetInventorySchemaResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error