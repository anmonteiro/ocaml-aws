(** "<p>Creates a Systems Manager document.</p> <p>After you create a document, you can use CreateAssociation to associate it with one or more running instances.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateDocumentRequest :
sig
  type t =
    {
    content: String.t ;
    requires: DocumentRequiresList.t ;
    attachments: AttachmentsSourceList.t ;
    name: String.t ;
    version_name: String.t option ;
    document_type: DocumentType.t option ;
    document_format: DocumentFormat.t option ;
    target_type: String.t option ;
    tags: TagList.t }
  val make :
    content:String.t ->
      ?requires:DocumentRequiresList.t ->
        ?attachments:AttachmentsSourceList.t ->
          name:String.t ->
            ?version_name:String.t ->
              ?document_type:DocumentType.t ->
                ?document_format:DocumentFormat.t ->
                  ?target_type:String.t -> ?tags:TagList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module CreateDocumentResult = CreateDocumentResult
type input = CreateDocumentRequest.t
type output = CreateDocumentResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error