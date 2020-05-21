(** "<p>Creates resource record sets in a specified hosted zone based on the settings in a specified traffic policy version. In addition, <code>CreateTrafficPolicyInstance</code> associates the resource record sets with a specified domain name (such as example.com) or subdomain name (such as www.example.com). Amazon Route 53 responds to DNS queries for the domain or subdomain name by using the resource record sets that <code>CreateTrafficPolicyInstance</code> created.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateTrafficPolicyInstanceRequest :
sig
  type t =
    {
    hosted_zone_id: String.t ;
    name: String.t ;
    t_t_l: Long.t ;
    traffic_policy_id: String.t ;
    traffic_policy_version: Integer.t }[@@ocaml.doc
                                         "<p>A complex type that contains information about the resource record sets that you want to create based on a specified traffic policy.</p>"]
  val make :
    hosted_zone_id:String.t ->
      name:String.t ->
        t_t_l:Long.t ->
          traffic_policy_id:String.t ->
            traffic_policy_version:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateTrafficPolicyInstanceResponse =
CreateTrafficPolicyInstanceResponse
type input = CreateTrafficPolicyInstanceRequest.t
type output = CreateTrafficPolicyInstanceResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error