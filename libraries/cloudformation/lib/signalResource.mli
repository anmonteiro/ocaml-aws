(** "<p>Sends a signal to the specified resource with a success or failure status. You can use the SignalResource API in conjunction with a creation policy or update policy. AWS CloudFormation doesn't proceed with a stack creation or update until resources receive the required number of signals or the timeout period is exceeded. The SignalResource API is useful in cases where you want to send signals from anywhere other than an Amazon EC2 instance.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module SignalResourceInput :
sig
  type t =
    {
    stack_name: String.t ;
    logical_resource_id: String.t ;
    unique_id: String.t ;
    status: ResourceSignalStatus.t }[@@ocaml.doc
                                      "<p>The input for the <a>SignalResource</a> action.</p>"]
  val make :
    stack_name:String.t ->
      logical_resource_id:String.t ->
        unique_id:String.t -> status:ResourceSignalStatus.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = SignalResourceInput.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error