(** "<note> <p>This is prerelease documentation for the RDS Database Proxy feature in preview release. It is subject to change.</p> </note> <p>Modifies the properties of a <code>DBProxyTargetGroup</code>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyDBProxyTargetGroupRequest :
sig
  type t =
    {
    target_group_name: String.t ;
    d_b_proxy_name: String.t ;
    connection_pool_config: ConnectionPoolConfiguration.t option ;
    new_name: String.t option }
  val make :
    target_group_name:String.t ->
      d_b_proxy_name:String.t ->
        ?connection_pool_config:ConnectionPoolConfiguration.t ->
          ?new_name:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyDBProxyTargetGroupResponse = ModifyDBProxyTargetGroupResponse
type input = ModifyDBProxyTargetGroupRequest.t
type output = ModifyDBProxyTargetGroupResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error