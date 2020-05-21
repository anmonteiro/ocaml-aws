(** "<p>Gets information about a specific traffic policy version.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetTrafficPolicyRequest :
sig
  type t = {
    id: String.t ;
    version: Integer.t }[@@ocaml.doc
                          "<p>Gets information about a specific traffic policy version.</p>"]
  val make : id:String.t -> version:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module GetTrafficPolicyResponse = GetTrafficPolicyResponse
type input = GetTrafficPolicyRequest.t
type output = GetTrafficPolicyResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error