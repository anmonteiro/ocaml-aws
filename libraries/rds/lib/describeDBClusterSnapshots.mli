(** "<p>Returns information about DB cluster snapshots. This API action supports pagination.</p> <p>For more information on Amazon Aurora, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html\"> What Is Amazon Aurora?</a> in the <i>Amazon Aurora User Guide.</i> </p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeDBClusterSnapshotsMessage :
sig
  type t =
    {
    d_b_cluster_identifier: String.t option ;
    d_b_cluster_snapshot_identifier: String.t option ;
    snapshot_type: String.t option ;
    filters: FilterList.t ;
    max_records: Integer.t option ;
    marker: String.t option ;
    include_shared: Boolean.t option ;
    include_public: Boolean.t option }[@@ocaml.doc "<p/>"]
  val make :
    ?d_b_cluster_identifier:String.t ->
      ?d_b_cluster_snapshot_identifier:String.t ->
        ?snapshot_type:String.t ->
          ?filters:FilterList.t ->
            ?max_records:Integer.t ->
              ?marker:String.t ->
                ?include_shared:Boolean.t ->
                  ?include_public:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DBClusterSnapshotMessage = DBClusterSnapshotMessage
type input = DescribeDBClusterSnapshotsMessage.t
type output = DBClusterSnapshotMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error