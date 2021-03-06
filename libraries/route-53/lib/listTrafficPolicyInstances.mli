(** "<p>Gets information about the traffic policy instances that you created by using the current AWS account.</p> <note> <p>After you submit an <code>UpdateTrafficPolicyInstance</code> request, there's a brief delay while Amazon Route 53 creates the resource record sets that are specified in the traffic policy definition. For more information, see the <code>State</code> response element.</p> </note> <p>Route 53 returns a maximum of 100 items in each response. If you have a lot of traffic policy instances, you can use the <code>MaxItems</code> parameter to list them in groups of up to 100.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListTrafficPolicyInstancesRequest :
sig
  type t =
    {
    hosted_zone_id_marker: String.t option ;
    traffic_policy_instance_name_marker: String.t option ;
    traffic_policy_instance_type_marker: RRType.t option ;
    max_items: String.t option }[@@ocaml.doc
                                  "<p>A request to get information about the traffic policy instances that you created by using the current AWS account.</p>"]
  val make :
    ?hosted_zone_id_marker:String.t ->
      ?traffic_policy_instance_name_marker:String.t ->
        ?traffic_policy_instance_type_marker:RRType.t ->
          ?max_items:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ListTrafficPolicyInstancesResponse =
ListTrafficPolicyInstancesResponse
type input = ListTrafficPolicyInstancesRequest.t
type output = ListTrafficPolicyInstancesResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error