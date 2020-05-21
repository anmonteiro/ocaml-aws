(** "<p>Modifies the specified Traffic Mirror rule.</p> <p> <code>DestinationCidrBlock</code> and <code>SourceCidrBlock</code> must both be an IPv4 range or an IPv6 range.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyTrafficMirrorFilterRuleRequest :
sig
  type t =
    {
    traffic_mirror_filter_rule_id: String.t ;
    traffic_direction: TrafficDirection.t option ;
    rule_number: Integer.t option ;
    rule_action: TrafficMirrorRuleAction.t option ;
    destination_port_range: TrafficMirrorPortRangeRequest.t option ;
    source_port_range: TrafficMirrorPortRangeRequest.t option ;
    protocol: Integer.t option ;
    destination_cidr_block: String.t option ;
    source_cidr_block: String.t option ;
    description: String.t option ;
    remove_fields: TrafficMirrorFilterRuleFieldList.t ;
    dry_run: Boolean.t option }
  val make :
    traffic_mirror_filter_rule_id:String.t ->
      ?traffic_direction:TrafficDirection.t ->
        ?rule_number:Integer.t ->
          ?rule_action:TrafficMirrorRuleAction.t ->
            ?destination_port_range:TrafficMirrorPortRangeRequest.t ->
              ?source_port_range:TrafficMirrorPortRangeRequest.t ->
                ?protocol:Integer.t ->
                  ?destination_cidr_block:String.t ->
                    ?source_cidr_block:String.t ->
                      ?description:String.t ->
                        ?remove_fields:TrafficMirrorFilterRuleFieldList.t ->
                          ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyTrafficMirrorFilterRuleResult =
ModifyTrafficMirrorFilterRuleResult
type input = ModifyTrafficMirrorFilterRuleRequest.t
type output = ModifyTrafficMirrorFilterRuleResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error