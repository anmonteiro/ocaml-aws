(** "<p>Returns a list of DB log files for the DB instance.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeDBLogFilesMessage :
sig
  type t =
    {
    d_b_instance_identifier: String.t ;
    filename_contains: String.t option ;
    file_last_written: Long.t option ;
    file_size: Long.t option ;
    filters: FilterList.t ;
    max_records: Integer.t option ;
    marker: String.t option }[@@ocaml.doc "<p/>"]
  val make :
    d_b_instance_identifier:String.t ->
      ?filename_contains:String.t ->
        ?file_last_written:Long.t ->
          ?file_size:Long.t ->
            ?filters:FilterList.t ->
              ?max_records:Integer.t -> ?marker:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeDBLogFilesResponse = DescribeDBLogFilesResponse
type input = DescribeDBLogFilesMessage.t
type output = DescribeDBLogFilesResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error