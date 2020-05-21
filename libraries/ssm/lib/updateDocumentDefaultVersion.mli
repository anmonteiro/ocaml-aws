(** "<p>Set the default version of a document. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module UpdateDocumentDefaultVersionRequest :
sig
  type t = {
    name: String.t ;
    document_version: String.t }
  val make : name:String.t -> document_version:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module UpdateDocumentDefaultVersionResult =
UpdateDocumentDefaultVersionResult
type input = UpdateDocumentDefaultVersionRequest.t
type output = UpdateDocumentDefaultVersionResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error