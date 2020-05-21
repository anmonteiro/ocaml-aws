(** "<p>Creates a Spot Instance request.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-requests.html\">Spot Instance Requests</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RequestSpotInstancesRequest :
sig
  type t =
    {
    availability_zone_group: String.t option ;
    block_duration_minutes: Integer.t option ;
    client_token: String.t option ;
    dry_run: Boolean.t option ;
    instance_count: Integer.t option ;
    launch_group: String.t option ;
    launch_specification: RequestSpotLaunchSpecification.t option ;
    spot_price: String.t option ;
    type_: SpotInstanceType.t option ;
    valid_from: DateTime.t option ;
    valid_until: DateTime.t option ;
    instance_interruption_behavior: InstanceInterruptionBehavior.t option }
  [@@ocaml.doc "<p>Contains the parameters for RequestSpotInstances.</p>"]
  val make :
    ?availability_zone_group:String.t ->
      ?block_duration_minutes:Integer.t ->
        ?client_token:String.t ->
          ?dry_run:Boolean.t ->
            ?instance_count:Integer.t ->
              ?launch_group:String.t ->
                ?launch_specification:RequestSpotLaunchSpecification.t ->
                  ?spot_price:String.t ->
                    ?type_:SpotInstanceType.t ->
                      ?valid_from:DateTime.t ->
                        ?valid_until:DateTime.t ->
                          ?instance_interruption_behavior:InstanceInterruptionBehavior.t
                            -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module RequestSpotInstancesResult = RequestSpotInstancesResult
type input = RequestSpotInstancesRequest.t
type output = RequestSpotInstancesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error