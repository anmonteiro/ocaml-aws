(** "<p>Links an EC2-Classic instance to a ClassicLink-enabled VPC through one or more of the VPC's security groups. You cannot link an EC2-Classic instance to more than one VPC at a time. You can only link an instance that's in the <code>running</code> state. An instance is automatically unlinked from a VPC when it's stopped - you can link it to the VPC again when you restart it.</p> <p>After you've linked an instance, you cannot change the VPC security groups that are associated with it. To change the security groups, you must first unlink the instance, and then link it again.</p> <p>Linking your instance to a VPC is sometimes referred to as <i>attaching</i> your instance.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AttachClassicLinkVpcRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    groups: GroupIdStringList.t ;
    instance_id: String.t ;
    vpc_id: String.t }
  val make :
    ?dry_run:Boolean.t ->
      groups:GroupIdStringList.t ->
        instance_id:String.t -> vpc_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module AttachClassicLinkVpcResult = AttachClassicLinkVpcResult
type input = AttachClassicLinkVpcRequest.t
type output = AttachClassicLinkVpcResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error