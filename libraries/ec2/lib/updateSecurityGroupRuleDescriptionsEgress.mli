(** "<p>[VPC only] Updates the description of an egress (outbound) security group rule. You can replace an existing description, or add a description to a rule that did not have one previously.</p> <p>You specify the description as part of the IP permissions structure. You can remove a description for a security group rule by omitting the description parameter in the request.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module UpdateSecurityGroupRuleDescriptionsEgressRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    group_id: String.t option ;
    group_name: String.t option ;
    ip_permissions: IpPermissionList.t }
  val make :
    ?dry_run:Boolean.t ->
      ?group_id:String.t ->
        ?group_name:String.t ->
          ip_permissions:IpPermissionList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module UpdateSecurityGroupRuleDescriptionsEgressResult =
UpdateSecurityGroupRuleDescriptionsEgressResult
type input = UpdateSecurityGroupRuleDescriptionsEgressRequest.t
type output = UpdateSecurityGroupRuleDescriptionsEgressResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error