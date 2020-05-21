(** "<p>Modifies the Capacity Reservation settings for a stopped instance. Use this action to configure an instance to target a specific Capacity Reservation, run in any <code>open</code> Capacity Reservation with matching attributes, or run On-Demand Instance capacity.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyInstanceCapacityReservationAttributesRequest :
sig
  type t =
    {
    instance_id: String.t ;
    capacity_reservation_specification: CapacityReservationSpecification.t ;
    dry_run: Boolean.t option }
  val make :
    instance_id:String.t ->
      capacity_reservation_specification:CapacityReservationSpecification.t
        -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyInstanceCapacityReservationAttributesResult =
ModifyInstanceCapacityReservationAttributesResult
type input = ModifyInstanceCapacityReservationAttributesRequest.t
type output = ModifyInstanceCapacityReservationAttributesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error