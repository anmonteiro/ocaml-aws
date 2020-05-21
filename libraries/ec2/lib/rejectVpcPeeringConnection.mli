(** "<p>Rejects a VPC peering connection request. The VPC peering connection must be in the <code>pending-acceptance</code> state. Use the <a>DescribeVpcPeeringConnections</a> request to view your outstanding VPC peering connection requests. To delete an active VPC peering connection, or to delete a VPC peering connection request that you initiated, use <a>DeleteVpcPeeringConnection</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RejectVpcPeeringConnectionRequest :
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
module RejectVpcPeeringConnectionResult = RejectVpcPeeringConnectionResult
type input = RejectVpcPeeringConnectionRequest.t
type output = RejectVpcPeeringConnectionResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error