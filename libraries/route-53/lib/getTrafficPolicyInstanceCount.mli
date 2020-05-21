(** "<p>Gets the number of traffic policy instances that are associated with the current AWS account.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module Input = Aws.BaseTypes.Unit
module GetTrafficPolicyInstanceCountResponse =
GetTrafficPolicyInstanceCountResponse
type input = unit
type output = GetTrafficPolicyInstanceCountResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error