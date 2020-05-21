(** "<p>Unlinks (detaches) a linked EC2-Classic instance from a VPC. After the instance has been unlinked, the VPC security groups are no longer associated with it. An instance is automatically unlinked from a VPC when it's stopped.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DetachClassicLinkVpcRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    instance_id: String.t ;
    vpc_id: String.t }
  val make :
    ?dry_run:Boolean.t ->
      instance_id:String.t -> vpc_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DetachClassicLinkVpcResult = DetachClassicLinkVpcResult
type input = DetachClassicLinkVpcRequest.t
type output = DetachClassicLinkVpcResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error