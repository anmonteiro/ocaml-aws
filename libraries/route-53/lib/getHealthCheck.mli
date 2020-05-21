(** "<p>Gets information about a specified health check.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetHealthCheckRequest :
sig
  type t = {
    health_check_id: String.t }[@@ocaml.doc
                                 "<p>A request to get information about a specified health check. </p>"]
  val make : health_check_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module GetHealthCheckResponse = GetHealthCheckResponse
type input = GetHealthCheckRequest.t
type output = GetHealthCheckResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error