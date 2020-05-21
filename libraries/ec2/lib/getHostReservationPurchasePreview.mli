(** "<p>Preview a reservation purchase with configurations that match those of your Dedicated Host. You must have active Dedicated Hosts in your account before you purchase a reservation.</p> <p>This is a preview of the <a>PurchaseHostReservation</a> action and does not result in the offering being purchased.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetHostReservationPurchasePreviewRequest :
sig
  type t = {
    host_id_set: RequestHostIdSet.t ;
    offering_id: String.t }
  val make :
    host_id_set:RequestHostIdSet.t -> offering_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module GetHostReservationPurchasePreviewResult =
GetHostReservationPurchasePreviewResult
type input = GetHostReservationPurchasePreviewRequest.t
type output = GetHostReservationPurchasePreviewResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error