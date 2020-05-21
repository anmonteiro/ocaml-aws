(** "<p>Gets information about the latest version for every traffic policy that is associated with the current AWS account. Policies are listed in the order that they were created in. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListTrafficPoliciesRequest :
sig
  type t =
    {
    traffic_policy_id_marker: String.t option ;
    max_items: String.t option }[@@ocaml.doc
                                  "<p>A complex type that contains the information about the request to list the traffic policies that are associated with the current AWS account.</p>"]
  val make :
    ?traffic_policy_id_marker:String.t -> ?max_items:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ListTrafficPoliciesResponse = ListTrafficPoliciesResponse
type input = ListTrafficPoliciesRequest.t
type output = ListTrafficPoliciesResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error