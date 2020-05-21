(** "<p>Describes the specified EBS volumes or all of your EBS volumes.</p> <p>If you are describing a long list of volumes, you can paginate the output to make the list more manageable. The <code>MaxResults</code> parameter sets the maximum number of results returned in a single page. If the list of results exceeds your <code>MaxResults</code> value, then that number of results is returned along with a <code>NextToken</code> value that can be passed to a subsequent <code>DescribeVolumes</code> request to retrieve the remaining results.</p> <p>For more information about EBS volumes, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumes.html\">Amazon EBS Volumes</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeVolumesRequest :
sig
  type t =
    {
    filters: FilterList.t ;
    volume_ids: VolumeIdStringList.t ;
    dry_run: Boolean.t option ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    ?filters:FilterList.t ->
      ?volume_ids:VolumeIdStringList.t ->
        ?dry_run:Boolean.t ->
          ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeVolumesResult = DescribeVolumesResult
type input = DescribeVolumesRequest.t
type output = DescribeVolumesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error