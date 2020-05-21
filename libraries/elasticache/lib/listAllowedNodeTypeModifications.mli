(** "<p>Lists all available node types that you can scale your Redis cluster's or replication group's current node type.</p> <p>When you use the <code>ModifyCacheCluster</code> or <code>ModifyReplicationGroup</code> operations to scale your cluster or replication group, the value of the <code>CacheNodeType</code> parameter must be one of the node types returned by this operation.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListAllowedNodeTypeModificationsMessage :
sig
  type t =
    {
    cache_cluster_id: String.t option ;
    replication_group_id: String.t option }[@@ocaml.doc
                                             "<p>The input parameters for the <code>ListAllowedNodeTypeModifications</code> operation.</p>"]
  val make :
    ?cache_cluster_id:String.t -> ?replication_group_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module AllowedNodeTypeModificationsMessage =
AllowedNodeTypeModificationsMessage
type input = ListAllowedNodeTypeModificationsMessage.t
type output = AllowedNodeTypeModificationsMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error