(** "<p>Removes the specified tags from a trail.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RemoveTagsRequest :
sig
  type t = {
    resource_id: String.t ;
    tags_list: TagsList.t }[@@ocaml.doc
                             "<p>Specifies the tags to remove from a trail.</p>"]
  val make : resource_id:String.t -> ?tags_list:TagsList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module Output = Aws.BaseTypes.Unit
type input = RemoveTagsRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error