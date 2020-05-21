(** "<p>All associations for the instance(s).</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeEffectiveInstanceAssociationsRequest :
sig
  type t =
    {
    instance_id: String.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    instance_id:String.t ->
      ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module DescribeEffectiveInstanceAssociationsResult =
DescribeEffectiveInstanceAssociationsResult
type input = DescribeEffectiveInstanceAssociationsRequest.t
type output = DescribeEffectiveInstanceAssociationsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error