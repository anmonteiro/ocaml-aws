(** "<p>Reports the current modification status of EBS volumes.</p> <p>Current-generation EBS volumes support modification of attributes including type, size, and (for <code>io1</code> volumes) IOPS provisioning while either attached to or detached from an instance. Following an action from the API or the console to modify a volume, the status of the modification may be <code>modifying</code>, <code>optimizing</code>, <code>completed</code>, or <code>failed</code>. If a volume has never been modified, then certain elements of the returned <code>VolumeModification</code> objects are null. </p> <p> You can also use CloudWatch Events to check the status of a modification to an EBS volume. For information about CloudWatch Events, see the <a href=\"https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/\">Amazon CloudWatch Events User Guide</a>. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-expand-volume.html#monitoring_mods\">Monitoring Volume Modifications\"</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeVolumesModificationsRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    volume_ids: VolumeIdStringList.t ;
    filters: FilterList.t ;
    next_token: String.t option ;
    max_results: Integer.t option }
  val make :
    ?dry_run:Boolean.t ->
      ?volume_ids:VolumeIdStringList.t ->
        ?filters:FilterList.t ->
          ?next_token:String.t -> ?max_results:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeVolumesModificationsResult =
DescribeVolumesModificationsResult
type input = DescribeVolumesModificationsRequest.t
type output = DescribeVolumesModificationsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error