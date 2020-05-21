(** "<p>Describes the Availability Zones and Local Zones that are available to you. If there is an event impacting an Availability Zone or Local Zone, you can use this request to view the state and any provided messages for that Availability Zone or Local Zone.</p> <p>For more information about Availability Zones and Local Zones, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html\">Regions and Availability Zones</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeAvailabilityZonesRequest :
sig
  type t =
    {
    filters: FilterList.t ;
    zone_names: ZoneNameStringList.t ;
    zone_ids: ZoneIdStringList.t ;
    all_availability_zones: Boolean.t option ;
    dry_run: Boolean.t option }
  val make :
    ?filters:FilterList.t ->
      ?zone_names:ZoneNameStringList.t ->
        ?zone_ids:ZoneIdStringList.t ->
          ?all_availability_zones:Boolean.t ->
            ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeAvailabilityZonesResult = DescribeAvailabilityZonesResult
type input = DescribeAvailabilityZonesRequest.t
type output = DescribeAvailabilityZonesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error