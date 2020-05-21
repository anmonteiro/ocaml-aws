(** "<p>Updates the comment for a specified traffic policy version.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module UpdateTrafficPolicyCommentRequest :
sig
  type t = {
    id: String.t ;
    version: Integer.t ;
    comment: String.t }[@@ocaml.doc
                         "<p>A complex type that contains information about the traffic policy that you want to update the comment for.</p>"]
  val make :
    id:String.t -> version:Integer.t -> comment:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module UpdateTrafficPolicyCommentResponse =
UpdateTrafficPolicyCommentResponse
type input = UpdateTrafficPolicyCommentRequest.t
type output = UpdateTrafficPolicyCommentResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error