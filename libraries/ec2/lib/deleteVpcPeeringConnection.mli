(** "<p>Deletes a VPC peering connection. Either the owner of the requester VPC or the owner of the accepter VPC can delete the VPC peering connection if it's in the <code>active</code> state. The owner of the requester VPC can delete a VPC peering connection in the <code>pending-acceptance</code> state. You cannot delete a VPC peering connection that's in the <code>failed</code> state.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteVpcPeeringConnectionRequest :
sig
  type t = {
    dry_run: Boolean.t option ;
    vpc_peering_connection_id: String.t }
  val make :
    ?dry_run:Boolean.t -> vpc_peering_connection_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DeleteVpcPeeringConnectionResult = DeleteVpcPeeringConnectionResult
type input = DeleteVpcPeeringConnectionRequest.t
type output = DeleteVpcPeeringConnectionResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error