(** "<p>Creates a new cache subnet group.</p> <p>Use this parameter only when you are creating a cluster in an Amazon Virtual Private Cloud (Amazon VPC).</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateCacheSubnetGroupMessage :
sig
  type t =
    {
    cache_subnet_group_name: String.t ;
    cache_subnet_group_description: String.t ;
    subnet_ids: SubnetIdentifierList.t }[@@ocaml.doc
                                          "<p>Represents the input of a <code>CreateCacheSubnetGroup</code> operation.</p>"]
  val make :
    cache_subnet_group_name:String.t ->
      cache_subnet_group_description:String.t ->
        subnet_ids:SubnetIdentifierList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateCacheSubnetGroupResult = CreateCacheSubnetGroupResult
type input = CreateCacheSubnetGroupMessage.t
type output = CreateCacheSubnetGroupResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error