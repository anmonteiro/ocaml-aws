(** "<p>Deletes one or more specified VPC endpoints. Deleting a gateway endpoint also deletes the endpoint routes in the route tables that were associated with the endpoint. Deleting an interface endpoint deletes the endpoint network interfaces.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteVpcEndpointsRequest :
sig
  type t = {
    dry_run: Boolean.t option ;
    vpc_endpoint_ids: ValueStringList.t }[@@ocaml.doc
                                           "<p>Contains the parameters for DeleteVpcEndpoints.</p>"]
  val make :
    ?dry_run:Boolean.t -> vpc_endpoint_ids:ValueStringList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DeleteVpcEndpointsResult = DeleteVpcEndpointsResult
type input = DeleteVpcEndpointsRequest.t
type output = DeleteVpcEndpointsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error