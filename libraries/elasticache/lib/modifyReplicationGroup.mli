(** "<p>Modifies the settings for a replication group.</p> <p>For Redis (cluster mode enabled) clusters, this operation cannot be used to change a cluster's node type or engine version. For more information, see:</p> <ul> <li> <p> <a href=\"https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/scaling-redis-cluster-mode-enabled.html\">Scaling for Amazon ElastiCache for Redis (cluster mode enabled)</a> in the ElastiCache User Guide</p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AmazonElastiCache/latest/APIReference/API_ModifyReplicationGroupShardConfiguration.html\">ModifyReplicationGroupShardConfiguration</a> in the ElastiCache API Reference</p> </li> </ul> <note> <p>This operation is valid for Redis only.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyReplicationGroupMessage :
sig
  type t =
    {
    replication_group_id: String.t ;
    replication_group_description: String.t option ;
    primary_cluster_id: String.t option ;
    snapshotting_cluster_id: String.t option ;
    automatic_failover_enabled: Boolean.t option ;
    node_group_id: String.t option ;
    cache_security_group_names: CacheSecurityGroupNameList.t ;
    security_group_ids: SecurityGroupIdsList.t ;
    preferred_maintenance_window: String.t option ;
    notification_topic_arn: String.t option ;
    cache_parameter_group_name: String.t option ;
    notification_topic_status: String.t option ;
    apply_immediately: Boolean.t option ;
    engine_version: String.t option ;
    auto_minor_version_upgrade: Boolean.t option ;
    snapshot_retention_limit: Integer.t option ;
    snapshot_window: String.t option ;
    cache_node_type: String.t option ;
    auth_token: String.t option ;
    auth_token_update_strategy: AuthTokenUpdateStrategyType.t option }
  [@@ocaml.doc
    "<p>Represents the input of a <code>ModifyReplicationGroups</code> operation.</p>"]
  val make :
    replication_group_id:String.t ->
      ?replication_group_description:String.t ->
        ?primary_cluster_id:String.t ->
          ?snapshotting_cluster_id:String.t ->
            ?automatic_failover_enabled:Boolean.t ->
              ?node_group_id:String.t ->
                ?cache_security_group_names:CacheSecurityGroupNameList.t ->
                  ?security_group_ids:SecurityGroupIdsList.t ->
                    ?preferred_maintenance_window:String.t ->
                      ?notification_topic_arn:String.t ->
                        ?cache_parameter_group_name:String.t ->
                          ?notification_topic_status:String.t ->
                            ?apply_immediately:Boolean.t ->
                              ?engine_version:String.t ->
                                ?auto_minor_version_upgrade:Boolean.t ->
                                  ?snapshot_retention_limit:Integer.t ->
                                    ?snapshot_window:String.t ->
                                      ?cache_node_type:String.t ->
                                        ?auth_token:String.t ->
                                          ?auth_token_update_strategy:AuthTokenUpdateStrategyType.t
                                            -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyReplicationGroupResult = ModifyReplicationGroupResult
type input = ModifyReplicationGroupMessage.t
type output = ModifyReplicationGroupResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error