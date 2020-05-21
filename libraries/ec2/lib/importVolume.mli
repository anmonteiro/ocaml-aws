(** "<p>Creates an import volume task using metadata from the specified disk image.For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/CommandLineReference/importing-your-volumes-into-amazon-ebs.html\">Importing Disks to Amazon EBS</a>.</p> <p>For information about the import manifest referenced by this API action, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/manifest.html\">VM Import Manifest</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ImportVolumeRequest :
sig
  type t =
    {
    availability_zone: String.t ;
    description: String.t option ;
    dry_run: Boolean.t option ;
    image: DiskImageDetail.t ;
    volume: VolumeDetail.t }
  val make :
    availability_zone:String.t ->
      ?description:String.t ->
        ?dry_run:Boolean.t ->
          image:DiskImageDetail.t -> volume:VolumeDetail.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ImportVolumeResult = ImportVolumeResult
type input = ImportVolumeRequest.t
type output = ImportVolumeResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error