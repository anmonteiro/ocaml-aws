(** "<p>Describes the specified security groups or all of your security groups.</p> <p>A security group is for use with instances either in the EC2-Classic platform or in a specific VPC. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-network-security.html\">Amazon EC2 Security Groups</a> in the <i>Amazon Elastic Compute Cloud User Guide</i> and <a href=\"https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_SecurityGroups.html\">Security Groups for Your VPC</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeSecurityGroupsRequest :
sig
  type t =
    {
    filters: FilterList.t ;
    group_ids: GroupIdStringList.t ;
    group_names: GroupNameStringList.t ;
    dry_run: Boolean.t option ;
    next_token: String.t option ;
    max_results: Integer.t option }
  val make :
    ?filters:FilterList.t ->
      ?group_ids:GroupIdStringList.t ->
        ?group_names:GroupNameStringList.t ->
          ?dry_run:Boolean.t ->
            ?next_token:String.t -> ?max_results:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeSecurityGroupsResult = DescribeSecurityGroupsResult
type input = DescribeSecurityGroupsRequest.t
type output = DescribeSecurityGroupsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error