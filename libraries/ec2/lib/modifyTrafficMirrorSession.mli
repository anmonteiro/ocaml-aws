(** "<p>Modifies a Traffic Mirror session.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyTrafficMirrorSessionRequest :
sig
  type t =
    {
    traffic_mirror_session_id: String.t ;
    traffic_mirror_target_id: String.t option ;
    traffic_mirror_filter_id: String.t option ;
    packet_length: Integer.t option ;
    session_number: Integer.t option ;
    virtual_network_id: Integer.t option ;
    description: String.t option ;
    remove_fields: TrafficMirrorSessionFieldList.t ;
    dry_run: Boolean.t option }
  val make :
    traffic_mirror_session_id:String.t ->
      ?traffic_mirror_target_id:String.t ->
        ?traffic_mirror_filter_id:String.t ->
          ?packet_length:Integer.t ->
            ?session_number:Integer.t ->
              ?virtual_network_id:Integer.t ->
                ?description:String.t ->
                  ?remove_fields:TrafficMirrorSessionFieldList.t ->
                    ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyTrafficMirrorSessionResult = ModifyTrafficMirrorSessionResult
type input = ModifyTrafficMirrorSessionRequest.t
type output = ModifyTrafficMirrorSessionResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error