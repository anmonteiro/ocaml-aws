(** "<p>Deletes a reusable delegation set.</p> <important> <p>You can delete a reusable delegation set only if it isn't associated with any hosted zones.</p> </important> <p>To verify that the reusable delegation set is not associated with any hosted zones, submit a <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_GetReusableDelegationSet.html\">GetReusableDelegationSet</a> request and specify the ID of the reusable delegation set that you want to delete.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteReusableDelegationSetRequest :
sig
  type t = {
    id: String.t }[@@ocaml.doc
                    "<p>A request to delete a reusable delegation set.</p>"]
  val make : id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = DeleteReusableDelegationSetRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error