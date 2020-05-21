(** "<p>Returns a list of the available DB engines.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeDBEngineVersionsMessage :
sig
  type t =
    {
    engine: String.t option ;
    engine_version: String.t option ;
    d_b_parameter_group_family: String.t option ;
    filters: FilterList.t ;
    max_records: Integer.t option ;
    marker: String.t option ;
    default_only: Boolean.t option ;
    list_supported_character_sets: Boolean.t option ;
    list_supported_timezones: Boolean.t option ;
    include_all: Boolean.t option }
  val make :
    ?engine:String.t ->
      ?engine_version:String.t ->
        ?d_b_parameter_group_family:String.t ->
          ?filters:FilterList.t ->
            ?max_records:Integer.t ->
              ?marker:String.t ->
                ?default_only:Boolean.t ->
                  ?list_supported_character_sets:Boolean.t ->
                    ?list_supported_timezones:Boolean.t ->
                      ?include_all:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DBEngineVersionMessage = DBEngineVersionMessage
type input = DescribeDBEngineVersionsMessage.t
type output = DBEngineVersionMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error