(** "<p>Modifies the permissions for your <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/endpoint-service.html\">VPC endpoint service</a>. You can add or remove permissions for service consumers (IAM users, IAM roles, and AWS accounts) to connect to your endpoint service.</p> <p>If you grant permissions to all principals, the service is public. Any users who know the name of a public service can send a request to attach an endpoint. If the service does not require manual approval, attachments are automatically approved.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyVpcEndpointServicePermissionsRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    service_id: String.t ;
    add_allowed_principals: ValueStringList.t ;
    remove_allowed_principals: ValueStringList.t }
  val make :
    ?dry_run:Boolean.t ->
      service_id:String.t ->
        ?add_allowed_principals:ValueStringList.t ->
          ?remove_allowed_principals:ValueStringList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyVpcEndpointServicePermissionsResult =
ModifyVpcEndpointServicePermissionsResult
type input = ModifyVpcEndpointServicePermissionsRequest.t
type output = ModifyVpcEndpointServicePermissionsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error