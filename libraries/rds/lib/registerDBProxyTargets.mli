(** "<note> <p>This is prerelease documentation for the RDS Database Proxy feature in preview release. It is subject to change.</p> </note> <p>Associate one or more <code>DBProxyTarget</code> data structures with a <code>DBProxyTargetGroup</code>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RegisterDBProxyTargetsRequest :
sig
  type t =
    {
    d_b_proxy_name: String.t ;
    target_group_name: String.t option ;
    d_b_instance_identifiers: StringList.t ;
    d_b_cluster_identifiers: StringList.t }
  val make :
    d_b_proxy_name:String.t ->
      ?target_group_name:String.t ->
        ?d_b_instance_identifiers:StringList.t ->
          ?d_b_cluster_identifiers:StringList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module RegisterDBProxyTargetsResponse = RegisterDBProxyTargetsResponse
type input = RegisterDBProxyTargetsRequest.t
type output = RegisterDBProxyTargetsResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error