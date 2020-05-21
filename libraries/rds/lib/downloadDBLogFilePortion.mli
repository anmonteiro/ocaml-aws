(** "<p>Downloads all or a portion of the specified log file, up to 1 MB in size.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DownloadDBLogFilePortionMessage :
sig
  type t =
    {
    d_b_instance_identifier: String.t ;
    log_file_name: String.t ;
    marker: String.t option ;
    number_of_lines: Integer.t option }[@@ocaml.doc "<p/>"]
  val make :
    d_b_instance_identifier:String.t ->
      log_file_name:String.t ->
        ?marker:String.t -> ?number_of_lines:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DownloadDBLogFilePortionDetails = DownloadDBLogFilePortionDetails
type input = DownloadDBLogFilePortionMessage.t
type output = DownloadDBLogFilePortionDetails.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error