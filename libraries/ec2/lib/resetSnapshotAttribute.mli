(** "<p>Resets permission settings for the specified snapshot.</p> <p>For more information about modifying snapshot permissions, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-modifying-snapshot-permissions.html\">Sharing Snapshots</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ResetSnapshotAttributeRequest :
sig
  type t =
    {
    attribute: SnapshotAttributeName.t ;
    snapshot_id: String.t ;
    dry_run: Boolean.t option }
  val make :
    attribute:SnapshotAttributeName.t ->
      snapshot_id:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = ResetSnapshotAttributeRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error