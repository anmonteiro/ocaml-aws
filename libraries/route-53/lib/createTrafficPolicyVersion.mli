(** "<p>Creates a new version of an existing traffic policy. When you create a new version of a traffic policy, you specify the ID of the traffic policy that you want to update and a JSON-formatted document that describes the new version. You use traffic policies to create multiple DNS resource record sets for one domain name (such as example.com) or one subdomain name (such as www.example.com). You can create a maximum of 1000 versions of a traffic policy. If you reach the limit and need to create another version, you'll need to start a new traffic policy.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateTrafficPolicyVersionRequest :
sig
  type t = {
    id: String.t ;
    document: String.t ;
    comment: String.t option }[@@ocaml.doc
                                "<p>A complex type that contains information about the traffic policy that you want to create a new version for.</p>"]
  val make :
    id:String.t -> document:String.t -> ?comment:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateTrafficPolicyVersionResponse =
CreateTrafficPolicyVersionResponse
type input = CreateTrafficPolicyVersionRequest.t
type output = CreateTrafficPolicyVersionResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error