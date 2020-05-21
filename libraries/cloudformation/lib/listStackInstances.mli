(** "<p>Returns summary information about stack instances that are associated with the specified stack set. You can filter for stack instances that are associated with a specific AWS account name or region.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListStackInstancesInput :
sig
  type t =
    {
    stack_set_name: String.t ;
    next_token: String.t option ;
    max_results: Integer.t option ;
    stack_instance_account: String.t option ;
    stack_instance_region: String.t option }
  val make :
    stack_set_name:String.t ->
      ?next_token:String.t ->
        ?max_results:Integer.t ->
          ?stack_instance_account:String.t ->
            ?stack_instance_region:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ListStackInstancesOutput = ListStackInstancesOutput
type input = ListStackInstancesInput.t
type output = ListStackInstancesOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error