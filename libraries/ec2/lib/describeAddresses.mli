(** "<p>Describes the specified Elastic IP addresses or all of your Elastic IP addresses.</p> <p>An Elastic IP address is for use in either the EC2-Classic platform or in a VPC. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html\">Elastic IP Addresses</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeAddressesRequest :
sig
  type t =
    {
    filters: FilterList.t ;
    public_ips: PublicIpStringList.t ;
    allocation_ids: AllocationIdList.t ;
    dry_run: Boolean.t option }
  val make :
    ?filters:FilterList.t ->
      ?public_ips:PublicIpStringList.t ->
        ?allocation_ids:AllocationIdList.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeAddressesResult = DescribeAddressesResult
type input = DescribeAddressesRequest.t
type output = DescribeAddressesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error