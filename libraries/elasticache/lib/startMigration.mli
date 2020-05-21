(** "<p>Start the migration of data.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module StartMigrationMessage :
sig
  type t =
    {
    replication_group_id: String.t ;
    customer_node_endpoint_list: CustomerNodeEndpointList.t }
  val make :
    replication_group_id:String.t ->
      customer_node_endpoint_list:CustomerNodeEndpointList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module StartMigrationResponse = StartMigrationResponse
type input = StartMigrationMessage.t
type output = StartMigrationResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error