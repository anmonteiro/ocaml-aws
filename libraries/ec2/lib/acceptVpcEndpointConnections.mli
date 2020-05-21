(** "<p>Accepts one or more interface VPC endpoint connection requests to your VPC endpoint service.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AcceptVpcEndpointConnectionsRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    service_id: String.t ;
    vpc_endpoint_ids: ValueStringList.t }
  val make :
    ?dry_run:Boolean.t ->
      service_id:String.t -> vpc_endpoint_ids:ValueStringList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module AcceptVpcEndpointConnectionsResult =
AcceptVpcEndpointConnectionsResult
type input = AcceptVpcEndpointConnectionsRequest.t
type output = AcceptVpcEndpointConnectionsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error