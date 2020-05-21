(** "<p>Creates a Traffic Mirror filter rule. </p> <p>A Traffic Mirror rule defines the Traffic Mirror source traffic to mirror.</p> <p>You need the Traffic Mirror filter ID when you create the rule.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateTrafficMirrorFilterRuleRequest :
sig
  type t =
    {
    traffic_mirror_filter_id: String.t ;
    traffic_direction: TrafficDirection.t ;
    rule_number: Integer.t ;
    rule_action: TrafficMirrorRuleAction.t ;
    destination_port_range: TrafficMirrorPortRangeRequest.t option ;
    source_port_range: TrafficMirrorPortRangeRequest.t option ;
    protocol: Integer.t option ;
    destination_cidr_block: String.t ;
    source_cidr_block: String.t ;
    description: String.t option ;
    dry_run: Boolean.t option ;
    client_token: String.t option }
  val make :
    traffic_mirror_filter_id:String.t ->
      traffic_direction:TrafficDirection.t ->
        rule_number:Integer.t ->
          rule_action:TrafficMirrorRuleAction.t ->
            ?destination_port_range:TrafficMirrorPortRangeRequest.t ->
              ?source_port_range:TrafficMirrorPortRangeRequest.t ->
                ?protocol:Integer.t ->
                  destination_cidr_block:String.t ->
                    source_cidr_block:String.t ->
                      ?description:String.t ->
                        ?dry_run:Boolean.t ->
                          ?client_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateTrafficMirrorFilterRuleResult =
CreateTrafficMirrorFilterRuleResult
type input = CreateTrafficMirrorFilterRuleRequest.t
type output = CreateTrafficMirrorFilterRuleResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error