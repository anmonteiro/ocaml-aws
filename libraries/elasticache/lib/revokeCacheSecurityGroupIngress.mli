(** "<p>Revokes ingress from a cache security group. Use this operation to disallow access from an Amazon EC2 security group that had been previously authorized.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RevokeCacheSecurityGroupIngressMessage :
sig
  type t =
    {
    cache_security_group_name: String.t ;
    e_c2_security_group_name: String.t ;
    e_c2_security_group_owner_id: String.t }[@@ocaml.doc
                                              "<p>Represents the input of a <code>RevokeCacheSecurityGroupIngress</code> operation.</p>"]
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
module RevokeCacheSecurityGroupIngressResult =
RevokeCacheSecurityGroupIngressResult
type input = RevokeCacheSecurityGroupIngressMessage.t
type output = RevokeCacheSecurityGroupIngressResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error