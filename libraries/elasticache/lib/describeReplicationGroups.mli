(** "<p>Returns information about a particular replication group. If no identifier is specified, <code>DescribeReplicationGroups</code> returns information about all replication groups.</p> <note> <p>This operation is valid for Redis only.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeReplicationGroupsMessage :
sig
  type t =
    {
    replication_group_id: String.t option ;
    max_records: Integer.t option ;
    marker: String.t option }[@@ocaml.doc
                               "<p>Represents the input of a <code>DescribeReplicationGroups</code> operation.</p>"]
  val make :
    ?replication_group_id:String.t ->
      ?max_records:Integer.t -> ?marker:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ReplicationGroupMessage = ReplicationGroupMessage
type input = DescribeReplicationGroupsMessage.t
type output = ReplicationGroupMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error