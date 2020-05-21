(** "<p>Creates an import instance task using metadata from the specified disk image. <code>ImportInstance</code> only supports single-volume VMs. To import multi-volume VMs, use <a>ImportImage</a>. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/CommandLineReference/ec2-cli-vmimport-export.html\">Importing a Virtual Machine Using the Amazon EC2 CLI</a>.</p> <p>For information about the import manifest referenced by this API action, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/manifest.html\">VM Import Manifest</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ImportInstanceRequest :
sig
  type t =
    {
    description: String.t option ;
    disk_images: DiskImageList.t ;
    dry_run: Boolean.t option ;
    launch_specification: ImportInstanceLaunchSpecification.t option ;
    platform: PlatformValues.t }
  val make :
    ?description:String.t ->
      ?disk_images:DiskImageList.t ->
        ?dry_run:Boolean.t ->
          ?launch_specification:ImportInstanceLaunchSpecification.t ->
            platform:PlatformValues.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ImportInstanceResult = ImportInstanceResult
type input = ImportInstanceRequest.t
type output = ImportInstanceResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error