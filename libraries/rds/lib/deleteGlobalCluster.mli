(** "<p> Deletes a global database cluster. The primary and secondary clusters must already be detached or destroyed first. </p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteGlobalClusterMessage :
sig
  type t = {
    global_cluster_identifier: String.t }
  val make : global_cluster_identifier:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DeleteGlobalClusterResult = DeleteGlobalClusterResult
type input = DeleteGlobalClusterMessage.t
type output = DeleteGlobalClusterResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error