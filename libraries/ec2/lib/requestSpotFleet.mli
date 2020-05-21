(** "<p>Creates a Spot Fleet request.</p> <p>The Spot Fleet request specifies the total target capacity and the On-Demand target capacity. Amazon EC2 calculates the difference between the total capacity and On-Demand capacity, and launches the difference as Spot capacity.</p> <p>You can submit a single request that includes multiple launch specifications that vary by instance type, AMI, Availability Zone, or subnet.</p> <p>By default, the Spot Fleet requests Spot Instances in the Spot Instance pool where the price per unit is the lowest. Each launch specification can include its own instance weighting that reflects the value of the instance type to your application workload.</p> <p>Alternatively, you can specify that the Spot Fleet distribute the target capacity across the Spot pools included in its launch specifications. By ensuring that the Spot Instances in your Spot Fleet are in different Spot pools, you can improve the availability of your fleet.</p> <p>You can specify tags for the Spot Instances. You cannot tag other resource types in a Spot Fleet request because only the <code>instance</code> resource type is supported.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-fleet-requests.html\">Spot Fleet Requests</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RequestSpotFleetRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    spot_fleet_request_config: SpotFleetRequestConfigData.t }[@@ocaml.doc
                                                               "<p>Contains the parameters for RequestSpotFleet.</p>"]
  val make :
    ?dry_run:Boolean.t ->
      spot_fleet_request_config:SpotFleetRequestConfigData.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module RequestSpotFleetResponse = RequestSpotFleetResponse
type input = RequestSpotFleetRequest.t
type output = RequestSpotFleetResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error