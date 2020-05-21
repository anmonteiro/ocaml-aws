(** "<p>Cancels the specified Spot Fleet requests.</p> <p>After you cancel a Spot Fleet request, the Spot Fleet launches no new Spot Instances. You must specify whether the Spot Fleet should also terminate its Spot Instances. If you terminate the instances, the Spot Fleet request enters the <code>cancelled_terminating</code> state. Otherwise, the Spot Fleet request enters the <code>cancelled_running</code> state and the instances continue to run until they are interrupted or you terminate them manually.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CancelSpotFleetRequestsRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    spot_fleet_request_ids: ValueStringList.t ;
    terminate_instances: Boolean.t }[@@ocaml.doc
                                      "<p>Contains the parameters for CancelSpotFleetRequests.</p>"]
  val make :
    ?dry_run:Boolean.t ->
      spot_fleet_request_ids:ValueStringList.t ->
        terminate_instances:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CancelSpotFleetRequestsResponse = CancelSpotFleetRequestsResponse
type input = CancelSpotFleetRequestsRequest.t
type output = CancelSpotFleetRequestsResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error