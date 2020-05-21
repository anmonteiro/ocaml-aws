(** "<p>Creates a VPC endpoint for a specified service. An endpoint enables you to create a private connection between your VPC and the service. The service may be provided by AWS, an AWS Marketplace partner, or another AWS account. For more information, see <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/vpc-endpoints.html\">VPC Endpoints</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p> <p>A <code>gateway</code> endpoint serves as a target for a route in your route table for traffic destined for the AWS service. You can specify an endpoint policy to attach to the endpoint that will control access to the service from your VPC. You can also specify the VPC route tables that use the endpoint.</p> <p>An <code>interface</code> endpoint is a network interface in your subnet that serves as an endpoint for communicating with the specified service. You can specify the subnets in which to create an endpoint, and the security groups to associate with the endpoint network interface.</p> <p>Use <a>DescribeVpcEndpointServices</a> to get a list of supported services.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateVpcEndpointRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    vpc_endpoint_type: VpcEndpointType.t option ;
    vpc_id: String.t ;
    service_name: String.t ;
    policy_document: String.t option ;
    route_table_ids: ValueStringList.t ;
    subnet_ids: ValueStringList.t ;
    security_group_ids: ValueStringList.t ;
    client_token: String.t option ;
    private_dns_enabled: Boolean.t option }[@@ocaml.doc
                                             "<p>Contains the parameters for CreateVpcEndpoint.</p>"]
  val make :
    ?dry_run:Boolean.t ->
      ?vpc_endpoint_type:VpcEndpointType.t ->
        vpc_id:String.t ->
          service_name:String.t ->
            ?policy_document:String.t ->
              ?route_table_ids:ValueStringList.t ->
                ?subnet_ids:ValueStringList.t ->
                  ?security_group_ids:ValueStringList.t ->
                    ?client_token:String.t ->
                      ?private_dns_enabled:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateVpcEndpointResult = CreateVpcEndpointResult
type input = CreateVpcEndpointRequest.t
type output = CreateVpcEndpointResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error