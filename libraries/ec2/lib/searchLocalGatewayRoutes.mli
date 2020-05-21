(** "<p>Searches for routes in the specified local gateway route table.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module SearchLocalGatewayRoutesRequest :
sig
  type t =
    {
    local_gateway_route_table_id: String.t ;
    filters: FilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option ;
    dry_run: Boolean.t option }
  val make :
    local_gateway_route_table_id:String.t ->
      filters:FilterList.t ->
        ?max_results:Integer.t ->
          ?next_token:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module SearchLocalGatewayRoutesResult = SearchLocalGatewayRoutesResult
type input = SearchLocalGatewayRoutesRequest.t
type output = SearchLocalGatewayRoutesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error