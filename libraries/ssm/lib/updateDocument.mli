(** "<p>Updates one or more values for an SSM document.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module UpdateDocumentRequest :
sig
  type t =
    {
    content: String.t ;
    attachments: AttachmentsSourceList.t ;
    name: String.t ;
    version_name: String.t option ;
    document_version: String.t option ;
    document_format: DocumentFormat.t option ;
    target_type: String.t option }
  val make :
    content:String.t ->
      ?attachments:AttachmentsSourceList.t ->
        name:String.t ->
          ?version_name:String.t ->
            ?document_version:String.t ->
              ?document_format:DocumentFormat.t ->
                ?target_type:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module UpdateDocumentResult = UpdateDocumentResult
type input = UpdateDocumentRequest.t
type output = UpdateDocumentResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error