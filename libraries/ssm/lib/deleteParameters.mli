(** "<p>Delete a list of parameters.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteParametersRequest :
sig
  type t = {
    names: ParameterNameList.t }
  val make : names:ParameterNameList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module DeleteParametersResult = DeleteParametersResult
type input = DeleteParametersRequest.t
type output = DeleteParametersResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error