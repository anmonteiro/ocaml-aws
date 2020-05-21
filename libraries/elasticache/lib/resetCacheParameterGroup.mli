(** "<p>Modifies the parameters of a cache parameter group to the engine or system default value. You can reset specific parameters by submitting a list of parameter names. To reset the entire cache parameter group, specify the <code>ResetAllParameters</code> and <code>CacheParameterGroupName</code> parameters.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ResetCacheParameterGroupMessage :
sig
  type t =
    {
    cache_parameter_group_name: String.t ;
    reset_all_parameters: Boolean.t option ;
    parameter_name_values: ParameterNameValueList.t }[@@ocaml.doc
                                                       "<p>Represents the input of a <code>ResetCacheParameterGroup</code> operation.</p>"]
  val make :
    cache_parameter_group_name:String.t ->
      ?reset_all_parameters:Boolean.t ->
        ?parameter_name_values:ParameterNameValueList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CacheParameterGroupNameMessage = CacheParameterGroupNameMessage
type input = ResetCacheParameterGroupMessage.t
type output = CacheParameterGroupNameMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error