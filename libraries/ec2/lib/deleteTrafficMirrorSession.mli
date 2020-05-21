(** "<p>Deletes the specified Traffic Mirror session.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteTrafficMirrorSessionRequest :
sig
  type t = {
    traffic_mirror_session_id: String.t ;
    dry_run: Boolean.t option }
  val make :
    traffic_mirror_session_id:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DeleteTrafficMirrorSessionResult = DeleteTrafficMirrorSessionResult
type input = DeleteTrafficMirrorSessionRequest.t
type output = DeleteTrafficMirrorSessionResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error