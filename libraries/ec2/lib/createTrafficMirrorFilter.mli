(** "<p>Creates a Traffic Mirror filter.</p> <p>A Traffic Mirror filter is a set of rules that defines the traffic to mirror.</p> <p>By default, no traffic is mirrored. To mirror traffic, use <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateTrafficMirrorFilterRule.htm\">CreateTrafficMirrorFilterRule</a> to add Traffic Mirror rules to the filter. The rules you add define what traffic gets mirrored. You can also use <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ModifyTrafficMirrorFilterNetworkServices.html\">ModifyTrafficMirrorFilterNetworkServices</a> to mirror supported network services.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateTrafficMirrorFilterRequest :
sig
  type t =
    {
    description: String.t option ;
    tag_specifications: TagSpecificationList.t ;
    dry_run: Boolean.t option ;
    client_token: String.t option }
  val make :
    ?description:String.t ->
      ?tag_specifications:TagSpecificationList.t ->
        ?dry_run:Boolean.t -> ?client_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateTrafficMirrorFilterResult = CreateTrafficMirrorFilterResult
type input = CreateTrafficMirrorFilterRequest.t
type output = CreateTrafficMirrorFilterResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error