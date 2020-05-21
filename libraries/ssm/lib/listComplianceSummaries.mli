(** "<p>Returns a summary count of compliant and non-compliant resources for a compliance type. For example, this call can return State Manager associations, patches, or custom compliance types according to the filter criteria that you specify. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListComplianceSummariesRequest :
sig
  type t =
    {
    filters: ComplianceStringFilterList.t ;
    next_token: String.t option ;
    max_results: Integer.t option }
  val make :
    ?filters:ComplianceStringFilterList.t ->
      ?next_token:String.t -> ?max_results:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module ListComplianceSummariesResult = ListComplianceSummariesResult
type input = ListComplianceSummariesRequest.t
type output = ListComplianceSummariesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error