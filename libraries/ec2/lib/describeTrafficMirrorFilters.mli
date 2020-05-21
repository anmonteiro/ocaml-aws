(** "<p>Describes one or more Traffic Mirror filters.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeTrafficMirrorFiltersRequest :
sig
  type t =
    {
    traffic_mirror_filter_ids: ValueStringList.t ;
    dry_run: Boolean.t option ;
    filters: FilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    ?traffic_mirror_filter_ids:ValueStringList.t ->
      ?dry_run:Boolean.t ->
        ?filters:FilterList.t ->
          ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeTrafficMirrorFiltersResult =
DescribeTrafficMirrorFiltersResult
type input = DescribeTrafficMirrorFiltersRequest.t
type output = DescribeTrafficMirrorFiltersResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error