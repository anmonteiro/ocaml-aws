(** "<p>Modifies an existing DB subnet group. DB subnet groups must contain at least one subnet in at least two AZs in the AWS Region.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyDBSubnetGroupMessage :
sig
  type t =
    {
    d_b_subnet_group_name: String.t ;
    d_b_subnet_group_description: String.t option ;
    subnet_ids: SubnetIdentifierList.t }[@@ocaml.doc "<p/>"]
  val make :
    d_b_subnet_group_name:String.t ->
      ?d_b_subnet_group_description:String.t ->
        subnet_ids:SubnetIdentifierList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyDBSubnetGroupResult = ModifyDBSubnetGroupResult
type input = ModifyDBSubnetGroupMessage.t
type output = ModifyDBSubnetGroupResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error