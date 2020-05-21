(** "<note> <p>This is prerelease documentation for the RDS Database Proxy feature in preview release. It is subject to change.</p> </note> <p>Creates a new DB proxy.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateDBProxyRequest :
sig
  type t =
    {
    d_b_proxy_name: String.t ;
    engine_family: EngineFamily.t ;
    auth: UserAuthConfigList.t ;
    role_arn: String.t ;
    vpc_subnet_ids: StringList.t ;
    vpc_security_group_ids: StringList.t ;
    require_t_l_s: Boolean.t option ;
    idle_client_timeout: Integer.t option ;
    debug_logging: Boolean.t option ;
    tags: TagList.t }
  val make :
    d_b_proxy_name:String.t ->
      engine_family:EngineFamily.t ->
        auth:UserAuthConfigList.t ->
          role_arn:String.t ->
            vpc_subnet_ids:StringList.t ->
              ?vpc_security_group_ids:StringList.t ->
                ?require_t_l_s:Boolean.t ->
                  ?idle_client_timeout:Integer.t ->
                    ?debug_logging:Boolean.t -> ?tags:TagList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateDBProxyResponse = CreateDBProxyResponse
type input = CreateDBProxyRequest.t
type output = CreateDBProxyResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error