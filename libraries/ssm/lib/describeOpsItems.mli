(** "<p>Query a set of OpsItems. You must have permission in AWS Identity and Access Management (IAM) to query a list of OpsItems. For more information, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-getting-started.html\">Getting Started with OpsCenter</a> in the <i>AWS Systems Manager User Guide</i>.</p> <p>Operations engineers and IT professionals use OpsCenter to view, investigate, and remediate operational issues impacting the performance and health of their AWS resources. For more information, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter.html\">AWS Systems Manager OpsCenter</a> in the <i>AWS Systems Manager User Guide</i>. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeOpsItemsRequest :
sig
  type t =
    {
    ops_item_filters: OpsItemFilters.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    ?ops_item_filters:OpsItemFilters.t ->
      ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module DescribeOpsItemsResponse = DescribeOpsItemsResponse
type input = DescribeOpsItemsRequest.t
type output = DescribeOpsItemsResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error