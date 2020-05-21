(** "<p>Adds an attribute and values to, or removes an attribute and values from, a manual DB cluster snapshot.</p> <p>To share a manual DB cluster snapshot with other AWS accounts, specify <code>restore</code> as the <code>AttributeName</code> and use the <code>ValuesToAdd</code> parameter to add a list of IDs of the AWS accounts that are authorized to restore the manual DB cluster snapshot. Use the value <code>all</code> to make the manual DB cluster snapshot public, which means that it can be copied or restored by all AWS accounts. Do not add the <code>all</code> value for any manual DB cluster snapshots that contain private information that you don't want available to all AWS accounts. If a manual DB cluster snapshot is encrypted, it can be shared, but only by specifying a list of authorized AWS account IDs for the <code>ValuesToAdd</code> parameter. You can't use <code>all</code> as a value for that parameter in this case.</p> <p>To view which AWS accounts have access to copy or restore a manual DB cluster snapshot, or whether a manual DB cluster snapshot public or private, use the <code>DescribeDBClusterSnapshotAttributes</code> API action.</p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyDBClusterSnapshotAttributeMessage :
sig
  type t =
    {
    d_b_cluster_snapshot_identifier: String.t ;
    attribute_name: String.t ;
    values_to_add: AttributeValueList.t ;
    values_to_remove: AttributeValueList.t }[@@ocaml.doc "<p/>"]
  val make :
    d_b_cluster_snapshot_identifier:String.t ->
      attribute_name:String.t ->
        ?values_to_add:AttributeValueList.t ->
          ?values_to_remove:AttributeValueList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyDBClusterSnapshotAttributeResult =
ModifyDBClusterSnapshotAttributeResult
type input = ModifyDBClusterSnapshotAttributeMessage.t
type output = ModifyDBClusterSnapshotAttributeResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error