(** "<p>Delete a custom inventory type, or the data associated with a custom Inventory type. Deleting a custom inventory type is also referred to as deleting a custom inventory schema.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteInventoryRequest :
sig
  type t =
    {
    type_name: String.t ;
    schema_delete_option: InventorySchemaDeleteOption.t option ;
    dry_run: Boolean.t option ;
    client_token: String.t option }
  val make :
    type_name:String.t ->
      ?schema_delete_option:InventorySchemaDeleteOption.t ->
        ?dry_run:Boolean.t -> ?client_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module DeleteInventoryResult = DeleteInventoryResult
type input = DeleteInventoryRequest.t
type output = DeleteInventoryResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error