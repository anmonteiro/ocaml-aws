open Types
type input = ModifyTransitGatewayVpcAttachmentRequest.t
type output = ModifyTransitGatewayVpcAttachmentResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error