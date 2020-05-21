(** "<p>Returns the estimated monthly cost of a template. The return value is an AWS Simple Monthly Calculator URL with a query string that describes the resources required to run the template.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module EstimateTemplateCostInput :
sig
  type t =
    {
    template_body: String.t option ;
    template_u_r_l: String.t option ;
    parameters: Parameters.t }[@@ocaml.doc
                                "<p>The input for an <a>EstimateTemplateCost</a> action.</p>"]
  val make :
    ?template_body:String.t ->
      ?template_u_r_l:String.t -> ?parameters:Parameters.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module EstimateTemplateCostOutput = EstimateTemplateCostOutput
type input = EstimateTemplateCostInput.t
type output = EstimateTemplateCostOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error