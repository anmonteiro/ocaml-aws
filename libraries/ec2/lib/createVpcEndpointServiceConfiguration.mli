(** "<p>Creates a VPC endpoint service configuration to which service consumers (AWS accounts, IAM users, and IAM roles) can connect. Service consumers can create an interface VPC endpoint to connect to your service.</p> <p>To create an endpoint service configuration, you must first create a Network Load Balancer for your service. For more information, see <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/endpoint-service.html\">VPC Endpoint Services</a> in the <i>Amazon Virtual Private Cloud User Guide</i>. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateVpcEndpointServiceConfigurationRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    acceptance_required: Boolean.t option ;
    network_load_balancer_arns: ValueStringList.t ;
    client_token: String.t option }
  val make :
    ?dry_run:Boolean.t ->
      ?acceptance_required:Boolean.t ->
        network_load_balancer_arns:ValueStringList.t ->
          ?client_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateVpcEndpointServiceConfigurationResult =
CreateVpcEndpointServiceConfigurationResult
type input = CreateVpcEndpointServiceConfigurationRequest.t
type output = CreateVpcEndpointServiceConfigurationResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error