(** "<p>Describes the current Amazon EC2 Auto Scaling resource limits for your AWS account.</p> <p>For information about requesting an increase in these limits, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-account-limits.html\">Amazon EC2 Auto Scaling Limits</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module Input = Aws.BaseTypes.Unit
module DescribeAccountLimitsAnswer = DescribeAccountLimitsAnswer
type input = Aws.BaseTypes.Unit.t
type output = DescribeAccountLimitsAnswer.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error