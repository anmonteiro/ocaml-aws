(** "<p>Deletes one or more VPC endpoint service configurations in your account. Before you delete the endpoint service configuration, you must reject any <code>Available</code> or <code>PendingAcceptance</code> interface endpoint connections that are attached to the service.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteVpcEndpointServiceConfigurationsRequest :
sig
  type t = {
    dry_run: Boolean.t option ;
    service_ids: ValueStringList.t }
  val make : ?dry_run:Boolean.t -> service_ids:ValueStringList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DeleteVpcEndpointServiceConfigurationsResult =
DeleteVpcEndpointServiceConfigurationsResult
type input = DeleteVpcEndpointServiceConfigurationsRequest.t
type output = DeleteVpcEndpointServiceConfigurationsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error