(** "<p>Returns a list of all instance types offered in your current AWS Region. The results can be filtered by the attributes of the instance types.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeInstanceTypesRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    instance_types: RequestInstanceTypeList.t ;
    filters: FilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    ?dry_run:Boolean.t ->
      ?instance_types:RequestInstanceTypeList.t ->
        ?filters:FilterList.t ->
          ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeInstanceTypesResult = DescribeInstanceTypesResult
type input = DescribeInstanceTypesRequest.t
type output = DescribeInstanceTypesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error