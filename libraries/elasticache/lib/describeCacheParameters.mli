(** "<p>Returns the detailed parameter list for a particular cache parameter group.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeCacheParametersMessage :
sig
  type t =
    {
    cache_parameter_group_name: String.t ;
    source: String.t option ;
    max_records: Integer.t option ;
    marker: String.t option }[@@ocaml.doc
                               "<p>Represents the input of a <code>DescribeCacheParameters</code> operation.</p>"]
  val make :
    cache_parameter_group_name:String.t ->
      ?source:String.t ->
        ?max_records:Integer.t -> ?marker:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CacheParameterGroupDetails = CacheParameterGroupDetails
type input = DescribeCacheParametersMessage.t
type output = CacheParameterGroupDetails.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error