(** "<p>Describes the specified conversion tasks or all your conversion tasks. For more information, see the <a href=\"https://docs.aws.amazon.com/vm-import/latest/userguide/\">VM Import/Export User Guide</a>.</p> <p>For information about the import manifest referenced by this API action, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/manifest.html\">VM Import Manifest</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeConversionTasksRequest :
sig
  type t =
    {
    conversion_task_ids: ConversionIdStringList.t ;
    dry_run: Boolean.t option }
  val make :
    ?conversion_task_ids:ConversionIdStringList.t ->
      ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeConversionTasksResult = DescribeConversionTasksResult
type input = DescribeConversionTasksRequest.t
type output = DescribeConversionTasksResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error