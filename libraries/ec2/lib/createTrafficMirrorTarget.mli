(** "<p>Creates a target for your Traffic Mirror session.</p> <p>A Traffic Mirror target is the destination for mirrored traffic. The Traffic Mirror source and the Traffic Mirror target (monitoring appliances) can be in the same VPC, or in different VPCs connected via VPC peering or a transit gateway.</p> <p>A Traffic Mirror target can be a network interface, or a Network Load Balancer.</p> <p>To use the target in a Traffic Mirror session, use <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateTrafficMirrorSession.htm\">CreateTrafficMirrorSession</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateTrafficMirrorTargetRequest :
sig
  type t =
    {
    network_interface_id: String.t option ;
    network_load_balancer_arn: String.t option ;
    description: String.t option ;
    tag_specifications: TagSpecificationList.t ;
    dry_run: Boolean.t option ;
    client_token: String.t option }
  val make :
    ?network_interface_id:String.t ->
      ?network_load_balancer_arn:String.t ->
        ?description:String.t ->
          ?tag_specifications:TagSpecificationList.t ->
            ?dry_run:Boolean.t -> ?client_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateTrafficMirrorTargetResult = CreateTrafficMirrorTargetResult
type input = CreateTrafficMirrorTargetRequest.t
type output = CreateTrafficMirrorTargetResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error