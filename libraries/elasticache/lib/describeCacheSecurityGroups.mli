(** "<p>Returns a list of cache security group descriptions. If a cache security group name is specified, the list contains only the description of that group. This applicable only when you have ElastiCache in Classic setup </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeCacheSecurityGroupsMessage :
sig
  type t =
    {
    cache_security_group_name: String.t option ;
    max_records: Integer.t option ;
    marker: String.t option }[@@ocaml.doc
                               "<p>Represents the input of a <code>DescribeCacheSecurityGroups</code> operation.</p>"]
  val make :
    ?cache_security_group_name:String.t ->
      ?max_records:Integer.t -> ?marker:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CacheSecurityGroupMessage = CacheSecurityGroupMessage
type input = DescribeCacheSecurityGroupsMessage.t
type output = CacheSecurityGroupMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error