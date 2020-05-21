(** "<p>Describes the specified placement groups or all of your placement groups. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html\">Placement Groups</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribePlacementGroupsRequest :
sig
  type t =
    {
    filters: FilterList.t ;
    dry_run: Boolean.t option ;
    group_names: PlacementGroupStringList.t ;
    group_ids: PlacementGroupIdStringList.t }
  val make :
    ?filters:FilterList.t ->
      ?dry_run:Boolean.t ->
        ?group_names:PlacementGroupStringList.t ->
          ?group_ids:PlacementGroupIdStringList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribePlacementGroupsResult = DescribePlacementGroupsResult
type input = DescribePlacementGroupsRequest.t
type output = DescribePlacementGroupsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error