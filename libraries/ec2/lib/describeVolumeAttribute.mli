(** "<p>Describes the specified attribute of the specified volume. You can specify only one attribute at a time.</p> <p>For more information about EBS volumes, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumes.html\">Amazon EBS Volumes</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeVolumeAttributeRequest :
sig
  type t =
    {
    attribute: VolumeAttributeName.t ;
    volume_id: String.t ;
    dry_run: Boolean.t option }
  val make :
    attribute:VolumeAttributeName.t ->
      volume_id:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeVolumeAttributeResult = DescribeVolumeAttributeResult
type input = DescribeVolumeAttributeRequest.t
type output = DescribeVolumeAttributeResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error