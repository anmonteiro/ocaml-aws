(** "<p>Describes the specified export image tasks or all your export image tasks.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeExportImageTasksRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    filters: FilterList.t ;
    export_image_task_ids: ExportImageTaskIdList.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    ?dry_run:Boolean.t ->
      ?filters:FilterList.t ->
        ?export_image_task_ids:ExportImageTaskIdList.t ->
          ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeExportImageTasksResult = DescribeExportImageTasksResult
type input = DescribeExportImageTasksRequest.t
type output = DescribeExportImageTasksResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error