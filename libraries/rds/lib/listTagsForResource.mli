(** "<p>Lists all tags on an Amazon RDS resource.</p> <p>For an overview on tagging an Amazon RDS resource, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Overview.Tagging.html\">Tagging Amazon RDS Resources</a> in the <i>Amazon RDS User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListTagsForResourceMessage :
sig
  type t = {
    resource_name: String.t ;
    filters: FilterList.t }[@@ocaml.doc "<p/>"]
  val make : resource_name:String.t -> ?filters:FilterList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module TagListMessage = TagListMessage
type input = ListTagsForResourceMessage.t
type output = TagListMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error