(** "<note> <p>This is prerelease documentation for the RDS Database Proxy feature in preview release. It is subject to change.</p> </note> <p>Changes the settings for an existing DB proxy.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyDBProxyRequest :
sig
  type t =
    {
    d_b_proxy_name: String.t ;
    new_d_b_proxy_name: String.t option ;
    auth: UserAuthConfigList.t ;
    require_t_l_s: Boolean.t option ;
    idle_client_timeout: Integer.t option ;
    debug_logging: Boolean.t option ;
    role_arn: String.t option ;
    security_groups: StringList.t }
  val make :
    d_b_proxy_name:String.t ->
      ?new_d_b_proxy_name:String.t ->
        ?auth:UserAuthConfigList.t ->
          ?require_t_l_s:Boolean.t ->
            ?idle_client_timeout:Integer.t ->
              ?debug_logging:Boolean.t ->
                ?role_arn:String.t ->
                  ?security_groups:StringList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyDBProxyResponse = ModifyDBProxyResponse
type input = ModifyDBProxyRequest.t
type output = ModifyDBProxyResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error