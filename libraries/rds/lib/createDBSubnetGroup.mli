(** "<p>Creates a new DB subnet group. DB subnet groups must contain at least one subnet in at least two AZs in the AWS Region.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateDBSubnetGroupMessage :
sig
  type t =
    {
    d_b_subnet_group_name: String.t ;
    d_b_subnet_group_description: String.t ;
    subnet_ids: SubnetIdentifierList.t ;
    tags: TagList.t }[@@ocaml.doc "<p/>"]
  val make :
    d_b_subnet_group_name:String.t ->
      d_b_subnet_group_description:String.t ->
        subnet_ids:SubnetIdentifierList.t -> ?tags:TagList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateDBSubnetGroupResult = CreateDBSubnetGroupResult
type input = CreateDBSubnetGroupMessage.t
type output = CreateDBSubnetGroupResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error