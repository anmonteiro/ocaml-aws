(** "<p>Dynamically decreases the number of replics in a Redis (cluster mode disabled) replication group or the number of replica nodes in one or more node groups (shards) of a Redis (cluster mode enabled) replication group. This operation is performed with no cluster down time.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DecreaseReplicaCountMessage :
sig
  type t =
    {
    replication_group_id: String.t ;
    new_replica_count: Integer.t option ;
    replica_configuration: ReplicaConfigurationList.t ;
    replicas_to_remove: RemoveReplicasList.t ;
    apply_immediately: Boolean.t }
  val make :
    replication_group_id:String.t ->
      ?new_replica_count:Integer.t ->
        ?replica_configuration:ReplicaConfigurationList.t ->
          ?replicas_to_remove:RemoveReplicasList.t ->
            apply_immediately:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DecreaseReplicaCountResult = DecreaseReplicaCountResult
type input = DecreaseReplicaCountMessage.t
type output = DecreaseReplicaCountResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error