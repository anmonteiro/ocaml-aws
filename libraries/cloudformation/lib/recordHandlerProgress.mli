(** "<p>Reports progress of a resource handler to CloudFormation.</p> <p>Reserved for use by the <a href=\"https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/what-is-cloudformation-cli.html\">CloudFormation CLI</a>. Do not use this API in your code.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RecordHandlerProgressInput :
sig
  type t =
    {
    bearer_token: String.t ;
    operation_status: OperationStatus.t ;
    current_operation_status: OperationStatus.t option ;
    status_message: String.t option ;
    error_code: HandlerErrorCode.t option ;
    resource_model: String.t option ;
    client_request_token: String.t option }
  val make :
    bearer_token:String.t ->
      operation_status:OperationStatus.t ->
        ?current_operation_status:OperationStatus.t ->
          ?status_message:String.t ->
            ?error_code:HandlerErrorCode.t ->
              ?resource_model:String.t ->
                ?client_request_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = RecordHandlerProgressInput.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error