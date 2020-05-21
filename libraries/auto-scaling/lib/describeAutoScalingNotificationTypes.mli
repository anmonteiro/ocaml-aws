(** "<p>Describes the notification types that are supported by Amazon EC2 Auto Scaling.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module Input = Aws.BaseTypes.Unit
module DescribeAutoScalingNotificationTypesAnswer =
DescribeAutoScalingNotificationTypesAnswer
type input = Aws.BaseTypes.Unit.t
type output = DescribeAutoScalingNotificationTypesAnswer.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error