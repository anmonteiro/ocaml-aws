(** "<p>Get details of a parameter. Don't confuse this API action with the <a>GetParameter</a> API action.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetParametersRequest :
sig
  type t = {
    names: ParameterNameList.t ;
    with_decryption: Boolean.t option }
  val make :
    names:ParameterNameList.t -> ?with_decryption:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module GetParametersResult = GetParametersResult
type input = GetParametersRequest.t
type output = GetParametersResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error