(** "<p>Adds an attribute and values to, or removes an attribute and values from, a manual DB snapshot.</p> <p>To share a manual DB snapshot with other AWS accounts, specify <code>restore</code> as the <code>AttributeName</code> and use the <code>ValuesToAdd</code> parameter to add a list of IDs of the AWS accounts that are authorized to restore the manual DB snapshot. Uses the value <code>all</code> to make the manual DB snapshot public, which means it can be copied or restored by all AWS accounts. Do not add the <code>all</code> value for any manual DB snapshots that contain private information that you don't want available to all AWS accounts. If the manual DB snapshot is encrypted, it can be shared, but only by specifying a list of authorized AWS account IDs for the <code>ValuesToAdd</code> parameter. You can't use <code>all</code> as a value for that parameter in this case.</p> <p>To view which AWS accounts have access to copy or restore a manual DB snapshot, or whether a manual DB snapshot public or private, use the <code>DescribeDBSnapshotAttributes</code> API action.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyDBSnapshotAttributeMessage :
sig
  type t =
    {
    d_b_snapshot_identifier: String.t ;
    attribute_name: String.t ;
    values_to_add: AttributeValueList.t ;
    values_to_remove: AttributeValueList.t }[@@ocaml.doc "<p/>"]
  val make :
    d_b_snapshot_identifier:String.t ->
      attribute_name:String.t ->
        ?values_to_add:AttributeValueList.t ->
          ?values_to_remove:AttributeValueList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyDBSnapshotAttributeResult = ModifyDBSnapshotAttributeResult
type input = ModifyDBSnapshotAttributeMessage.t
type output = ModifyDBSnapshotAttributeResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error