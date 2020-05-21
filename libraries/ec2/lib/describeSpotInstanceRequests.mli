(** "<p>Describes the specified Spot Instance requests.</p> <p>You can use <code>DescribeSpotInstanceRequests</code> to find a running Spot Instance by examining the response. If the status of the Spot Instance is <code>fulfilled</code>, the instance ID appears in the response and contains the identifier of the instance. Alternatively, you can use <a>DescribeInstances</a> with a filter to look for instances where the instance lifecycle is <code>spot</code>.</p> <p>We recommend that you set <code>MaxResults</code> to a value between 5 and 1000 to limit the number of results returned. This paginates the output, which makes the list more manageable and returns the results faster. If the list of results exceeds your <code>MaxResults</code> value, then that number of results is returned along with a <code>NextToken</code> value that can be passed to a subsequent <code>DescribeSpotInstanceRequests</code> request to retrieve the remaining results.</p> <p>Spot Instance requests are deleted four hours after they are canceled and their instances are terminated.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeSpotInstanceRequestsRequest :
sig
  type t =
    {
    filters: FilterList.t ;
    dry_run: Boolean.t option ;
    spot_instance_request_ids: SpotInstanceRequestIdList.t ;
    next_token: String.t option ;
    max_results: Integer.t option }[@@ocaml.doc
                                     "<p>Contains the parameters for DescribeSpotInstanceRequests.</p>"]
  val make :
    ?filters:FilterList.t ->
      ?dry_run:Boolean.t ->
        ?spot_instance_request_ids:SpotInstanceRequestIdList.t ->
          ?next_token:String.t -> ?max_results:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeSpotInstanceRequestsResult =
DescribeSpotInstanceRequestsResult
type input = DescribeSpotInstanceRequestsRequest.t
type output = DescribeSpotInstanceRequestsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error