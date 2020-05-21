(** "<p>Returns a resource-level summary count. The summary includes information about compliant and non-compliant statuses and detailed compliance-item severity counts, according to the filter criteria you specify.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListResourceComplianceSummariesRequest :
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
module ListResourceComplianceSummariesResult =
ListResourceComplianceSummariesResult
type input = ListResourceComplianceSummariesRequest.t
type output = ListResourceComplianceSummariesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error