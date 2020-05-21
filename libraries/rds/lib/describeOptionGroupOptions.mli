(** "<p>Describes all available options.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeOptionGroupOptionsMessage :
sig
  type t =
    {
    engine_name: String.t ;
    major_engine_version: String.t option ;
    filters: FilterList.t ;
    max_records: Integer.t option ;
    marker: String.t option }[@@ocaml.doc "<p/>"]
  val make :
    engine_name:String.t ->
      ?major_engine_version:String.t ->
        ?filters:FilterList.t ->
          ?max_records:Integer.t -> ?marker:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module OptionGroupOptionsMessage = OptionGroupOptionsMessage
type input = DescribeOptionGroupOptionsMessage.t
type output = OptionGroupOptionsMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error