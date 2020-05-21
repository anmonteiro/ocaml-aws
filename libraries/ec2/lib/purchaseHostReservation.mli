(** "<p>Purchase a reservation with configurations that match those of your Dedicated Host. You must have active Dedicated Hosts in your account before you purchase a reservation. This action results in the specified reservation being purchased and charged to your account.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PurchaseHostReservationRequest :
sig
  type t =
    {
    client_token: String.t option ;
    currency_code: CurrencyCodeValues.t option ;
    host_id_set: RequestHostIdSet.t ;
    limit_price: String.t option ;
    offering_id: String.t }
  val make :
    ?client_token:String.t ->
      ?currency_code:CurrencyCodeValues.t ->
        host_id_set:RequestHostIdSet.t ->
          ?limit_price:String.t -> offering_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module PurchaseHostReservationResult = PurchaseHostReservationResult
type input = PurchaseHostReservationRequest.t
type output = PurchaseHostReservationResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error