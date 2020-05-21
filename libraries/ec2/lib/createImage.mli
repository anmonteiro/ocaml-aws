(** "<p>Creates an Amazon EBS-backed AMI from an Amazon EBS-backed instance that is either running or stopped.</p> <p>If you customized your instance with instance store volumes or EBS volumes in addition to the root device volume, the new AMI contains block device mapping information for those volumes. When you launch an instance from this new AMI, the instance automatically launches with those additional volumes.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/creating-an-ami-ebs.html\">Creating Amazon EBS-Backed Linux AMIs</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateImageRequest :
sig
  type t =
    {
    block_device_mappings: BlockDeviceMappingRequestList.t ;
    description: String.t option ;
    dry_run: Boolean.t option ;
    instance_id: String.t ;
    name: String.t ;
    no_reboot: Boolean.t option }
  val make :
    ?block_device_mappings:BlockDeviceMappingRequestList.t ->
      ?description:String.t ->
        ?dry_run:Boolean.t ->
          instance_id:String.t ->
            name:String.t -> ?no_reboot:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateImageResult = CreateImageResult
type input = CreateImageRequest.t
type output = CreateImageResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error