(** "<p>Modifies a replication group's shards (node groups) by allowing you to add shards, remove shards, or rebalance the keyspaces among exisiting shards.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyReplicationGroupShardConfigurationMessage :
sig
  type t =
    {
    replication_group_id: String.t ;
    node_group_count: Integer.t ;
    apply_immediately: Boolean.t ;
    resharding_configuration: ReshardingConfigurationList.t ;
    node_groups_to_remove: NodeGroupsToRemoveList.t ;
    node_groups_to_retain: NodeGroupsToRetainList.t }[@@ocaml.doc
                                                       "<p>Represents the input for a <code>ModifyReplicationGroupShardConfiguration</code> operation.</p>"]
  val make :
    replication_group_id:String.t ->
      node_group_count:Integer.t ->
        apply_immediately:Boolean.t ->
          ?resharding_configuration:ReshardingConfigurationList.t ->
            ?node_groups_to_remove:NodeGroupsToRemoveList.t ->
              ?node_groups_to_retain:NodeGroupsToRetainList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyReplicationGroupShardConfigurationResult =
ModifyReplicationGroupShardConfigurationResult
type input = ModifyReplicationGroupShardConfigurationMessage.t
type output = ModifyReplicationGroupShardConfigurationResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error