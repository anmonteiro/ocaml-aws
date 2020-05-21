(** "<p>Modifies the parameters of a cache parameter group. You can modify up to 20 parameters in a single request by submitting a list parameter name and value pairs.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyCacheParameterGroupMessage :
sig
  type t =
    {
    cache_parameter_group_name: String.t ;
    parameter_name_values: ParameterNameValueList.t }[@@ocaml.doc
                                                       "<p>Represents the input of a <code>ModifyCacheParameterGroup</code> operation.</p>"]
  val make :
    cache_parameter_group_name:String.t ->
      parameter_name_values:ParameterNameValueList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CacheParameterGroupNameMessage = CacheParameterGroupNameMessage
type input = ModifyCacheParameterGroupMessage.t
type output = CacheParameterGroupNameMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error