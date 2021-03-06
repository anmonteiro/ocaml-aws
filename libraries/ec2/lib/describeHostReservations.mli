(** "<p>Describes reservations that are associated with Dedicated Hosts in your account.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeHostReservationsRequest :
sig
  type t =
    {
    filter: FilterList.t ;
    host_reservation_id_set: HostReservationIdSet.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    ?filter:FilterList.t ->
      ?host_reservation_id_set:HostReservationIdSet.t ->
        ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeHostReservationsResult = DescribeHostReservationsResult
type input = DescribeHostReservationsRequest.t
type output = DescribeHostReservationsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error