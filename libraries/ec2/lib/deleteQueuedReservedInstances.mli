(** "<p>Deletes the queued purchases for the specified Reserved Instances.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteQueuedReservedInstancesRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    reserved_instances_ids: DeleteQueuedReservedInstancesIdList.t }
  val make :
    ?dry_run:Boolean.t ->
      reserved_instances_ids:DeleteQueuedReservedInstancesIdList.t ->
        unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DeleteQueuedReservedInstancesResult =
DeleteQueuedReservedInstancesResult
type input = DeleteQueuedReservedInstancesRequest.t
type output = DeleteQueuedReservedInstancesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error