(** "<p>Adds the specified ingress rules to a security group.</p> <p>An inbound rule permits instances to receive traffic from the specified IPv4 or IPv6 CIDR address ranges, or from the instances associated with the specified destination security groups.</p> <p>You specify a protocol for each rule (for example, TCP). For TCP and UDP, you must also specify the destination port or port range. For ICMP/ICMPv6, you must also specify the ICMP/ICMPv6 type and code. You can use -1 to mean all types or all codes.</p> <p>Rule changes are propagated to instances within the security group as quickly as possible. However, a small delay might occur.</p> <p>For more information about VPC security group limits, see <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/amazon-vpc-limits.html\">Amazon VPC Limits</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AuthorizeSecurityGroupIngressRequest :
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
type input = AuthorizeSecurityGroupIngressRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error