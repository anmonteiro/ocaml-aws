(** "<p>Creates an entry (a rule) in a network ACL with the specified rule number. Each network ACL has a set of numbered ingress rules and a separate set of numbered egress rules. When determining whether a packet should be allowed in or out of a subnet associated with the ACL, we process the entries in the ACL according to the rule numbers, in ascending order. Each network ACL has a set of ingress rules and a separate set of egress rules.</p> <p>We recommend that you leave room between the rule numbers (for example, 100, 110, 120, ...), and not number them one right after the other (for example, 101, 102, 103, ...). This makes it easier to add a rule between existing ones without having to renumber the rules.</p> <p>After you add an entry, you can't modify it; you must either replace it, or create an entry and delete the old one.</p> <p>For more information about network ACLs, see <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/VPC_ACLs.html\">Network ACLs</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateNetworkAclEntryRequest :
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
type input = CreateNetworkAclEntryRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error