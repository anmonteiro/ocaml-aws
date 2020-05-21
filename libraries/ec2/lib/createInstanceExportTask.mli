(** "<p>Exports a running or stopped instance to an S3 bucket.</p> <p>For information about the supported operating systems, image formats, and known limitations for the types of instances you can export, see <a href=\"https://docs.aws.amazon.com/vm-import/latest/userguide/vmexport.html\">Exporting an Instance as a VM Using VM Import/Export</a> in the <i>VM Import/Export User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateInstanceExportTaskRequest :
sig
  type t =
    {
    description: String.t option ;
    export_to_s3_task: ExportToS3TaskSpecification.t option ;
    instance_id: String.t ;
    target_environment: ExportEnvironment.t option }
  val make :
    ?description:String.t ->
      ?export_to_s3_task:ExportToS3TaskSpecification.t ->
        instance_id:String.t ->
          ?target_environment:ExportEnvironment.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateInstanceExportTaskResult = CreateInstanceExportTaskResult
type input = CreateInstanceExportTaskRequest.t
type output = CreateInstanceExportTaskResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error