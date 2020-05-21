(** "<p>Returns a list of the available cache engines and their versions.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeCacheEngineVersionsMessage :
sig
  type t =
    {
    engine: String.t option ;
    engine_version: String.t option ;
    cache_parameter_group_family: String.t option ;
    max_records: Integer.t option ;
    marker: String.t option ;
    default_only: Boolean.t option }[@@ocaml.doc
                                      "<p>Represents the input of a <code>DescribeCacheEngineVersions</code> operation.</p>"]
  val make :
    ?engine:String.t ->
      ?engine_version:String.t ->
        ?cache_parameter_group_family:String.t ->
          ?max_records:Integer.t ->
            ?marker:String.t -> ?default_only:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CacheEngineVersionMessage = CacheEngineVersionMessage
type input = DescribeCacheEngineVersionsMessage.t
type output = CacheEngineVersionMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error