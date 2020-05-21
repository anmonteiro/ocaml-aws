(** "<p>Disassociates an AWS Identity and Access Management (IAM) role from a DB instance.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RemoveRoleFromDBInstanceMessage :
sig
  type t =
    {
    d_b_instance_identifier: String.t ;
    role_arn: String.t ;
    feature_name: String.t }
  val make :
    d_b_instance_identifier:String.t ->
      role_arn:String.t -> feature_name:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = RemoveRoleFromDBInstanceMessage.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error