(** "<p>Allows or restricts mirroring network services.</p> <p> By default, Amazon DNS network services are not eligible for Traffic Mirror. Use <code>AddNetworkServices</code> to add network services to a Traffic Mirror filter. When a network service is added to the Traffic Mirror filter, all traffic related to that network service will be mirrored. When you no longer want to mirror network services, use <code>RemoveNetworkServices</code> to remove the network services from the Traffic Mirror filter. </p> <p>For information about filter rule properties, see <a href=\"https://docs.aws.amazon.com/vpc/latest/mirroring/traffic-mirroring-considerations.html\">Network Services</a> in the <i>Traffic Mirroring User Guide </i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyTrafficMirrorFilterNetworkServicesRequest :
sig
  type t =
    {
    traffic_mirror_filter_id: String.t ;
    add_network_services: TrafficMirrorNetworkServiceList.t ;
    remove_network_services: TrafficMirrorNetworkServiceList.t ;
    dry_run: Boolean.t option }
  val make :
    traffic_mirror_filter_id:String.t ->
      ?add_network_services:TrafficMirrorNetworkServiceList.t ->
        ?remove_network_services:TrafficMirrorNetworkServiceList.t ->
          ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyTrafficMirrorFilterNetworkServicesResult =
ModifyTrafficMirrorFilterNetworkServicesResult
type input = ModifyTrafficMirrorFilterNetworkServicesRequest.t
type output = ModifyTrafficMirrorFilterNetworkServicesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error