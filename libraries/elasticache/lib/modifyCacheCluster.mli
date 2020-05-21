(** "<p>Modifies the settings for a cluster. You can use this operation to change one or more cluster configuration parameters by specifying the parameters and the new values.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyCacheClusterMessage :
sig
  type t =
    {
    cache_cluster_id: String.t ;
    num_cache_nodes: Integer.t option ;
    cache_node_ids_to_remove: CacheNodeIdsList.t ;
    a_z_mode: AZMode.t option ;
    new_availability_zones: PreferredAvailabilityZoneList.t ;
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
    "<p>Represents the input of a <code>ModifyCacheCluster</code> operation.</p>"]
  val make :
    cache_cluster_id:String.t ->
      ?num_cache_nodes:Integer.t ->
        ?cache_node_ids_to_remove:CacheNodeIdsList.t ->
          ?a_z_mode:AZMode.t ->
            ?new_availability_zones:PreferredAvailabilityZoneList.t ->
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
module ModifyCacheClusterResult = ModifyCacheClusterResult
type input = ModifyCacheClusterMessage.t
type output = ModifyCacheClusterResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error