(** "<p>Describes the available CloudWatch metrics for Amazon EC2 Auto Scaling.</p> <p>The <code>GroupStandbyInstances</code> metric is not returned by default. You must explicitly request this metric when calling <a>EnableMetricsCollection</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module Input = Aws.BaseTypes.Unit
module DescribeMetricCollectionTypesAnswer =
DescribeMetricCollectionTypesAnswer
type input = Aws.BaseTypes.Unit.t
type output = DescribeMetricCollectionTypesAnswer.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error