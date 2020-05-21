(** "<p>Use this API action to view information about a specific execution of a specific association.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeAssociationExecutionTargetsRequest :
sig
  type t =
    {
    association_id: String.t ;
    execution_id: String.t ;
    filters: AssociationExecutionTargetsFilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    association_id:String.t ->
      execution_id:String.t ->
        ?filters:AssociationExecutionTargetsFilterList.t ->
          ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module DescribeAssociationExecutionTargetsResult =
DescribeAssociationExecutionTargetsResult
type input = DescribeAssociationExecutionTargetsRequest.t
type output = DescribeAssociationExecutionTargetsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error