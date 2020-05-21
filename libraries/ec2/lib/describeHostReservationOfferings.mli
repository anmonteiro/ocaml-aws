(** "<p>Describes the Dedicated Host reservations that are available to purchase.</p> <p>The results describe all of the Dedicated Host reservation offerings, including offerings that might not match the instance family and Region of your Dedicated Hosts. When purchasing an offering, ensure that the instance family and Region of the offering matches that of the Dedicated Hosts with which it is to be associated. For more information about supported instance types, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/dedicated-hosts-overview.html\">Dedicated Hosts Overview</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeHostReservationOfferingsRequest :
sig
  type t =
    {
    filter: FilterList.t ;
    max_duration: Integer.t option ;
    max_results: Integer.t option ;
    min_duration: Integer.t option ;
    next_token: String.t option ;
    offering_id: String.t option }
  val make :
    ?filter:FilterList.t ->
      ?max_duration:Integer.t ->
        ?max_results:Integer.t ->
          ?min_duration:Integer.t ->
            ?next_token:String.t -> ?offering_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeHostReservationOfferingsResult =
DescribeHostReservationOfferingsResult
type input = DescribeHostReservationOfferingsRequest.t
type output = DescribeHostReservationOfferingsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error