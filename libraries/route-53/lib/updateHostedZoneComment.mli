(** "<p>Updates the comment for a specified hosted zone.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module UpdateHostedZoneCommentRequest :
sig
  type t = {
    id: String.t ;
    comment: String.t option }[@@ocaml.doc
                                "<p>A request to update the comment for a hosted zone.</p>"]
  val make : id:String.t -> ?comment:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module UpdateHostedZoneCommentResponse = UpdateHostedZoneCommentResponse
type input = UpdateHostedZoneCommentRequest.t
type output = UpdateHostedZoneCommentResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error