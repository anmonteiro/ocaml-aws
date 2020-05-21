(** "<p>Lists the tags for the trail in the current region.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListTagsRequest :
sig
  type t = {
    resource_id_list: ResourceIdList.t ;
    next_token: String.t option }[@@ocaml.doc
                                   "<p>Specifies a list of trail tags to return.</p>"]
  val make :
    resource_id_list:ResourceIdList.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module ListTagsResponse = ListTagsResponse
type input = ListTagsRequest.t
type output = ListTagsResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error