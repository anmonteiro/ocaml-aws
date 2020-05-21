(** "<p>Retrieves settings for one or more trails associated with the current region for your account.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeTrailsRequest :
sig
  type t =
    {
    trail_name_list: TrailNameList.t ;
    include_shadow_trails: Boolean.t option }[@@ocaml.doc
                                               "<p>Returns information about the trail.</p>"]
  val make :
    ?trail_name_list:TrailNameList.t ->
      ?include_shadow_trails:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module DescribeTrailsResponse = DescribeTrailsResponse
type input = DescribeTrailsRequest.t
type output = DescribeTrailsResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error