(** "<p>Lets you enable Insights event logging by specifying the Insights selectors that you want to enable on an existing trail. You also use <code>PutInsightSelectors</code> to turn off Insights event logging, by passing an empty list of insight types. In this release, only <code>ApiCallRateInsight</code> is supported as an Insights selector.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PutInsightSelectorsRequest :
sig
  type t = {
    trail_name: String.t ;
    insight_selectors: InsightSelectors.t }
  val make :
    trail_name:String.t -> insight_selectors:InsightSelectors.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module PutInsightSelectorsResponse = PutInsightSelectorsResponse
type input = PutInsightSelectorsRequest.t
type output = PutInsightSelectorsResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error