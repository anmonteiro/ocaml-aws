(** "<p>Describes the termination policies supported by Amazon EC2 Auto Scaling.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-instance-termination.html\">Controlling Which Auto Scaling Instances Terminate During Scale In</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module Input = Aws.BaseTypes.Unit
module DescribeTerminationPolicyTypesAnswer =
DescribeTerminationPolicyTypesAnswer
type input = Aws.BaseTypes.Unit.t
type output = DescribeTerminationPolicyTypesAnswer.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error