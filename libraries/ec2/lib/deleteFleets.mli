(** "<p>Deletes the specified EC2 Fleet.</p> <p>After you delete an EC2 Fleet, it launches no new instances. You must specify whether an EC2 Fleet should also terminate its instances. If you terminate the instances, the EC2 Fleet enters the <code>deleted_terminating</code> state. Otherwise, the EC2 Fleet enters the <code>deleted_running</code> state, and the instances continue to run until they are interrupted or you terminate them manually. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteFleetsRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    fleet_ids: FleetIdSet.t ;
    terminate_instances: Boolean.t }
  val make :
    ?dry_run:Boolean.t ->
      fleet_ids:FleetIdSet.t -> terminate_instances:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DeleteFleetsResult = DeleteFleetsResult
type input = DeleteFleetsRequest.t
type output = DeleteFleetsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error