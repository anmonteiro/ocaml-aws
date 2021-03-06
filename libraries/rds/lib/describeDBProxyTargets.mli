(** "<note> <p>This is prerelease documentation for the RDS Database Proxy feature in preview release. It is subject to change.</p> </note> <p>Returns information about <code>DBProxyTarget</code> objects. This API supports pagination.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeDBProxyTargetsRequest :
sig
  type t =
    {
    d_b_proxy_name: String.t ;
    target_group_name: String.t option ;
    filters: FilterList.t ;
    marker: String.t option ;
    max_records: Integer.t option }
  val make :
    d_b_proxy_name:String.t ->
      ?target_group_name:String.t ->
        ?filters:FilterList.t ->
          ?marker:String.t -> ?max_records:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeDBProxyTargetsResponse = DescribeDBProxyTargetsResponse
type input = DescribeDBProxyTargetsRequest.t
type output = DescribeDBProxyTargetsResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error