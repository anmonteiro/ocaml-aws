(** "<p>Removes the specified ingress rules from a security group. To remove a rule, the values that you specify (for example, ports) must match the existing rule's values exactly.</p> <note> <p>[EC2-Classic only] If the values you specify do not match the existing rule's values, no error is returned. Use <a>DescribeSecurityGroups</a> to verify that the rule has been removed.</p> </note> <p>Each rule consists of the protocol and the CIDR range or source security group. For the TCP and UDP protocols, you must also specify the destination port or range of ports. For the ICMP protocol, you must also specify the ICMP type and code. If the security group rule has a description, you do not have to specify the description to revoke the rule.</p> <p>Rule changes are propagated to instances within the security group as quickly as possible. However, a small delay might occur.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RevokeSecurityGroupIngressRequest :
sig
  type t =
    {
    cidr_ip: String.t option ;
    from_port: Integer.t option ;
    group_id: String.t option ;
    group_name: String.t option ;
    ip_permissions: IpPermissionList.t ;
    ip_protocol: String.t option ;
    source_security_group_name: String.t option ;
    source_security_group_owner_id: String.t option ;
    to_port: Integer.t option ;
    dry_run: Boolean.t option }
  val make :
    ?cidr_ip:String.t ->
      ?from_port:Integer.t ->
        ?group_id:String.t ->
          ?group_name:String.t ->
            ?ip_permissions:IpPermissionList.t ->
              ?ip_protocol:String.t ->
                ?source_security_group_name:String.t ->
                  ?source_security_group_owner_id:String.t ->
                    ?to_port:Integer.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = RevokeSecurityGroupIngressRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error