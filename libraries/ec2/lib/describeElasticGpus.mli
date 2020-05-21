(** "<p>Describes the Elastic Graphics accelerator associated with your instances. For more information about Elastic Graphics, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/elastic-graphics.html\">Amazon Elastic Graphics</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeElasticGpusRequest :
sig
  type t =
    {
    elastic_gpu_ids: ElasticGpuIdSet.t ;
    dry_run: Boolean.t option ;
    filters: FilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    ?elastic_gpu_ids:ElasticGpuIdSet.t ->
      ?dry_run:Boolean.t ->
        ?filters:FilterList.t ->
          ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeElasticGpusResult = DescribeElasticGpusResult
type input = DescribeElasticGpusRequest.t
type output = DescribeElasticGpusResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error