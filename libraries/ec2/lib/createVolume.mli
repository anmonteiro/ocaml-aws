(** "<p>Creates an EBS volume that can be attached to an instance in the same Availability Zone. The volume is created in the regional endpoint that you send the HTTP request to. For more information see <a href=\"https://docs.aws.amazon.com/general/latest/gr/rande.html\">Regions and Endpoints</a>.</p> <p>You can create a new empty volume or restore a volume from an EBS snapshot. Any AWS Marketplace product codes from the snapshot are propagated to the volume.</p> <p>You can create encrypted volumes. Encrypted volumes must be attached to instances that support Amazon EBS encryption. Volumes that are created from encrypted snapshots are also automatically encrypted. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSEncryption.html\">Amazon EBS Encryption</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p> <p>You can tag your volumes during creation. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html\">Tagging Your Amazon EC2 Resources</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-creating-volume.html\">Creating an Amazon EBS Volume</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateVolumeRequest :
sig
  type t =
    {
    availability_zone: String.t ;
    encrypted: Boolean.t option ;
    iops: Integer.t option ;
    kms_key_id: String.t option ;
    outpost_arn: String.t option ;
    size: Integer.t option ;
    snapshot_id: String.t option ;
    volume_type: VolumeType.t option ;
    dry_run: Boolean.t option ;
    tag_specifications: TagSpecificationList.t }
  val make :
    availability_zone:String.t ->
      ?encrypted:Boolean.t ->
        ?iops:Integer.t ->
          ?kms_key_id:String.t ->
            ?outpost_arn:String.t ->
              ?size:Integer.t ->
                ?snapshot_id:String.t ->
                  ?volume_type:VolumeType.t ->
                    ?dry_run:Boolean.t ->
                      ?tag_specifications:TagSpecificationList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Volume = Volume
type input = CreateVolumeRequest.t
type output = Volume.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error