(** "<p>You can modify several parameters of an existing EBS volume, including volume size, volume type, and IOPS capacity. If your EBS volume is attached to a current-generation EC2 instance type, you may be able to apply these changes without stopping the instance or detaching the volume from it. For more information about modifying an EBS volume running Linux, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-expand-volume.html\">Modifying the Size, IOPS, or Type of an EBS Volume on Linux</a>. For more information about modifying an EBS volume running Windows, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/ebs-expand-volume.html\">Modifying the Size, IOPS, or Type of an EBS Volume on Windows</a>. </p> <p> When you complete a resize operation on your volume, you need to extend the volume's file-system size to take advantage of the new storage capacity. For information about extending a Linux file system, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-expand-volume.html#recognize-expanded-volume-linux\">Extending a Linux File System</a>. For information about extending a Windows file system, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/ebs-expand-volume.html#recognize-expanded-volume-windows\">Extending a Windows File System</a>. </p> <p> You can use CloudWatch Events to check the status of a modification to an EBS volume. For information about CloudWatch Events, see the <a href=\"https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/\">Amazon CloudWatch Events User Guide</a>. You can also track the status of a modification using <a>DescribeVolumesModifications</a>. For information about tracking status changes using either method, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-expand-volume.html#monitoring_mods\">Monitoring Volume Modifications</a>. </p> <p>With previous-generation instance types, resizing an EBS volume may require detaching and reattaching the volume or stopping and restarting the instance. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-expand-volume.html\">Modifying the Size, IOPS, or Type of an EBS Volume on Linux</a> and <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/ebs-expand-volume.html\">Modifying the Size, IOPS, or Type of an EBS Volume on Windows</a>.</p> <p>If you reach the maximum volume modification rate per volume limit, you will need to wait at least six hours before applying further modifications to the affected EBS volume.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyVolumeRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    volume_id: String.t ;
    size: Integer.t option ;
    volume_type: VolumeType.t option ;
    iops: Integer.t option }
  val make :
    ?dry_run:Boolean.t ->
      volume_id:String.t ->
        ?size:Integer.t ->
          ?volume_type:VolumeType.t -> ?iops:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyVolumeResult = ModifyVolumeResult
type input = ModifyVolumeRequest.t
type output = ModifyVolumeResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error