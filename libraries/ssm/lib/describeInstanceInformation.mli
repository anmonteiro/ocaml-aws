(** "<p>Describes one or more of your instances. You can use this to get information about instances like the operating system platform, the SSM Agent version (Linux), status etc. If you specify one or more instance IDs, it returns information for those instances. If you do not specify instance IDs, it returns information for all your instances. If you specify an instance ID that is not valid or an instance that you do not own, you receive an error. </p> <note> <p>The IamRole field for this API action is the Amazon Identity and Access Management (IAM) role assigned to on-premises instances. This call does not return the IAM role for Amazon EC2 instances.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeInstanceInformationRequest :
sig
  type t =
    {
    instance_information_filter_list: InstanceInformationFilterList.t ;
    filters: InstanceInformationStringFilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    ?instance_information_filter_list:InstanceInformationFilterList.t ->
      ?filters:InstanceInformationStringFilterList.t ->
        ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module DescribeInstanceInformationResult = DescribeInstanceInformationResult
type input = DescribeInstanceInformationRequest.t
type output = DescribeInstanceInformationResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error