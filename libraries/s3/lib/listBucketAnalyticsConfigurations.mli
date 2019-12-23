open Types
type input = ListBucketAnalyticsConfigurationsRequest.t
type output = ListBucketAnalyticsConfigurationsOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error