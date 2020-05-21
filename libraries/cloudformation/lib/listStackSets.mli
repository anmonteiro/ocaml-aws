(** "<p>Returns summary information about stack sets that are associated with the user.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListStackSetsInput :
sig
  type t =
    {
    next_token: String.t option ;
    max_results: Integer.t option ;
    status: StackSetStatus.t option }
  val make :
    ?next_token:String.t ->
      ?max_results:Integer.t -> ?status:StackSetStatus.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ListStackSetsOutput = ListStackSetsOutput
type input = ListStackSetsInput.t
type output = ListStackSetsOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error