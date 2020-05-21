(** "<p>Describes the Regions that are enabled for your account, or all Regions.</p> <p>For a list of the Regions supported by Amazon EC2, see <a href=\"https://docs.aws.amazon.com/general/latest/gr/rande.html#ec2_region\"> Regions and Endpoints</a>.</p> <p>For information about enabling and disabling Regions for your account, see <a href=\"https://docs.aws.amazon.com/general/latest/gr/rande-manage.html\">Managing AWS Regions</a> in the <i>AWS General Reference</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeRegionsRequest :
sig
  type t =
    {
    filters: FilterList.t ;
    region_names: RegionNameStringList.t ;
    dry_run: Boolean.t option ;
    all_regions: Boolean.t option }
  val make :
    ?filters:FilterList.t ->
      ?region_names:RegionNameStringList.t ->
        ?dry_run:Boolean.t -> ?all_regions:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeRegionsResult = DescribeRegionsResult
type input = DescribeRegionsRequest.t
type output = DescribeRegionsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error