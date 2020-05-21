(** "<p>Creates an anomaly detection model for a CloudWatch metric. You can use the model to display a band of expected normal values when the metric is graphed.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Anomaly_Detection.html\">CloudWatch Anomaly Detection</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PutAnomalyDetectorInput :
sig
  type t =
    {
    namespace: String.t ;
    metric_name: String.t ;
    dimensions: Dimensions.t ;
    stat: String.t ;
    configuration: AnomalyDetectorConfiguration.t option }
  val make :
    namespace:String.t ->
      metric_name:String.t ->
        ?dimensions:Dimensions.t ->
          stat:String.t ->
            ?configuration:AnomalyDetectorConfiguration.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = PutAnomalyDetectorInput.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error