(** "<p>Apply the service update. For more information on service updates and applying them, see <a href=\"https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/applying-updates.html\">Applying Service Updates</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module BatchApplyUpdateActionMessage :
sig
  type t =
    {
    replication_group_ids: ReplicationGroupIdList.t ;
    cache_cluster_ids: CacheClusterIdList.t ;
    service_update_name: String.t }
  val make :
    ?replication_group_ids:ReplicationGroupIdList.t ->
      ?cache_cluster_ids:CacheClusterIdList.t ->
        service_update_name:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module UpdateActionResultsMessage = UpdateActionResultsMessage
type input = BatchApplyUpdateActionMessage.t
type output = UpdateActionResultsMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error