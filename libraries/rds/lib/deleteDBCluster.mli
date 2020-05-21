(** "<p>The DeleteDBCluster action deletes a previously provisioned DB cluster. When you delete a DB cluster, all automated backups for that DB cluster are deleted and can't be recovered. Manual DB cluster snapshots of the specified DB cluster are not deleted.</p> <p/> <p>For more information on Amazon Aurora, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html\"> What Is Amazon Aurora?</a> in the <i>Amazon Aurora User Guide.</i> </p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteDBClusterMessage :
sig
  type t =
    {
    d_b_cluster_identifier: String.t ;
    skip_final_snapshot: Boolean.t option ;
    final_d_b_snapshot_identifier: String.t option }[@@ocaml.doc "<p/>"]
  val make :
    d_b_cluster_identifier:String.t ->
      ?skip_final_snapshot:Boolean.t ->
        ?final_d_b_snapshot_identifier:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DeleteDBClusterResult = DeleteDBClusterResult
type input = DeleteDBClusterMessage.t
type output = DeleteDBClusterResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error