(** "<p>Retrieves the number of health checks that are associated with the current AWS account.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module Input = Aws.BaseTypes.Unit
module GetHealthCheckCountResponse = GetHealthCheckCountResponse
type input = unit
type output = GetHealthCheckCountResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error