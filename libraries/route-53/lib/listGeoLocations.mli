(** "<p>Retrieves a list of supported geographic locations.</p> <p>Countries are listed first, and continents are listed last. If Amazon Route 53 supports subdivisions for a country (for example, states or provinces), the subdivisions for that country are listed in alphabetical order immediately after the corresponding country.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListGeoLocationsRequest :
sig
  type t =
    {
    start_continent_code: String.t option ;
    start_country_code: String.t option ;
    start_subdivision_code: String.t option ;
    max_items: String.t option }[@@ocaml.doc
                                  "<p>A request to get a list of geographic locations that Amazon Route 53 supports for geolocation resource record sets. </p>"]
  val make :
    ?start_continent_code:String.t ->
      ?start_country_code:String.t ->
        ?start_subdivision_code:String.t -> ?max_items:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ListGeoLocationsResponse = ListGeoLocationsResponse
type input = ListGeoLocationsRequest.t
type output = ListGeoLocationsResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error