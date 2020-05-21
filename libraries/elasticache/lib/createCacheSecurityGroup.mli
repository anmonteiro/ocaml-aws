(** "<p>Creates a new cache security group. Use a cache security group to control access to one or more clusters.</p> <p>Cache security groups are only used when you are creating a cluster outside of an Amazon Virtual Private Cloud (Amazon VPC). If you are creating a cluster inside of a VPC, use a cache subnet group instead. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonElastiCache/latest/APIReference/API_CreateCacheSubnetGroup.html\">CreateCacheSubnetGroup</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateCacheSecurityGroupMessage :
sig
  type t = {
    cache_security_group_name: String.t ;
    description: String.t }[@@ocaml.doc
                             "<p>Represents the input of a <code>CreateCacheSecurityGroup</code> operation.</p>"]
  val make :
    cache_security_group_name:String.t -> description:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateCacheSecurityGroupResult = CreateCacheSecurityGroupResult
type input = CreateCacheSecurityGroupMessage.t
type output = CreateCacheSecurityGroupResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error