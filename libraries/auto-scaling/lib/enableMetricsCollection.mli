(** "<p>Enables group metrics for the specified Auto Scaling group. For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-instance-monitoring.html\">Monitoring Your Auto Scaling Groups and Instances</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module EnableMetricsCollectionQuery :
sig
  type t =
    {
    auto_scaling_group_name: String.t ;
    metrics: Metrics.t ;
    granularity: String.t }
  val make :
    auto_scaling_group_name:String.t ->
      ?metrics:Metrics.t -> granularity:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = EnableMetricsCollectionQuery.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error