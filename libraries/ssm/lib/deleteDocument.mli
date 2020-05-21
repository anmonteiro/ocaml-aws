(** "<p>Deletes the Systems Manager document and all instance associations to the document.</p> <p>Before you delete the document, we recommend that you use <a>DeleteAssociation</a> to disassociate all instances that are associated with the document.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteDocumentRequest :
sig
  type t =
    {
    name: String.t ;
    document_version: String.t option ;
    version_name: String.t option ;
    force: Boolean.t option }
  val make :
    name:String.t ->
      ?document_version:String.t ->
        ?version_name:String.t -> ?force:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module Output = Aws.BaseTypes.Unit
type input = DeleteDocumentRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error