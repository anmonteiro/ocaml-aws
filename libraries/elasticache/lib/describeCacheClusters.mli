(** "<p>Returns information about all provisioned clusters if no cluster identifier is specified, or about a specific cache cluster if a cluster identifier is supplied.</p> <p>By default, abbreviated information about the clusters is returned. You can use the optional <i>ShowCacheNodeInfo</i> flag to retrieve detailed information about the cache nodes associated with the clusters. These details include the DNS address and port for the cache node endpoint.</p> <p>If the cluster is in the <i>creating</i> state, only cluster-level information is displayed until all of the nodes are successfully provisioned.</p> <p>If the cluster is in the <i>deleting</i> state, only cluster-level information is displayed.</p> <p>If cache nodes are currently being added to the cluster, node endpoint information and creation time for the additional nodes are not displayed until they are completely provisioned. When the cluster state is <i>available</i>, the cluster is ready for use.</p> <p>If cache nodes are currently being removed from the cluster, no endpoint information for the removed nodes is displayed.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeCacheClustersMessage :
sig
  type t =
    {
    cache_cluster_id: String.t option ;
    max_records: Integer.t option ;
    marker: String.t option ;
    show_cache_node_info: Boolean.t option ;
    show_cache_clusters_not_in_replication_groups: Boolean.t option }
  [@@ocaml.doc
    "<p>Represents the input of a <code>DescribeCacheClusters</code> operation.</p>"]
  val make :
    ?cache_cluster_id:String.t ->
      ?max_records:Integer.t ->
        ?marker:String.t ->
          ?show_cache_node_info:Boolean.t ->
            ?show_cache_clusters_not_in_replication_groups:Boolean.t ->
              unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CacheClusterMessage = CacheClusterMessage
type input = DescribeCacheClustersMessage.t
type output = CacheClusterMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error