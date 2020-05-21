(** "<p>You can call <code>DescribeValidDBInstanceModifications</code> to learn what modifications you can make to your DB instance. You can use this information when you call <code>ModifyDBInstance</code>. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeValidDBInstanceModificationsMessage :
sig
  type t = {
    d_b_instance_identifier: String.t }[@@ocaml.doc "<p/>"]
  val make : d_b_instance_identifier:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeValidDBInstanceModificationsResult =
DescribeValidDBInstanceModificationsResult
type input = DescribeValidDBInstanceModificationsMessage.t
type output = DescribeValidDBInstanceModificationsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error