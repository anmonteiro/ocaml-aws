open Types
type input = ListObjectsV2Request.t
type output = ListObjectsV2Output.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error