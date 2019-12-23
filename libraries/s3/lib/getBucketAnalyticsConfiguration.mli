open Types
type input = GetBucketAnalyticsConfigurationRequest.t
type output = GetBucketAnalyticsConfigurationOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error