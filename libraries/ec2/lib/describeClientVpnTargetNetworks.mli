(** "<p>Describes the target networks associated with the specified Client VPN endpoint.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeClientVpnTargetNetworksRequest :
sig
  type t =
    {
    client_vpn_endpoint_id: String.t ;
    association_ids: ValueStringList.t ;
    max_results: Integer.t option ;
    next_token: String.t option ;
    filters: FilterList.t ;
    dry_run: Boolean.t option }
  val make :
    client_vpn_endpoint_id:String.t ->
      ?association_ids:ValueStringList.t ->
        ?max_results:Integer.t ->
          ?next_token:String.t ->
            ?filters:FilterList.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeClientVpnTargetNetworksResult =
DescribeClientVpnTargetNetworksResult
type input = DescribeClientVpnTargetNetworksRequest.t
type output = DescribeClientVpnTargetNetworksResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error