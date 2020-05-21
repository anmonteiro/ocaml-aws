(** "<p>Describes the specified export instance tasks or all your export instance tasks.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeExportTasksRequest :
sig
  type t =
    {
    export_task_ids: ExportTaskIdStringList.t ;
    filters: FilterList.t }
  val make :
    ?export_task_ids:ExportTaskIdStringList.t ->
      ?filters:FilterList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeExportTasksResult = DescribeExportTasksResult
type input = DescribeExportTasksRequest.t
type output = DescribeExportTasksResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error