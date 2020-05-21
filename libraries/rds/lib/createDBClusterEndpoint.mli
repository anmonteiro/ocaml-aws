(** "<p>Creates a new custom endpoint and associates it with an Amazon Aurora DB cluster.</p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateDBClusterEndpointMessage :
sig
  type t =
    {
    d_b_cluster_identifier: String.t ;
    d_b_cluster_endpoint_identifier: String.t ;
    endpoint_type: String.t ;
    static_members: StringList.t ;
    excluded_members: StringList.t ;
    tags: TagList.t }
  val make :
    d_b_cluster_identifier:String.t ->
      d_b_cluster_endpoint_identifier:String.t ->
        endpoint_type:String.t ->
          ?static_members:StringList.t ->
            ?excluded_members:StringList.t -> ?tags:TagList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DBClusterEndpoint = DBClusterEndpoint
type input = CreateDBClusterEndpointMessage.t
type output = DBClusterEndpoint.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error