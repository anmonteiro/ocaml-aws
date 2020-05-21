(** "<p>Returns information about custom Availability Zones (AZs).</p> <p>A custom AZ is an on-premises AZ that is integrated with a VMware vSphere cluster.</p> <p>For more information about RDS on VMware, see the <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/RDSonVMwareUserGuide/rds-on-vmware.html\"> <i>RDS on VMware User Guide.</i> </a> </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeCustomAvailabilityZonesMessage :
sig
  type t =
    {
    custom_availability_zone_id: String.t option ;
    filters: FilterList.t ;
    max_records: Integer.t option ;
    marker: String.t option }
  val make :
    ?custom_availability_zone_id:String.t ->
      ?filters:FilterList.t ->
        ?max_records:Integer.t -> ?marker:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CustomAvailabilityZoneMessage = CustomAvailabilityZoneMessage
type input = DescribeCustomAvailabilityZonesMessage.t
type output = CustomAvailabilityZoneMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error