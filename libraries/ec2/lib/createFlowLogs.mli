(** "<p>Creates one or more flow logs to capture information about IP traffic for a specific network interface, subnet, or VPC. </p> <p>Flow log data for a monitored network interface is recorded as flow log records, which are log events consisting of fields that describe the traffic flow. For more information, see <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs.html#flow-log-records\">Flow Log Records</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p> <p>When publishing to CloudWatch Logs, flow log records are published to a log group, and each network interface has a unique log stream in the log group. When publishing to Amazon S3, flow log records for all of the monitored network interfaces are published to a single log file object that is stored in the specified bucket.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs.html\">VPC Flow Logs</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateFlowLogsRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    client_token: String.t option ;
    deliver_logs_permission_arn: String.t option ;
    log_group_name: String.t option ;
    resource_ids: ValueStringList.t ;
    resource_type: FlowLogsResourceType.t ;
    traffic_type: TrafficType.t ;
    log_destination_type: LogDestinationType.t option ;
    log_destination: String.t option ;
    log_format: String.t option }
  val make :
    ?dry_run:Boolean.t ->
      ?client_token:String.t ->
        ?deliver_logs_permission_arn:String.t ->
          ?log_group_name:String.t ->
            resource_ids:ValueStringList.t ->
              resource_type:FlowLogsResourceType.t ->
                traffic_type:TrafficType.t ->
                  ?log_destination_type:LogDestinationType.t ->
                    ?log_destination:String.t ->
                      ?log_format:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateFlowLogsResult = CreateFlowLogsResult
type input = CreateFlowLogsRequest.t
type output = CreateFlowLogsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error