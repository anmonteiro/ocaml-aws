(** "<p>Retrieves the Session Manager connection status for an instance to determine whether it is connected and ready to receive Session Manager connections.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetConnectionStatusRequest :
sig
  type t = {
    target: String.t }
  val make : target:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module GetConnectionStatusResponse = GetConnectionStatusResponse
type input = GetConnectionStatusRequest.t
type output = GetConnectionStatusResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error