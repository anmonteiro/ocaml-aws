(** "<p>Returns a list of cache subnet group descriptions. If a subnet group name is specified, the list contains only the description of that group. This is applicable only when you have ElastiCache in VPC setup. All ElastiCache clusters now launch in VPC by default. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeCacheSubnetGroupsMessage :
sig
  type t =
    {
    cache_subnet_group_name: String.t option ;
    max_records: Integer.t option ;
    marker: String.t option }[@@ocaml.doc
                               "<p>Represents the input of a <code>DescribeCacheSubnetGroups</code> operation.</p>"]
  val make :
    ?cache_subnet_group_name:String.t ->
      ?max_records:Integer.t -> ?marker:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CacheSubnetGroupMessage = CacheSubnetGroupMessage
type input = DescribeCacheSubnetGroupsMessage.t
type output = CacheSubnetGroupMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error