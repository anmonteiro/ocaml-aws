(** "<p>Creates a Redis (cluster mode disabled) or a Redis (cluster mode enabled) replication group.</p> <p>A Redis (cluster mode disabled) replication group is a collection of clusters, where one of the clusters is a read/write primary and the others are read-only replicas. Writes to the primary are asynchronously propagated to the replicas.</p> <p>A Redis (cluster mode enabled) replication group is a collection of 1 to 90 node groups (shards). Each node group (shard) has one read/write primary node and up to 5 read-only replica nodes. Writes to the primary are asynchronously propagated to the replicas. Redis (cluster mode enabled) replication groups partition the data across node groups (shards).</p> <p>When a Redis (cluster mode disabled) replication group has been successfully created, you can add one or more read replicas to it, up to a total of 5 read replicas. You cannot alter a Redis (cluster mode enabled) replication group after it has been created. However, if you need to increase or decrease the number of node groups (console: shards), you can avail yourself of ElastiCache for Redis' enhanced backup and restore. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/backups-restoring.html\">Restoring From a Backup with Cluster Resizing</a> in the <i>ElastiCache User Guide</i>.</p> <note> <p>This operation is valid for Redis only.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateReplicationGroupMessage :
sig
  type t =
    {
    replication_group_id: String.t ;
    replication_group_description: String.t ;
    primary_cluster_id: String.t option ;
    automatic_failover_enabled: Boolean.t option ;
    num_cache_clusters: Integer.t option ;
    preferred_cache_cluster_a_zs: AvailabilityZonesList.t ;
    num_node_groups: Integer.t option ;
    replicas_per_node_group: Integer.t option ;
    node_group_configuration: NodeGroupConfigurationList.t ;
    cache_node_type: String.t option ;
    engine: String.t option ;
    engine_version: String.t option ;
    cache_parameter_group_name: String.t option ;
    cache_subnet_group_name: String.t option ;
    cache_security_group_names: CacheSecurityGroupNameList.t ;
    security_group_ids: SecurityGroupIdsList.t ;
    tags: TagList.t ;
    snapshot_arns: SnapshotArnsList.t ;
    snapshot_name: String.t option ;
    preferred_maintenance_window: String.t option ;
    port: Integer.t option ;
    notification_topic_arn: String.t option ;
    auto_minor_version_upgrade: Boolean.t option ;
    snapshot_retention_limit: Integer.t option ;
    snapshot_window: String.t option ;
    auth_token: String.t option ;
    transit_encryption_enabled: Boolean.t option ;
    at_rest_encryption_enabled: Boolean.t option ;
    kms_key_id: String.t option }[@@ocaml.doc
                                   "<p>Represents the input of a <code>CreateReplicationGroup</code> operation.</p>"]
  val make :
    replication_group_id:String.t ->
      replication_group_description:String.t ->
        ?primary_cluster_id:String.t ->
          ?automatic_failover_enabled:Boolean.t ->
            ?num_cache_clusters:Integer.t ->
              ?preferred_cache_cluster_a_zs:AvailabilityZonesList.t ->
                ?num_node_groups:Integer.t ->
                  ?replicas_per_node_group:Integer.t ->
                    ?node_group_configuration:NodeGroupConfigurationList.t ->
                      ?cache_node_type:String.t ->
                        ?engine:String.t ->
                          ?engine_version:String.t ->
                            ?cache_parameter_group_name:String.t ->
                              ?cache_subnet_group_name:String.t ->
                                ?cache_security_group_names:CacheSecurityGroupNameList.t
                                  ->
                                  ?security_group_ids:SecurityGroupIdsList.t
                                    ->
                                    ?tags:TagList.t ->
                                      ?snapshot_arns:SnapshotArnsList.t ->
                                        ?snapshot_name:String.t ->
                                          ?preferred_maintenance_window:String.t
                                            ->
                                            ?port:Integer.t ->
                                              ?notification_topic_arn:String.t
                                                ->
                                                ?auto_minor_version_upgrade:Boolean.t
                                                  ->
                                                  ?snapshot_retention_limit:Integer.t
                                                    ->
                                                    ?snapshot_window:String.t
                                                      ->
                                                      ?auth_token:String.t ->
                                                        ?transit_encryption_enabled:Boolean.t
                                                          ->
                                                          ?at_rest_encryption_enabled:Boolean.t
                                                            ->
                                                            ?kms_key_id:String.t
                                                              -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateReplicationGroupResult = CreateReplicationGroupResult
type input = CreateReplicationGroupMessage.t
type output = CreateReplicationGroupResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error