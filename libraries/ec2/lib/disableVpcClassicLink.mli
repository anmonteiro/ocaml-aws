(** "<p>Disables ClassicLink for a VPC. You cannot disable ClassicLink for a VPC that has EC2-Classic instances linked to it.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DisableVpcClassicLinkRequest :
sig
  type t = {
    dry_run: Boolean.t option ;
    vpc_id: String.t }
  val make : ?dry_run:Boolean.t -> vpc_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DisableVpcClassicLinkResult = DisableVpcClassicLinkResult
type input = DisableVpcClassicLinkRequest.t
type output = DisableVpcClassicLinkResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error