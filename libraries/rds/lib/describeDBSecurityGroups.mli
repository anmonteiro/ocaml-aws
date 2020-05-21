(** "<p> Returns a list of <code>DBSecurityGroup</code> descriptions. If a <code>DBSecurityGroupName</code> is specified, the list will contain only the descriptions of the specified DB security group. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeDBSecurityGroupsMessage :
sig
  type t =
    {
    d_b_security_group_name: String.t option ;
    filters: FilterList.t ;
    max_records: Integer.t option ;
    marker: String.t option }[@@ocaml.doc "<p/>"]
  val make :
    ?d_b_security_group_name:String.t ->
      ?filters:FilterList.t ->
        ?max_records:Integer.t -> ?marker:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DBSecurityGroupMessage = DBSecurityGroupMessage
type input = DescribeDBSecurityGroupsMessage.t
type output = DBSecurityGroupMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error