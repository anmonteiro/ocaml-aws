(** "<p>Describes the policy adjustment types for use with <a>PutScalingPolicy</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module Input = Aws.BaseTypes.Unit
module DescribeAdjustmentTypesAnswer = DescribeAdjustmentTypesAnswer
type input = Aws.BaseTypes.Unit.t
type output = DescribeAdjustmentTypesAnswer.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error