(** "<p>Returns details of the update actions </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeUpdateActionsMessage :
sig
  type t =
    {
    service_update_name: String.t option ;
    replication_group_ids: ReplicationGroupIdList.t ;
    cache_cluster_ids: CacheClusterIdList.t ;
    engine: String.t option ;
    service_update_status: ServiceUpdateStatusList.t ;
    service_update_time_range: TimeRangeFilter.t option ;
    update_action_status: UpdateActionStatusList.t ;
    show_node_level_update_status: Boolean.t option ;
    max_records: Integer.t option ;
    marker: String.t option }
  val make :
    ?service_update_name:String.t ->
      ?replication_group_ids:ReplicationGroupIdList.t ->
        ?cache_cluster_ids:CacheClusterIdList.t ->
          ?engine:String.t ->
            ?service_update_status:ServiceUpdateStatusList.t ->
              ?service_update_time_range:TimeRangeFilter.t ->
                ?update_action_status:UpdateActionStatusList.t ->
                  ?show_node_level_update_status:Boolean.t ->
                    ?max_records:Integer.t -> ?marker:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module UpdateActionsMessage = UpdateActionsMessage
type input = DescribeUpdateActionsMessage.t
type output = UpdateActionsMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error