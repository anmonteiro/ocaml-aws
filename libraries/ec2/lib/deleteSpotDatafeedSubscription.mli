(** "<p>Deletes the data feed for Spot Instances.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteSpotDatafeedSubscriptionRequest :
sig
  type t = {
    dry_run: Boolean.t option }[@@ocaml.doc
                                 "<p>Contains the parameters for DeleteSpotDatafeedSubscription.</p>"]
  val make : ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = DeleteSpotDatafeedSubscriptionRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error