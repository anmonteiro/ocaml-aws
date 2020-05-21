(** "<p>Backtracks a DB cluster to a specific time, without creating a new DB cluster.</p> <p>For more information on backtracking, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Managing.Backtrack.html\"> Backtracking an Aurora DB Cluster</a> in the <i>Amazon Aurora User Guide.</i> </p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module BacktrackDBClusterMessage :
sig
  type t =
    {
    d_b_cluster_identifier: String.t ;
    backtrack_to: DateTime.t ;
    force: Boolean.t option ;
    use_earliest_time_on_point_in_time_unavailable: Boolean.t option }
  [@@ocaml.doc "<p/>"]
  val make :
    d_b_cluster_identifier:String.t ->
      backtrack_to:DateTime.t ->
        ?force:Boolean.t ->
          ?use_earliest_time_on_point_in_time_unavailable:Boolean.t ->
            unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DBClusterBacktrack = DBClusterBacktrack
type input = BacktrackDBClusterMessage.t
type output = DBClusterBacktrack.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error