(** "<p>Describes details about the activation, such as the date and time the activation was created, its expiration date, the IAM role assigned to the instances in the activation, and the number of instances registered by using this activation.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeActivationsRequest :
sig
  type t =
    {
    filters: DescribeActivationsFilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    ?filters:DescribeActivationsFilterList.t ->
      ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module DescribeActivationsResult = DescribeActivationsResult
type input = DescribeActivationsRequest.t
type output = DescribeActivationsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error