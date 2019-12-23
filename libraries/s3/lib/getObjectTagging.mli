open Types
type input = GetObjectTaggingRequest.t
type output = GetObjectTaggingOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error