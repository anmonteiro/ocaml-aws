(** "<p>Retrieves a list of the reusable delegation sets that are associated with the current AWS account.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListReusableDelegationSetsRequest :
sig
  type t = {
    marker: String.t option ;
    max_items: String.t option }[@@ocaml.doc
                                  "<p>A request to get a list of the reusable delegation sets that are associated with the current AWS account.</p>"]
  val make : ?marker:String.t -> ?max_items:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ListReusableDelegationSetsResponse =
ListReusableDelegationSetsResponse
type input = ListReusableDelegationSetsRequest.t
type output = ListReusableDelegationSetsResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error