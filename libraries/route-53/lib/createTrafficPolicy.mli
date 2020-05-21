(** "<p>Creates a traffic policy, which you use to create multiple DNS resource record sets for one domain name (such as example.com) or one subdomain name (such as www.example.com).</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateTrafficPolicyRequest :
sig
  type t = {
    name: String.t ;
    document: String.t ;
    comment: String.t option }[@@ocaml.doc
                                "<p>A complex type that contains information about the traffic policy that you want to create.</p>"]
  val make :
    name:String.t -> document:String.t -> ?comment:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateTrafficPolicyResponse = CreateTrafficPolicyResponse
type input = CreateTrafficPolicyRequest.t
type output = CreateTrafficPolicyResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error