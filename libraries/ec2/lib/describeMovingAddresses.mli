(** "<p>Describes your Elastic IP addresses that are being moved to the EC2-VPC platform, or that are being restored to the EC2-Classic platform. This request does not return information about any other Elastic IP addresses in your account.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeMovingAddressesRequest :
sig
  type t =
    {
    filters: FilterList.t ;
    dry_run: Boolean.t option ;
    max_results: Integer.t option ;
    next_token: String.t option ;
    public_ips: ValueStringList.t }
  val make :
    ?filters:FilterList.t ->
      ?dry_run:Boolean.t ->
        ?max_results:Integer.t ->
          ?next_token:String.t -> ?public_ips:ValueStringList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeMovingAddressesResult = DescribeMovingAddressesResult
type input = DescribeMovingAddressesRequest.t
type output = DescribeMovingAddressesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error