(** "<p>Creates a Traffic Mirror session.</p> <p>A Traffic Mirror session actively copies packets from a Traffic Mirror source to a Traffic Mirror target. Create a filter, and then assign it to the session to define a subset of the traffic to mirror, for example all TCP traffic.</p> <p>The Traffic Mirror source and the Traffic Mirror target (monitoring appliances) can be in the same VPC, or in a different VPC connected via VPC peering or a transit gateway. </p> <p>By default, no traffic is mirrored. Use <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateTrafficMirrorFilter.htm\">CreateTrafficMirrorFilter</a> to create filter rules that specify the traffic to mirror.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateTrafficMirrorSessionRequest :
sig
  type t =
    {
    network_interface_id: String.t ;
    traffic_mirror_target_id: String.t ;
    traffic_mirror_filter_id: String.t ;
    packet_length: Integer.t option ;
    session_number: Integer.t ;
    virtual_network_id: Integer.t option ;
    description: String.t option ;
    tag_specifications: TagSpecificationList.t ;
    dry_run: Boolean.t option ;
    client_token: String.t option }
  val make :
    network_interface_id:String.t ->
      traffic_mirror_target_id:String.t ->
        traffic_mirror_filter_id:String.t ->
          ?packet_length:Integer.t ->
            session_number:Integer.t ->
              ?virtual_network_id:Integer.t ->
                ?description:String.t ->
                  ?tag_specifications:TagSpecificationList.t ->
                    ?dry_run:Boolean.t -> ?client_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateTrafficMirrorSessionResult = CreateTrafficMirrorSessionResult
type input = CreateTrafficMirrorSessionRequest.t
type output = CreateTrafficMirrorSessionResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error