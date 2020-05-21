(** "<p>[VPC only] Adds the specified egress rules to a security group for use with a VPC.</p> <p>An outbound rule permits instances to send traffic to the specified IPv4 or IPv6 CIDR address ranges, or to the instances associated with the specified destination security groups.</p> <p>You specify a protocol for each rule (for example, TCP). For the TCP and UDP protocols, you must also specify the destination port or port range. For the ICMP protocol, you must also specify the ICMP type and code. You can use -1 for the type or code to mean all types or all codes.</p> <p>Rule changes are propagated to affected instances as quickly as possible. However, a small delay might occur.</p> <p>For more information about VPC security group limits, see <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/amazon-vpc-limits.html\">Amazon VPC Limits</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AuthorizeSecurityGroupEgressRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    group_id: String.t ;
    ip_permissions: IpPermissionList.t ;
    cidr_ip: String.t option ;
    from_port: Integer.t option ;
    ip_protocol: String.t option ;
    to_port: Integer.t option ;
    source_security_group_name: String.t option ;
    source_security_group_owner_id: String.t option }
  val make :
    ?dry_run:Boolean.t ->
      group_id:String.t ->
        ?ip_permissions:IpPermissionList.t ->
          ?cidr_ip:String.t ->
            ?from_port:Integer.t ->
              ?ip_protocol:String.t ->
                ?to_port:Integer.t ->
                  ?source_security_group_name:String.t ->
                    ?source_security_group_owner_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = AuthorizeSecurityGroupEgressRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error