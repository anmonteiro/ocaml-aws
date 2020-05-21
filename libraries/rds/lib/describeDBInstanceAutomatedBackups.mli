(** "<p>Displays backups for both current and deleted instances. For example, use this operation to find details about automated backups for previously deleted instances. Current instances with retention periods greater than zero (0) are returned for both the <code>DescribeDBInstanceAutomatedBackups</code> and <code>DescribeDBInstances</code> operations.</p> <p>All parameters are optional.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeDBInstanceAutomatedBackupsMessage :
sig
  type t =
    {
    dbi_resource_id: String.t option ;
    d_b_instance_identifier: String.t option ;
    filters: FilterList.t ;
    max_records: Integer.t option ;
    marker: String.t option }[@@ocaml.doc
                               "<p>Parameter input for DescribeDBInstanceAutomatedBackups. </p>"]
  val make :
    ?dbi_resource_id:String.t ->
      ?d_b_instance_identifier:String.t ->
        ?filters:FilterList.t ->
          ?max_records:Integer.t -> ?marker:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DBInstanceAutomatedBackupMessage = DBInstanceAutomatedBackupMessage
type input = DescribeDBInstanceAutomatedBackupsMessage.t
type output = DBInstanceAutomatedBackupMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error