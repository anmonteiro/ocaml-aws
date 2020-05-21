(** "<p>Creates a custom Availability Zone (AZ).</p> <p>A custom AZ is an on-premises AZ that is integrated with a VMware vSphere cluster.</p> <p>For more information about RDS on VMware, see the <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/RDSonVMwareUserGuide/rds-on-vmware.html\"> <i>RDS on VMware User Guide.</i> </a> </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateCustomAvailabilityZoneMessage :
sig
  type t =
    {
    custom_availability_zone_name: String.t ;
    existing_vpn_id: String.t option ;
    new_vpn_tunnel_name: String.t option ;
    vpn_tunnel_originator_i_p: String.t option }[@@ocaml.doc "<p/>"]
  val make :
    custom_availability_zone_name:String.t ->
      ?existing_vpn_id:String.t ->
        ?new_vpn_tunnel_name:String.t ->
          ?vpn_tunnel_originator_i_p:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateCustomAvailabilityZoneResult =
CreateCustomAvailabilityZoneResult
type input = CreateCustomAvailabilityZoneMessage.t
type output = CreateCustomAvailabilityZoneResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error