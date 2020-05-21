(** "<p>Creates a new DB security group. DB security groups control access to a DB instance.</p> <note> <p>A DB security group controls access to EC2-Classic DB instances that are not in a VPC.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateDBSecurityGroupMessage :
sig
  type t =
    {
    d_b_security_group_name: String.t ;
    d_b_security_group_description: String.t ;
    tags: TagList.t }[@@ocaml.doc "<p/>"]
  val make :
    d_b_security_group_name:String.t ->
      d_b_security_group_description:String.t -> ?tags:TagList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateDBSecurityGroupResult = CreateDBSecurityGroupResult
type input = CreateDBSecurityGroupMessage.t
type output = CreateDBSecurityGroupResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error