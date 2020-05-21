(** "<p>Adds, edits, or deletes tags for a health check or a hosted zone.</p> <p>For information about using tags for cost allocation, see <a href=\"https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html\">Using Cost Allocation Tags</a> in the <i>AWS Billing and Cost Management User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ChangeTagsForResourceRequest :
sig
  type t =
    {
    resource_type: TagResourceType.t ;
    resource_id: String.t ;
    add_tags: TagList.t ;
    remove_tag_keys: TagKeyList.t }[@@ocaml.doc
                                     "<p>A complex type that contains information about the tags that you want to add, edit, or delete.</p>"]
  val make :
    resource_type:TagResourceType.t ->
      resource_id:String.t ->
        ?add_tags:TagList.t -> ?remove_tag_keys:TagKeyList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = ChangeTagsForResourceRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error