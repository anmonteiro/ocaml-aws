(** "<p>Registers a type with the CloudFormation service. Registering a type makes it available for use in CloudFormation templates in your AWS account, and includes:</p> <ul> <li> <p>Validating the resource schema</p> </li> <li> <p>Determining which handlers have been specified for the resource</p> </li> <li> <p>Making the resource type available for use in your account</p> </li> </ul> <p>For more information on how to develop types and ready them for registeration, see <a href=\"cloudformation-cli/latest/userguide/resource-types.html\">Creating Resource Providers</a> in the <i>CloudFormation CLI User Guide</i>.</p> <p>Once you have initiated a registration request using <code> <a>RegisterType</a> </code>, you can use <code> <a>DescribeTypeRegistration</a> </code> to monitor the progress of the registration request.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RegisterTypeInput :
sig
  type t =
    {
    type_: RegistryType.t option ;
    type_name: String.t ;
    schema_handler_package: String.t ;
    logging_config: LoggingConfig.t option ;
    execution_role_arn: String.t option ;
    client_request_token: String.t option }
  val make :
    ?type_:RegistryType.t ->
      type_name:String.t ->
        schema_handler_package:String.t ->
          ?logging_config:LoggingConfig.t ->
            ?execution_role_arn:String.t ->
              ?client_request_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module RegisterTypeOutput = RegisterTypeOutput
type input = RegisterTypeInput.t
type output = RegisterTypeOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error