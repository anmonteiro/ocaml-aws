(** "<p>Get information about a parameter by using the parameter name. Don't confuse this API action with the <a>GetParameters</a> API action.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetParameterRequest :
sig
  type t = {
    name: String.t ;
    with_decryption: Boolean.t option }
  val make : name:String.t -> ?with_decryption:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module GetParameterResult = GetParameterResult
type input = GetParameterRequest.t
type output = GetParameterResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error