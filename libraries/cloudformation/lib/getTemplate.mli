(** "<p>Returns the template body for a specified stack. You can get the template for running or deleted stacks.</p> <p>For deleted stacks, GetTemplate returns the template for up to 90 days after the stack has been deleted.</p> <note> <p> If the template does not exist, a <code>ValidationError</code> is returned. </p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetTemplateInput :
sig
  type t =
    {
    stack_name: String.t option ;
    change_set_name: String.t option ;
    template_stage: TemplateStage.t option }[@@ocaml.doc
                                              "<p>The input for a <a>GetTemplate</a> action.</p>"]
  val make :
    ?stack_name:String.t ->
      ?change_set_name:String.t ->
        ?template_stage:TemplateStage.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module GetTemplateOutput = GetTemplateOutput
type input = GetTemplateInput.t
type output = GetTemplateOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error