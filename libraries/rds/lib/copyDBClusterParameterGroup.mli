(** "<p>Copies the specified DB cluster parameter group.</p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CopyDBClusterParameterGroupMessage :
sig
  type t =
    {
    source_d_b_cluster_parameter_group_identifier: String.t ;
    target_d_b_cluster_parameter_group_identifier: String.t ;
    target_d_b_cluster_parameter_group_description: String.t ;
    tags: TagList.t }
  val make :
    source_d_b_cluster_parameter_group_identifier:String.t ->
      target_d_b_cluster_parameter_group_identifier:String.t ->
        target_d_b_cluster_parameter_group_description:String.t ->
          ?tags:TagList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CopyDBClusterParameterGroupResult = CopyDBClusterParameterGroupResult
type input = CopyDBClusterParameterGroupMessage.t
type output = CopyDBClusterParameterGroupResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error