(** "<p>Allows network ingress to a cache security group. Applications using ElastiCache must be running on Amazon EC2, and Amazon EC2 security groups are used as the authorization mechanism.</p> <note> <p>You cannot authorize ingress from an Amazon EC2 security group in one region to an ElastiCache cluster in another region.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AuthorizeCacheSecurityGroupIngressMessage :
sig
  type t =
    {
    cache_security_group_name: String.t ;
    e_c2_security_group_name: String.t ;
    e_c2_security_group_owner_id: String.t }[@@ocaml.doc
                                              "<p>Represents the input of an AuthorizeCacheSecurityGroupIngress operation.</p>"]
  val make :
    cache_security_group_name:String.t ->
      e_c2_security_group_name:String.t ->
        e_c2_security_group_owner_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module AuthorizeCacheSecurityGroupIngressResult =
AuthorizeCacheSecurityGroupIngressResult
type input = AuthorizeCacheSecurityGroupIngressMessage.t
type output = AuthorizeCacheSecurityGroupIngressResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error