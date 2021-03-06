(** "<p>Describes one or more of your route tables.</p> <p>Each subnet in your VPC must be associated with a route table. If a subnet is not explicitly associated with any route table, it is implicitly associated with the main route table. This command does not return the subnet ID for implicit associations.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html\">Route Tables</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeRouteTablesRequest :
sig
  type t =
    {
    filters: FilterList.t ;
    dry_run: Boolean.t option ;
    route_table_ids: ValueStringList.t ;
    next_token: String.t option ;
    max_results: Integer.t option }
  val make :
    ?filters:FilterList.t ->
      ?dry_run:Boolean.t ->
        ?route_table_ids:ValueStringList.t ->
          ?next_token:String.t -> ?max_results:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeRouteTablesResult = DescribeRouteTablesResult
type input = DescribeRouteTablesRequest.t
type output = DescribeRouteTablesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error