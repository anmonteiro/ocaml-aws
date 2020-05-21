(** "<p>Returns information about DB snapshots. This API action supports pagination.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeDBSnapshotsMessage :
sig
  type t =
    {
    d_b_instance_identifier: String.t option ;
    d_b_snapshot_identifier: String.t option ;
    snapshot_type: String.t option ;
    filters: FilterList.t ;
    max_records: Integer.t option ;
    marker: String.t option ;
    include_shared: Boolean.t option ;
    include_public: Boolean.t option ;
    dbi_resource_id: String.t option }[@@ocaml.doc "<p/>"]
  val make :
    ?d_b_instance_identifier:String.t ->
      ?d_b_snapshot_identifier:String.t ->
        ?snapshot_type:String.t ->
          ?filters:FilterList.t ->
            ?max_records:Integer.t ->
              ?marker:String.t ->
                ?include_shared:Boolean.t ->
                  ?include_public:Boolean.t ->
                    ?dbi_resource_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DBSnapshotMessage = DBSnapshotMessage
type input = DescribeDBSnapshotsMessage.t
type output = DBSnapshotMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error