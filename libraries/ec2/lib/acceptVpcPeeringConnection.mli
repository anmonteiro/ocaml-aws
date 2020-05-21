(** "<p>Accept a VPC peering connection request. To accept a request, the VPC peering connection must be in the <code>pending-acceptance</code> state, and you must be the owner of the peer VPC. Use <a>DescribeVpcPeeringConnections</a> to view your outstanding VPC peering connection requests.</p> <p>For an inter-Region VPC peering connection request, you must accept the VPC peering connection in the Region of the accepter VPC.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AcceptVpcPeeringConnectionRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    vpc_peering_connection_id: String.t option }
  val make :
    ?dry_run:Boolean.t -> ?vpc_peering_connection_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module AcceptVpcPeeringConnectionResult = AcceptVpcPeeringConnectionResult
type input = AcceptVpcPeeringConnectionRequest.t
type output = AcceptVpcPeeringConnectionResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error