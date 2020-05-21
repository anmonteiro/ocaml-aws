(** "<p>Adds metadata tags to an Amazon RDS resource. These tags can also be used with cost allocation reporting to track cost associated with Amazon RDS resources, or used in a Condition statement in an IAM policy for Amazon RDS.</p> <p>For an overview on tagging Amazon RDS resources, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Overview.Tagging.html\">Tagging Amazon RDS Resources</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AddTagsToResourceMessage :
sig
  type t = {
    resource_name: String.t ;
    tags: TagList.t }[@@ocaml.doc "<p/>"]
  val make : resource_name:String.t -> tags:TagList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = AddTagsToResourceMessage.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error