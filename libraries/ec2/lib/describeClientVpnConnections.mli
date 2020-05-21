(** "<p>Describes active client connections and connections that have been terminated within the last 60 minutes for the specified Client VPN endpoint.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeClientVpnConnectionsRequest :
sig
  type t =
    {
    client_vpn_endpoint_id: String.t ;
    filters: FilterList.t ;
    next_token: String.t option ;
    max_results: Integer.t option ;
    dry_run: Boolean.t option }
  val make :
    client_vpn_endpoint_id:String.t ->
      ?filters:FilterList.t ->
        ?next_token:String.t ->
          ?max_results:Integer.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeClientVpnConnectionsResult =
DescribeClientVpnConnectionsResult
type input = DescribeClientVpnConnectionsRequest.t
type output = DescribeClientVpnConnectionsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error