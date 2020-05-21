(** "<p>Updates the resource record sets in a specified hosted zone that were created based on the settings in a specified traffic policy version.</p> <p>When you update a traffic policy instance, Amazon Route 53 continues to respond to DNS queries for the root resource record set name (such as example.com) while it replaces one group of resource record sets with another. Route 53 performs the following operations:</p> <ol> <li> <p>Route 53 creates a new group of resource record sets based on the specified traffic policy. This is true regardless of how significant the differences are between the existing resource record sets and the new resource record sets. </p> </li> <li> <p>When all of the new resource record sets have been created, Route 53 starts to respond to DNS queries for the root resource record set name (such as example.com) by using the new resource record sets.</p> </li> <li> <p>Route 53 deletes the old group of resource record sets that are associated with the root resource record set name.</p> </li> </ol>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module UpdateTrafficPolicyInstanceRequest :
sig
  type t =
    {
    id: String.t ;
    t_t_l: Long.t ;
    traffic_policy_id: String.t ;
    traffic_policy_version: Integer.t }[@@ocaml.doc
                                         "<p>A complex type that contains information about the resource record sets that you want to update based on a specified traffic policy instance.</p>"]
  val make :
    id:String.t ->
      t_t_l:Long.t ->
        traffic_policy_id:String.t ->
          traffic_policy_version:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module UpdateTrafficPolicyInstanceResponse =
UpdateTrafficPolicyInstanceResponse
type input = UpdateTrafficPolicyInstanceRequest.t
type output = UpdateTrafficPolicyInstanceResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error