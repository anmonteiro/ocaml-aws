(** "<p>Retrieves the alarms for the specified metric. To filter the results, specify a statistic, period, or unit.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeAlarmsForMetricInput :
sig
  type t =
    {
    metric_name: String.t ;
    namespace: String.t ;
    statistic: Statistic.t option ;
    extended_statistic: String.t option ;
    dimensions: Dimensions.t ;
    period: Integer.t option ;
    unit: StandardUnit.t option }
  val make :
    metric_name:String.t ->
      namespace:String.t ->
        ?statistic:Statistic.t ->
          ?extended_statistic:String.t ->
            ?dimensions:Dimensions.t ->
              ?period:Integer.t -> ?unit:StandardUnit.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeAlarmsForMetricOutput = DescribeAlarmsForMetricOutput
type input = DescribeAlarmsForMetricInput.t
type output = DescribeAlarmsForMetricOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error