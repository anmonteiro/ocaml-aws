(** "<p>Describes the credit option for CPU usage of the specified burstable performance instances. The credit options are <code>standard</code> and <code>unlimited</code>.</p> <p>If you do not specify an instance ID, Amazon EC2 returns burstable performance instances with the <code>unlimited</code> credit option, as well as instances that were previously configured as T2, T3, and T3a with the <code>unlimited</code> credit option. For example, if you resize a T2 instance, while it is configured as <code>unlimited</code>, to an M4 instance, Amazon EC2 returns the M4 instance.</p> <p>If you specify one or more instance IDs, Amazon EC2 returns the credit option (<code>standard</code> or <code>unlimited</code>) of those instances. If you specify an instance ID that is not valid, such as an instance that is not a burstable performance instance, an error is returned.</p> <p>Recently terminated instances might appear in the returned results. This interval is usually less than one hour.</p> <p>If an Availability Zone is experiencing a service disruption and you specify instance IDs in the affected zone, or do not specify any instance IDs at all, the call fails. If you specify only instance IDs in an unaffected zone, the call works normally.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances.html\">Burstable Performance Instances</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeInstanceCreditSpecificationsRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    filters: FilterList.t ;
    instance_ids: InstanceIdStringList.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    ?dry_run:Boolean.t ->
      ?filters:FilterList.t ->
        ?instance_ids:InstanceIdStringList.t ->
          ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeInstanceCreditSpecificationsResult =
DescribeInstanceCreditSpecificationsResult
type input = DescribeInstanceCreditSpecificationsRequest.t
type output = DescribeInstanceCreditSpecificationsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error