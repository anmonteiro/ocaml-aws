(** "<p>Gets information about a specified hosted zone including the four name servers assigned to the hosted zone.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetHostedZoneRequest :
sig
  type t = {
    id: String.t }[@@ocaml.doc
                    "<p>A request to get information about a specified hosted zone. </p>"]
  val make : id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module GetHostedZoneResponse = GetHostedZoneResponse
type input = GetHostedZoneRequest.t
type output = GetHostedZoneResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error