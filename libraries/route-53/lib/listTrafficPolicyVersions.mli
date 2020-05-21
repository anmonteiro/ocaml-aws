(** "<p>Gets information about all of the versions for a specified traffic policy.</p> <p>Traffic policy versions are listed in numerical order by <code>VersionNumber</code>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListTrafficPolicyVersionsRequest :
sig
  type t =
    {
    id: String.t ;
    traffic_policy_version_marker: String.t option ;
    max_items: String.t option }[@@ocaml.doc
                                  "<p>A complex type that contains the information about the request to list your traffic policies.</p>"]
  val make :
    id:String.t ->
      ?traffic_policy_version_marker:String.t ->
        ?max_items:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ListTrafficPolicyVersionsResponse = ListTrafficPolicyVersionsResponse
type input = ListTrafficPolicyVersionsRequest.t
type output = ListTrafficPolicyVersionsResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error