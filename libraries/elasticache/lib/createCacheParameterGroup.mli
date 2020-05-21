(** "<p>Creates a new Amazon ElastiCache cache parameter group. An ElastiCache cache parameter group is a collection of parameters and their values that are applied to all of the nodes in any cluster or replication group using the CacheParameterGroup.</p> <p>A newly created CacheParameterGroup is an exact duplicate of the default parameter group for the CacheParameterGroupFamily. To customize the newly created CacheParameterGroup you can change the values of specific parameters. For more information, see:</p> <ul> <li> <p> <a href=\"https://docs.aws.amazon.com/AmazonElastiCache/latest/APIReference/API_ModifyCacheParameterGroup.html\">ModifyCacheParameterGroup</a> in the ElastiCache API Reference.</p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/ParameterGroups.html\">Parameters and Parameter Groups</a> in the ElastiCache User Guide.</p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateCacheParameterGroupMessage :
sig
  type t =
    {
    cache_parameter_group_name: String.t ;
    cache_parameter_group_family: String.t ;
    description: String.t }[@@ocaml.doc
                             "<p>Represents the input of a <code>CreateCacheParameterGroup</code> operation.</p>"]
  val make :
    cache_parameter_group_name:String.t ->
      cache_parameter_group_family:String.t ->
        description:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateCacheParameterGroupResult = CreateCacheParameterGroupResult
type input = CreateCacheParameterGroupMessage.t
type output = CreateCacheParameterGroupResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error