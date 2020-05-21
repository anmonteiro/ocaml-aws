(** "<p>Validates a specified template. AWS CloudFormation first checks if the template is valid JSON. If it isn't, AWS CloudFormation checks if the template is valid YAML. If both these checks fail, AWS CloudFormation returns a template validation error.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ValidateTemplateInput :
sig
  type t = {
    template_body: String.t option ;
    template_u_r_l: String.t option }[@@ocaml.doc
                                       "<p>The input for <a>ValidateTemplate</a> action.</p>"]
  val make : ?template_body:String.t -> ?template_u_r_l:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ValidateTemplateOutput = ValidateTemplateOutput
type input = ValidateTemplateInput.t
type output = ValidateTemplateOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error