(** "<p>Gets usage information about a Capacity Reservation. If the Capacity Reservation is shared, it shows usage information for the Capacity Reservation owner and each AWS account that is currently using the shared capacity. If the Capacity Reservation is not shared, it shows only the Capacity Reservation owner's usage.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetCapacityReservationUsageRequest :
sig
  type t =
    {
    capacity_reservation_id: String.t ;
    next_token: String.t option ;
    max_results: Integer.t option ;
    dry_run: Boolean.t option }
  val make :
    capacity_reservation_id:String.t ->
      ?next_token:String.t ->
        ?max_results:Integer.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module GetCapacityReservationUsageResult = GetCapacityReservationUsageResult
type input = GetCapacityReservationUsageRequest.t
type output = GetCapacityReservationUsageResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error