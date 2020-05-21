(** "<p>Deletes a specified stack. Once the call completes successfully, stack deletion starts. Deleted stacks do not show up in the <a>DescribeStacks</a> API if the deletion has been completed successfully.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteStackInput :
sig
  type t =
    {
    stack_name: String.t ;
    retain_resources: RetainResources.t ;
    role_a_r_n: String.t option ;
    client_request_token: String.t option }[@@ocaml.doc
                                             "<p>The input for <a>DeleteStack</a> action.</p>"]
  val make :
    stack_name:String.t ->
      ?retain_resources:RetainResources.t ->
        ?role_a_r_n:String.t -> ?client_request_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = DeleteStackInput.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error