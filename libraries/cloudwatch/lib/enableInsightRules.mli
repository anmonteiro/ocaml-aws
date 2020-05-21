(** "<p>Enables the specified Contributor Insights rules. When rules are enabled, they immediately begin analyzing log data.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module EnableInsightRulesInput :
sig
  type t = {
    rule_names: InsightRuleNames.t }
  val make : rule_names:InsightRuleNames.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module EnableInsightRulesOutput = EnableInsightRulesOutput
type input = EnableInsightRulesInput.t
type output = EnableInsightRulesOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error