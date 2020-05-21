(** "<p>Describes one or more of your linked EC2-Classic instances. This request only returns information about EC2-Classic instances linked to a VPC through ClassicLink. You cannot use this request to return information about other instances.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeClassicLinkInstancesRequest :
sig
  type t =
    {
    filters: FilterList.t ;
    dry_run: Boolean.t option ;
    instance_ids: InstanceIdStringList.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    ?filters:FilterList.t ->
      ?dry_run:Boolean.t ->
        ?instance_ids:InstanceIdStringList.t ->
          ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeClassicLinkInstancesResult =
DescribeClassicLinkInstancesResult
type input = DescribeClassicLinkInstancesRequest.t
type output = DescribeClassicLinkInstancesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error