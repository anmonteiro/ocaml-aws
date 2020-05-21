(** "<p>Removes a source identifier from an existing RDS event notification subscription.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RemoveSourceIdentifierFromSubscriptionMessage :
sig
  type t = {
    subscription_name: String.t ;
    source_identifier: String.t }[@@ocaml.doc "<p/>"]
  val make :
    subscription_name:String.t -> source_identifier:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module RemoveSourceIdentifierFromSubscriptionResult =
RemoveSourceIdentifierFromSubscriptionResult
type input = RemoveSourceIdentifierFromSubscriptionMessage.t
type output = RemoveSourceIdentifierFromSubscriptionResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error