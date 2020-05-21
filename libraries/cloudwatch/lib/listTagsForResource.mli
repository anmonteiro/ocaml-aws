(** "<p>Displays the tags associated with a CloudWatch resource. Alarms support tagging.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListTagsForResourceInput :
sig
  type t = {
    resource_a_r_n: String.t }
  val make : resource_a_r_n:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ListTagsForResourceOutput = ListTagsForResourceOutput
type input = ListTagsForResourceInput.t
type output = ListTagsForResourceOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error