(** "<p>Lists the route tables to which the specified resource attachment propagates routes.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetTransitGatewayAttachmentPropagationsRequest :
sig
  type t =
    {
    transit_gateway_attachment_id: String.t ;
    filters: FilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option ;
    dry_run: Boolean.t option }
  val make :
    transit_gateway_attachment_id:String.t ->
      ?filters:FilterList.t ->
        ?max_results:Integer.t ->
          ?next_token:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module GetTransitGatewayAttachmentPropagationsResult =
GetTransitGatewayAttachmentPropagationsResult
type input = GetTransitGatewayAttachmentPropagationsRequest.t
type output = GetTransitGatewayAttachmentPropagationsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error