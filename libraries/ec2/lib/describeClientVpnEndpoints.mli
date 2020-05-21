(** "<p>Describes one or more Client VPN endpoints in the account.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeClientVpnEndpointsRequest :
sig
  type t =
    {
    client_vpn_endpoint_ids: ValueStringList.t ;
    max_results: Integer.t option ;
    next_token: String.t option ;
    filters: FilterList.t ;
    dry_run: Boolean.t option }
  val make :
    ?client_vpn_endpoint_ids:ValueStringList.t ->
      ?max_results:Integer.t ->
        ?next_token:String.t ->
          ?filters:FilterList.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeClientVpnEndpointsResult = DescribeClientVpnEndpointsResult
type input = DescribeClientVpnEndpointsRequest.t
type output = DescribeClientVpnEndpointsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error