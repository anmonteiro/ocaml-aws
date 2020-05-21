(** "<p>Creates a security group.</p> <p>A security group acts as a virtual firewall for your instance to control inbound and outbound traffic. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-network-security.html\">Amazon EC2 Security Groups</a> in the <i>Amazon Elastic Compute Cloud User Guide</i> and <a href=\"https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_SecurityGroups.html\">Security Groups for Your VPC</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p> <p>When you create a security group, you specify a friendly name of your choice. You can have a security group for use in EC2-Classic with the same name as a security group for use in a VPC. However, you can't have two security groups for use in EC2-Classic with the same name or two security groups for use in a VPC with the same name.</p> <p>You have a default security group for use in EC2-Classic and a default security group for use in your VPC. If you don't specify a security group when you launch an instance, the instance is launched into the appropriate default security group. A default security group includes a default rule that grants instances unrestricted network access to each other.</p> <p>You can add or remove rules from your security groups using <a>AuthorizeSecurityGroupIngress</a>, <a>AuthorizeSecurityGroupEgress</a>, <a>RevokeSecurityGroupIngress</a>, and <a>RevokeSecurityGroupEgress</a>.</p> <p>For more information about VPC security group limits, see <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/amazon-vpc-limits.html\">Amazon VPC Limits</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateSecurityGroupRequest :
sig
  type t =
    {
    description: String.t ;
    group_name: String.t ;
    vpc_id: String.t option ;
    dry_run: Boolean.t option }
  val make :
    description:String.t ->
      group_name:String.t ->
        ?vpc_id:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateSecurityGroupResult = CreateSecurityGroupResult
type input = CreateSecurityGroupRequest.t
type output = CreateSecurityGroupResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error