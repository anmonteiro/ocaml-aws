(** "<p>Gets the contents of the specified Systems Manager document.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetDocumentRequest :
sig
  type t =
    {
    name: String.t ;
    version_name: String.t option ;
    document_version: String.t option ;
    document_format: DocumentFormat.t option }
  val make :
    name:String.t ->
      ?version_name:String.t ->
        ?document_version:String.t ->
          ?document_format:DocumentFormat.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module GetDocumentResult = GetDocumentResult
type input = GetDocumentRequest.t
type output = GetDocumentResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error