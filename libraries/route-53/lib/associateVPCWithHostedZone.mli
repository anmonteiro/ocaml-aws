(** "<p>Associates an Amazon VPC with a private hosted zone. </p> <important> <p>To perform the association, the VPC and the private hosted zone must already exist. You can't convert a public hosted zone into a private hosted zone.</p> </important> <note> <p>If you want to associate a VPC that was created by using one AWS account with a private hosted zone that was created by using a different account, the AWS account that created the private hosted zone must first submit a <code>CreateVPCAssociationAuthorization</code> request. Then the account that created the VPC must submit an <code>AssociateVPCWithHostedZone</code> request.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AssociateVPCWithHostedZoneRequest :
sig
  type t =
    {
    hosted_zone_id: String.t ;
    v_p_c: VPC.t ;
    comment: String.t option }[@@ocaml.doc
                                "<p>A complex type that contains information about the request to associate a VPC with a private hosted zone.</p>"]
  val make :
    hosted_zone_id:String.t -> v_p_c:VPC.t -> ?comment:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module AssociateVPCWithHostedZoneResponse =
AssociateVPCWithHostedZoneResponse
type input = AssociateVPCWithHostedZoneRequest.t
type output = AssociateVPCWithHostedZoneResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error