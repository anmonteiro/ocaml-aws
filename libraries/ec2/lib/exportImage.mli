(** "<p>Exports an Amazon Machine Image (AMI) to a VM file. For more information, see <a href=\"https://docs.aws.amazon.com/vm-import/latest/userguide/vmexport_image.html\">Exporting a VM Directory from an Amazon Machine Image (AMI)</a> in the <i>VM Import/Export User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ExportImageRequest :
sig
  type t =
    {
    client_token: String.t option ;
    description: String.t option ;
    disk_image_format: DiskImageFormat.t ;
    dry_run: Boolean.t option ;
    image_id: String.t ;
    s3_export_location: ExportTaskS3LocationRequest.t ;
    role_name: String.t option }
  val make :
    ?client_token:String.t ->
      ?description:String.t ->
        disk_image_format:DiskImageFormat.t ->
          ?dry_run:Boolean.t ->
            image_id:String.t ->
              s3_export_location:ExportTaskS3LocationRequest.t ->
                ?role_name:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ExportImageResult = ExportImageResult
type input = ExportImageRequest.t
type output = ExportImageResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error