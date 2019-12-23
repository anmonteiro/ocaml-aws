open Types
type input = SelectObjectContentRequest.t
type output = SelectObjectContentOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error