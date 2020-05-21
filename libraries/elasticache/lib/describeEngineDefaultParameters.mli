(** "<p>Returns the default engine and system parameter information for the specified cache engine.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeEngineDefaultParametersMessage :
sig
  type t =
    {
    cache_parameter_group_family: String.t ;
    max_records: Integer.t option ;
    marker: String.t option }[@@ocaml.doc
                               "<p>Represents the input of a <code>DescribeEngineDefaultParameters</code> operation.</p>"]
  val make :
    cache_parameter_group_family:String.t ->
      ?max_records:Integer.t -> ?marker:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeEngineDefaultParametersResult =
DescribeEngineDefaultParametersResult
type input = DescribeEngineDefaultParametersMessage.t
type output = DescribeEngineDefaultParametersResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error