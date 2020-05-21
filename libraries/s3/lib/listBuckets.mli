(** "<p>Returns a list of all buckets owned by the authenticated sender of the request.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module Input = Aws.BaseTypes.Unit
module ListBucketsOutput = ListBucketsOutput
type input = Aws.BaseTypes.Unit.t
type output = ListBucketsOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error