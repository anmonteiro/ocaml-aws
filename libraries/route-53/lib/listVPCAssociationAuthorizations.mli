(** "<p>Gets a list of the VPCs that were created by other accounts and that can be associated with a specified hosted zone because you've submitted one or more <code>CreateVPCAssociationAuthorization</code> requests. </p> <p>The response includes a <code>VPCs</code> element with a <code>VPC</code> child element for each VPC that can be associated with the hosted zone.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListVPCAssociationAuthorizationsRequest :
sig
  type t =
    {
    hosted_zone_id: String.t ;
    next_token: String.t option ;
    max_results: String.t option }[@@ocaml.doc
                                    "<p>A complex type that contains information about that can be associated with your hosted zone.</p>"]
  val make :
    hosted_zone_id:String.t ->
      ?next_token:String.t -> ?max_results:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ListVPCAssociationAuthorizationsResponse =
ListVPCAssociationAuthorizationsResponse
type input = ListVPCAssociationAuthorizationsRequest.t
type output = ListVPCAssociationAuthorizationsResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error