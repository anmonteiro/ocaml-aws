(** "<p>Describes the available option groups.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeOptionGroupsMessage :
sig
  type t =
    {
    option_group_name: String.t option ;
    filters: FilterList.t ;
    marker: String.t option ;
    max_records: Integer.t option ;
    engine_name: String.t option ;
    major_engine_version: String.t option }[@@ocaml.doc "<p/>"]
  val make :
    ?option_group_name:String.t ->
      ?filters:FilterList.t ->
        ?marker:String.t ->
          ?max_records:Integer.t ->
            ?engine_name:String.t ->
              ?major_engine_version:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module OptionGroups = OptionGroups
type input = DescribeOptionGroupsMessage.t
type output = OptionGroups.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error