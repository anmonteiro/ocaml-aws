(** "<p>Deletes the specified Traffic Mirror filter.</p> <p>You cannot delete a Traffic Mirror filter that is in use by a Traffic Mirror session.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteTrafficMirrorFilterRequest :
sig
  type t = {
    traffic_mirror_filter_id: String.t ;
    dry_run: Boolean.t option }
  val make :
    traffic_mirror_filter_id:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DeleteTrafficMirrorFilterResult = DeleteTrafficMirrorFilterResult
type input = DeleteTrafficMirrorFilterRequest.t
type output = DeleteTrafficMirrorFilterResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error