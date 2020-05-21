(** "<p>Creates a stack set.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateStackSetInput :
sig
  type t =
    {
    stack_set_name: String.t ;
    description: String.t option ;
    template_body: String.t option ;
    template_u_r_l: String.t option ;
    parameters: Parameters.t ;
    capabilities: Capabilities.t ;
    tags: Tags.t ;
    administration_role_a_r_n: String.t option ;
    execution_role_name: String.t option ;
    client_request_token: String.t option }
  val make :
    stack_set_name:String.t ->
      ?description:String.t ->
        ?template_body:String.t ->
          ?template_u_r_l:String.t ->
            ?parameters:Parameters.t ->
              ?capabilities:Capabilities.t ->
                ?tags:Tags.t ->
                  ?administration_role_a_r_n:String.t ->
                    ?execution_role_name:String.t ->
                      ?client_request_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateStackSetOutput = CreateStackSetOutput
type input = CreateStackSetInput.t
type output = CreateStackSetOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error