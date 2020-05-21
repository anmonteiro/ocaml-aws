(** "<p>Enables ingress to a DBSecurityGroup using one of two forms of authorization. First, EC2 or VPC security groups can be added to the DBSecurityGroup if the application using the database is running on EC2 or VPC instances. Second, IP ranges are available if the application accessing your database is running on the Internet. Required parameters for this API are one of CIDR range, EC2SecurityGroupId for VPC, or (EC2SecurityGroupOwnerId and either EC2SecurityGroupName or EC2SecurityGroupId for non-VPC).</p> <note> <p>You can't authorize ingress from an EC2 security group in one AWS Region to an Amazon RDS DB instance in another. You can't authorize ingress from a VPC security group in one VPC to an Amazon RDS DB instance in another.</p> </note> <p>For an overview of CIDR ranges, go to the <a href=\"http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing\">Wikipedia Tutorial</a>. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AuthorizeDBSecurityGroupIngressMessage :
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
module AuthorizeDBSecurityGroupIngressResult =
AuthorizeDBSecurityGroupIngressResult
type input = AuthorizeDBSecurityGroupIngressMessage.t
type output = AuthorizeDBSecurityGroupIngressResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error