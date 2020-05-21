(** "<p>Import single or multi-volume disk images or EBS snapshots into an Amazon Machine Image (AMI). For more information, see <a href=\"https://docs.aws.amazon.com/vm-import/latest/userguide/vmimport-image-import.html\">Importing a VM as an Image Using VM Import/Export</a> in the <i>VM Import/Export User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ImportImageRequest :
sig
  type t =
    {
    architecture: String.t option ;
    client_data: ClientData.t option ;
    client_token: String.t option ;
    description: String.t option ;
    disk_containers: ImageDiskContainerList.t ;
    dry_run: Boolean.t option ;
    encrypted: Boolean.t option ;
    hypervisor: String.t option ;
    kms_key_id: String.t option ;
    license_type: String.t option ;
    platform: String.t option ;
    role_name: String.t option ;
    license_specifications: ImportImageLicenseSpecificationListRequest.t }
  val make :
    ?architecture:String.t ->
      ?client_data:ClientData.t ->
        ?client_token:String.t ->
          ?description:String.t ->
            ?disk_containers:ImageDiskContainerList.t ->
              ?dry_run:Boolean.t ->
                ?encrypted:Boolean.t ->
                  ?hypervisor:String.t ->
                    ?kms_key_id:String.t ->
                      ?license_type:String.t ->
                        ?platform:String.t ->
                          ?role_name:String.t ->
                            ?license_specifications:ImportImageLicenseSpecificationListRequest.t
                              -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ImportImageResult = ImportImageResult
type input = ImportImageRequest.t
type output = ImportImageResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error