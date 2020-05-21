(** "<p>Cancels one or more Spot Instance requests.</p> <important> <p>Canceling a Spot Instance request does not terminate running Spot Instances associated with the request.</p> </important>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CancelSpotInstanceRequestsRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    spot_instance_request_ids: SpotInstanceRequestIdList.t }[@@ocaml.doc
                                                              "<p>Contains the parameters for CancelSpotInstanceRequests.</p>"]
  val make :
    ?dry_run:Boolean.t ->
      spot_instance_request_ids:SpotInstanceRequestIdList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CancelSpotInstanceRequestsResult = CancelSpotInstanceRequestsResult
type input = CancelSpotInstanceRequestsRequest.t
type output = CancelSpotInstanceRequestsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error