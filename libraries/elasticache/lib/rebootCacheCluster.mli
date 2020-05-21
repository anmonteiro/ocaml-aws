(** "<p>Reboots some, or all, of the cache nodes within a provisioned cluster. This operation applies any modified cache parameter groups to the cluster. The reboot operation takes place as soon as possible, and results in a momentary outage to the cluster. During the reboot, the cluster status is set to REBOOTING.</p> <p>The reboot causes the contents of the cache (for each cache node being rebooted) to be lost.</p> <p>When the reboot is complete, a cluster event is created.</p> <p>Rebooting a cluster is currently supported on Memcached and Redis (cluster mode disabled) clusters. Rebooting is not supported on Redis (cluster mode enabled) clusters.</p> <p>If you make changes to parameters that require a Redis (cluster mode enabled) cluster reboot for the changes to be applied, see <a href=\"http://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Clusters.Rebooting.html\">Rebooting a Cluster</a> for an alternate process.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RebootCacheClusterMessage :
sig
  type t =
    {
    cache_cluster_id: String.t ;
    cache_node_ids_to_reboot: CacheNodeIdsList.t }[@@ocaml.doc
                                                    "<p>Represents the input of a <code>RebootCacheCluster</code> operation.</p>"]
  val make :
    cache_cluster_id:String.t ->
      cache_node_ids_to_reboot:CacheNodeIdsList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module RebootCacheClusterResult = RebootCacheClusterResult
type input = RebootCacheClusterMessage.t
type output = RebootCacheClusterResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error