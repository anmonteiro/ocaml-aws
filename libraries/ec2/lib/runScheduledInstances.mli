(** "<p>Launches the specified Scheduled Instances.</p> <p>Before you can launch a Scheduled Instance, you must purchase it and obtain an identifier using <a>PurchaseScheduledInstances</a>.</p> <p>You must launch a Scheduled Instance during its scheduled time period. You can't stop or reboot a Scheduled Instance, but you can terminate it as needed. If you terminate a Scheduled Instance before the current scheduled time period ends, you can launch it again after a few minutes. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-scheduled-instances.html\">Scheduled Instances</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RunScheduledInstancesRequest :
sig
  type t =
    {
    client_token: String.t option ;
    dry_run: Boolean.t option ;
    instance_count: Integer.t option ;
    launch_specification: ScheduledInstancesLaunchSpecification.t ;
    scheduled_instance_id: String.t }[@@ocaml.doc
                                       "<p>Contains the parameters for RunScheduledInstances.</p>"]
  val make :
    ?client_token:String.t ->
      ?dry_run:Boolean.t ->
        ?instance_count:Integer.t ->
          launch_specification:ScheduledInstancesLaunchSpecification.t ->
            scheduled_instance_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module RunScheduledInstancesResult = RunScheduledInstancesResult
type input = RunScheduledInstancesRequest.t
type output = RunScheduledInstancesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error