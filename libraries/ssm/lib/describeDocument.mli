(** "<p>Describes the specified Systems Manager document.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeDocumentRequest :
sig
  type t =
    {
    name: String.t ;
    document_version: String.t option ;
    version_name: String.t option }
  val make :
    name:String.t ->
      ?document_version:String.t -> ?version_name:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module DescribeDocumentResult = DescribeDocumentResult
type input = DescribeDocumentRequest.t
type output = DescribeDocumentResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error