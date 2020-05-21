(** "<p>Describes the Spot price history. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-spot-instances-history.html\">Spot Instance Pricing History</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.</p> <p>When you specify a start and end time, this operation returns the prices of the instance types within the time range that you specified and the time when the price changed. The price is valid within the time period that you specified; the response merely indicates the last time that the price changed.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeSpotPriceHistoryRequest :
sig
  type t =
    {
    filters: FilterList.t ;
    availability_zone: String.t option ;
    dry_run: Boolean.t option ;
    end_time: DateTime.t option ;
    instance_types: InstanceTypeList.t ;
    max_results: Integer.t option ;
    next_token: String.t option ;
    product_descriptions: ProductDescriptionList.t ;
    start_time: DateTime.t option }[@@ocaml.doc
                                     "<p>Contains the parameters for DescribeSpotPriceHistory.</p>"]
  val make :
    ?filters:FilterList.t ->
      ?availability_zone:String.t ->
        ?dry_run:Boolean.t ->
          ?end_time:DateTime.t ->
            ?instance_types:InstanceTypeList.t ->
              ?max_results:Integer.t ->
                ?next_token:String.t ->
                  ?product_descriptions:ProductDescriptionList.t ->
                    ?start_time:DateTime.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeSpotPriceHistoryResult = DescribeSpotPriceHistoryResult
type input = DescribeSpotPriceHistoryRequest.t
type output = DescribeSpotPriceHistoryResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error