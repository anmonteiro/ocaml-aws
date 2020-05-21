(** "<p>For a specified resource ID, this API action returns a list of compliance statuses for different resource types. Currently, you can only specify one resource ID per call. List results depend on the criteria specified in the filter. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListComplianceItemsRequest :
sig
  type t =
    {
    filters: ComplianceStringFilterList.t ;
    resource_ids: ComplianceResourceIdList.t ;
    resource_types: ComplianceResourceTypeList.t ;
    next_token: String.t option ;
    max_results: Integer.t option }
  val make :
    ?filters:ComplianceStringFilterList.t ->
      ?resource_ids:ComplianceResourceIdList.t ->
        ?resource_types:ComplianceResourceTypeList.t ->
          ?next_token:String.t -> ?max_results:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module ListComplianceItemsResult = ListComplianceItemsResult
type input = ListComplianceItemsRequest.t
type output = ListComplianceItemsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error