(** "<p>Deletes the specified notification.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteNotificationConfigurationType :
sig
  type t = {
    auto_scaling_group_name: String.t ;
    topic_a_r_n: String.t }
  val make :
    auto_scaling_group_name:String.t -> topic_a_r_n:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = DeleteNotificationConfigurationType.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error