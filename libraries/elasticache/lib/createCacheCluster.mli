(** "<p>Creates a cluster. All nodes in the cluster run the same protocol-compliant cache engine software, either Memcached or Redis.</p> <p>This operation is not supported for Redis (cluster mode enabled) clusters.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateCacheClusterMessage :
sig
  type t =
    {
    cache_cluster_id: String.t ;
    replication_group_id: String.t option ;
    a_z_mode: AZMode.t option ;
    preferred_availability_zone: String.t option ;
    preferred_availability_zones: PreferredAvailabilityZoneList.t ;
    num_cache_nodes: Integer.t option ;
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
    auth_token: String.t option }[@@ocaml.doc
                                   "<p>Represents the input of a CreateCacheCluster operation.</p>"]
  val make :
    cache_cluster_id:String.t ->
      ?replication_group_id:String.t ->
        ?a_z_mode:AZMode.t ->
          ?preferred_availability_zone:String.t ->
            ?preferred_availability_zones:PreferredAvailabilityZoneList.t ->
              ?num_cache_nodes:Integer.t ->
                ?cache_node_type:String.t ->
                  ?engine:String.t ->
                    ?engine_version:String.t ->
                      ?cache_parameter_group_name:String.t ->
                        ?cache_subnet_group_name:String.t ->
                          ?cache_security_group_names:CacheSecurityGroupNameList.t
                            ->
                            ?security_group_ids:SecurityGroupIdsList.t ->
                              ?tags:TagList.t ->
                                ?snapshot_arns:SnapshotArnsList.t ->
                                  ?snapshot_name:String.t ->
                                    ?preferred_maintenance_window:String.t ->
                                      ?port:Integer.t ->
                                        ?notification_topic_arn:String.t ->
                                          ?auto_minor_version_upgrade:Boolean.t
                                            ->
                                            ?snapshot_retention_limit:Integer.t
                                              ->
                                              ?snapshot_window:String.t ->
                                                ?auth_token:String.t ->
                                                  unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateCacheClusterResult = CreateCacheClusterResult
type input = CreateCacheClusterMessage.t
type output = CreateCacheClusterResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error