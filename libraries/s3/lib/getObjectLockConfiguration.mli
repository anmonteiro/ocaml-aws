open Types
type input = GetObjectLockConfigurationRequest.t
type output = GetObjectLockConfigurationOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error