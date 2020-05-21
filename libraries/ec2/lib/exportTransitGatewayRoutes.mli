(** "<p>Exports routes from the specified transit gateway route table to the specified S3 bucket. By default, all routes are exported. Alternatively, you can filter by CIDR range.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ExportTransitGatewayRoutesRequest :
sig
  type t =
    {
    transit_gateway_route_table_id: String.t ;
    filters: FilterList.t ;
    s3_bucket: String.t ;
    dry_run: Boolean.t option }
  val make :
    transit_gateway_route_table_id:String.t ->
      ?filters:FilterList.t ->
        s3_bucket:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ExportTransitGatewayRoutesResult = ExportTransitGatewayRoutesResult
type input = ExportTransitGatewayRoutesRequest.t
type output = ExportTransitGatewayRoutesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error