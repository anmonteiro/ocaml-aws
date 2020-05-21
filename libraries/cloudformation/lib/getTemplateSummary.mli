(** "<p>Returns information about a new or existing template. The <code>GetTemplateSummary</code> action is useful for viewing parameter information, such as default parameter values and parameter types, before you create or update a stack or stack set.</p> <p>You can use the <code>GetTemplateSummary</code> action when you submit a template, or you can get template information for a stack set, or a running or deleted stack.</p> <p>For deleted stacks, <code>GetTemplateSummary</code> returns the template information for up to 90 days after the stack has been deleted. If the template does not exist, a <code>ValidationError</code> is returned.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetTemplateSummaryInput :
sig
  type t =
    {
    template_body: String.t option ;
    template_u_r_l: String.t option ;
    stack_name: String.t option ;
    stack_set_name: String.t option }[@@ocaml.doc
                                       "<p>The input for the <a>GetTemplateSummary</a> action.</p>"]
  val make :
    ?template_body:String.t ->
      ?template_u_r_l:String.t ->
        ?stack_name:String.t -> ?stack_set_name:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module GetTemplateSummaryOutput = GetTemplateSummaryOutput
type input = GetTemplateSummaryInput.t
type output = GetTemplateSummaryOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error