(** "<p>Describes the running instances for the specified EC2 Fleet.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeFleetInstancesRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    max_results: Integer.t option ;
    next_token: String.t option ;
    fleet_id: String.t ;
    filters: FilterList.t }
  val make :
    ?dry_run:Boolean.t ->
      ?max_results:Integer.t ->
        ?next_token:String.t ->
          fleet_id:String.t -> ?filters:FilterList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeFleetInstancesResult = DescribeFleetInstancesResult
type input = DescribeFleetInstancesRequest.t
type output = DescribeFleetInstancesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error