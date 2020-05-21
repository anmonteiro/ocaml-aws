(** "<p>Modifies a Capacity Reservation's capacity and the conditions under which it is to be released. You cannot change a Capacity Reservation's instance type, EBS optimization, instance store settings, platform, Availability Zone, or instance eligibility. If you need to modify any of these attributes, we recommend that you cancel the Capacity Reservation, and then create a new one with the required attributes.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyCapacityReservationRequest :
sig
  type t =
    {
    capacity_reservation_id: String.t ;
    instance_count: Integer.t option ;
    end_date: DateTime.t option ;
    end_date_type: EndDateType.t option ;
    dry_run: Boolean.t option }
  val make :
    capacity_reservation_id:String.t ->
      ?instance_count:Integer.t ->
        ?end_date:DateTime.t ->
          ?end_date_type:EndDateType.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyCapacityReservationResult = ModifyCapacityReservationResult
type input = ModifyCapacityReservationRequest.t
type output = ModifyCapacityReservationResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error