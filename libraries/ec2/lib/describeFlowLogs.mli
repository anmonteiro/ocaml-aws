(** "<p>Describes one or more flow logs. To view the information in your flow logs (the log streams for the network interfaces), you must use the CloudWatch Logs console or the CloudWatch Logs API.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeFlowLogsRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    filter: FilterList.t ;
    flow_log_ids: ValueStringList.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    ?dry_run:Boolean.t ->
      ?filter:FilterList.t ->
        ?flow_log_ids:ValueStringList.t ->
          ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeFlowLogsResult = DescribeFlowLogsResult
type input = DescribeFlowLogsRequest.t
type output = DescribeFlowLogsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error