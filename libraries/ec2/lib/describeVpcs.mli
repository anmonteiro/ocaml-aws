(** "<p>Describes one or more of your VPCs.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeVpcsRequest :
sig
  type t =
    {
    filters: FilterList.t ;
    vpc_ids: VpcIdStringList.t ;
    dry_run: Boolean.t option ;
    next_token: String.t option ;
    max_results: Integer.t option }
  val make :
    ?filters:FilterList.t ->
      ?vpc_ids:VpcIdStringList.t ->
        ?dry_run:Boolean.t ->
          ?next_token:String.t -> ?max_results:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeVpcsResult = DescribeVpcsResult
type input = DescribeVpcsRequest.t
type output = DescribeVpcsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error