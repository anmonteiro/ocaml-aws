(** "<p>Describes one or more of your Capacity Reservations. The results describe only the Capacity Reservations in the AWS Region that you're currently using.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeCapacityReservationsRequest :
sig
  type t =
    {
    capacity_reservation_ids: CapacityReservationIdSet.t ;
    next_token: String.t option ;
    max_results: Integer.t option ;
    filters: FilterList.t ;
    dry_run: Boolean.t option }
  val make :
    ?capacity_reservation_ids:CapacityReservationIdSet.t ->
      ?next_token:String.t ->
        ?max_results:Integer.t ->
          ?filters:FilterList.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeCapacityReservationsResult =
DescribeCapacityReservationsResult
type input = DescribeCapacityReservationsRequest.t
type output = DescribeCapacityReservationsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error