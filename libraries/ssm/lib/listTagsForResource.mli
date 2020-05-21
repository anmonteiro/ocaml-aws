(** "<p>Returns a list of the tags assigned to the specified resource.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListTagsForResourceRequest :
sig
  type t = {
    resource_type: ResourceTypeForTagging.t ;
    resource_id: String.t }
  val make :
    resource_type:ResourceTypeForTagging.t ->
      resource_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module ListTagsForResourceResult = ListTagsForResourceResult
type input = ListTagsForResourceRequest.t
type output = ListTagsForResourceResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error