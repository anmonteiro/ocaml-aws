(** "<p>Describes the specified Dedicated Hosts or all your Dedicated Hosts.</p> <p>The results describe only the Dedicated Hosts in the Region you're currently using. All listed instances consume capacity on your Dedicated Host. Dedicated Hosts that have recently been released are listed with the state <code>released</code>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeHostsRequest :
sig
  type t =
    {
    filter: FilterList.t ;
    host_ids: RequestHostIdList.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    ?filter:FilterList.t ->
      ?host_ids:RequestHostIdList.t ->
        ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeHostsResult = DescribeHostsResult
type input = DescribeHostsRequest.t
type output = DescribeHostsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error