(** "<p>Replaces an entry (rule) in a network ACL. For more information, see <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/VPC_ACLs.html\">Network ACLs</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ReplaceNetworkAclEntryRequest :
sig
  type t =
    {
    cidr_block: String.t option ;
    dry_run: Boolean.t option ;
    egress: Boolean.t ;
    icmp_type_code: IcmpTypeCode.t option ;
    ipv6_cidr_block: String.t option ;
    network_acl_id: String.t ;
    port_range: PortRange.t option ;
    protocol: String.t ;
    rule_action: RuleAction.t ;
    rule_number: Integer.t }
  val make :
    ?cidr_block:String.t ->
      ?dry_run:Boolean.t ->
        egress:Boolean.t ->
          ?icmp_type_code:IcmpTypeCode.t ->
            ?ipv6_cidr_block:String.t ->
              network_acl_id:String.t ->
                ?port_range:PortRange.t ->
                  protocol:String.t ->
                    rule_action:RuleAction.t ->
                      rule_number:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = ReplaceNetworkAclEntryRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error