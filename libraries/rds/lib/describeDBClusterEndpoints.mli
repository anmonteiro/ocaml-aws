(** "<p>Returns information about endpoints for an Amazon Aurora DB cluster.</p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeDBClusterEndpointsMessage :
sig
  type t =
    {
    d_b_cluster_identifier: String.t option ;
    d_b_cluster_endpoint_identifier: String.t option ;
    filters: FilterList.t ;
    max_records: Integer.t option ;
    marker: String.t option }
  val make :
    ?d_b_cluster_identifier:String.t ->
      ?d_b_cluster_endpoint_identifier:String.t ->
        ?filters:FilterList.t ->
          ?max_records:Integer.t -> ?marker:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DBClusterEndpointMessage = DBClusterEndpointMessage
type input = DescribeDBClusterEndpointsMessage.t
type output = DBClusterEndpointMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error