(** "<p>Modifies the attributes of your VPC endpoint service configuration. You can change the Network Load Balancers for your service, and you can specify whether acceptance is required for requests to connect to your endpoint service through an interface VPC endpoint.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyVpcEndpointServiceConfigurationRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    service_id: String.t ;
    acceptance_required: Boolean.t option ;
    add_network_load_balancer_arns: ValueStringList.t ;
    remove_network_load_balancer_arns: ValueStringList.t }
  val make :
    ?dry_run:Boolean.t ->
      service_id:String.t ->
        ?acceptance_required:Boolean.t ->
          ?add_network_load_balancer_arns:ValueStringList.t ->
            ?remove_network_load_balancer_arns:ValueStringList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyVpcEndpointServiceConfigurationResult =
ModifyVpcEndpointServiceConfigurationResult
type input = ModifyVpcEndpointServiceConfigurationRequest.t
type output = ModifyVpcEndpointServiceConfigurationResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error