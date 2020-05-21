(** "<p>Removes the tags identified by the <code>TagKeys</code> list from the named resource.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RemoveTagsFromResourceMessage :
sig
  type t = {
    resource_name: String.t ;
    tag_keys: KeyList.t }[@@ocaml.doc
                           "<p>Represents the input of a <code>RemoveTagsFromResource</code> operation.</p>"]
  val make : resource_name:String.t -> tag_keys:KeyList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module TagListMessage = TagListMessage
type input = RemoveTagsFromResourceMessage.t
type output = TagListMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error