(** "<p>Describes a specific delete inventory operation.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeInventoryDeletionsRequest :
sig
  type t =
    {
    deletion_id: String.t option ;
    next_token: String.t option ;
    max_results: Integer.t option }
  val make :
    ?deletion_id:String.t ->
      ?next_token:String.t -> ?max_results:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module DescribeInventoryDeletionsResult = DescribeInventoryDeletionsResult
type input = DescribeInventoryDeletionsRequest.t
type output = DescribeInventoryDeletionsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error