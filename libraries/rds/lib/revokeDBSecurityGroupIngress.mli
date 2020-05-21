(** "<p>Revokes ingress from a DBSecurityGroup for previously authorized IP ranges or EC2 or VPC Security Groups. Required parameters for this API are one of CIDRIP, EC2SecurityGroupId for VPC, or (EC2SecurityGroupOwnerId and either EC2SecurityGroupName or EC2SecurityGroupId).</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RevokeDBSecurityGroupIngressMessage :
sig
  type t =
    {
    d_b_security_group_name: String.t ;
    c_i_d_r_i_p: String.t option ;
    e_c2_security_group_name: String.t option ;
    e_c2_security_group_id: String.t option ;
    e_c2_security_group_owner_id: String.t option }[@@ocaml.doc "<p/>"]
  val make :
    d_b_security_group_name:String.t ->
      ?c_i_d_r_i_p:String.t ->
        ?e_c2_security_group_name:String.t ->
          ?e_c2_security_group_id:String.t ->
            ?e_c2_security_group_owner_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module RevokeDBSecurityGroupIngressResult =
RevokeDBSecurityGroupIngressResult
type input = RevokeDBSecurityGroupIngressMessage.t
type output = RevokeDBSecurityGroupIngressResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error