(** "<p>Cancels the specified Capacity Reservation, releases the reserved capacity, and changes the Capacity Reservation's state to <code>cancelled</code>.</p> <p>Instances running in the reserved capacity continue running until you stop them. Stopped instances that target the Capacity Reservation can no longer launch. Modify these instances to either target a different Capacity Reservation, launch On-Demand Instance capacity, or run in any open Capacity Reservation that has matching attributes and sufficient capacity.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CancelCapacityReservationRequest :
sig
  type t = {
    capacity_reservation_id: String.t ;
    dry_run: Boolean.t option }
  val make :
    capacity_reservation_id:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CancelCapacityReservationResult = CancelCapacityReservationResult
type input = CancelCapacityReservationRequest.t
type output = CancelCapacityReservationResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error