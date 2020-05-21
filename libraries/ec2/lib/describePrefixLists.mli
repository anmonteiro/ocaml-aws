(** "<p>Describes available AWS services in a prefix list format, which includes the prefix list name and prefix list ID of the service and the IP address range for the service. A prefix list ID is required for creating an outbound security group rule that allows traffic from a VPC to access an AWS service through a gateway VPC endpoint. Currently, the services that support this action are Amazon S3 and Amazon DynamoDB.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribePrefixListsRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    filters: FilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option ;
    prefix_list_ids: ValueStringList.t }
  val make :
    ?dry_run:Boolean.t ->
      ?filters:FilterList.t ->
        ?max_results:Integer.t ->
          ?next_token:String.t ->
            ?prefix_list_ids:ValueStringList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribePrefixListsResult = DescribePrefixListsResult
type input = DescribePrefixListsRequest.t
type output = DescribePrefixListsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error