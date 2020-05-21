(** "<p>Returns detailed information about a type that has been registered.</p> <p>If you specify a <code>VersionId</code>, <code>DescribeType</code> returns information about that specific type version. Otherwise, it returns information about the default type version.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeTypeInput :
sig
  type t =
    {
    type_: RegistryType.t option ;
    type_name: String.t option ;
    arn: String.t option ;
    version_id: String.t option }
  val make :
    ?type_:RegistryType.t ->
      ?type_name:String.t ->
        ?arn:String.t -> ?version_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeTypeOutput = DescribeTypeOutput
type input = DescribeTypeInput.t
type output = DescribeTypeOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error