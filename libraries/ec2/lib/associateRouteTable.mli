(** "<p>Associates a subnet in your VPC or an internet gateway or virtual private gateway attached to your VPC with a route table in your VPC. This association causes traffic from the subnet or gateway to be routed according to the routes in the route table. The action returns an association ID, which you need in order to disassociate the route table later. A route table can be associated with multiple subnets.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html\">Route Tables</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AssociateRouteTableRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    route_table_id: String.t ;
    subnet_id: String.t option ;
    gateway_id: String.t option }
  val make :
    ?dry_run:Boolean.t ->
      route_table_id:String.t ->
        ?subnet_id:String.t -> ?gateway_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module AssociateRouteTableResult = AssociateRouteTableResult
type input = AssociateRouteTableRequest.t
type output = AssociateRouteTableResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error