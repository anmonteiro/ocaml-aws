(** "<p>Deletes a launch template. Deleting a launch template deletes all of its versions.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteLaunchTemplateRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    launch_template_id: String.t option ;
    launch_template_name: String.t option }
  val make :
    ?dry_run:Boolean.t ->
      ?launch_template_id:String.t ->
        ?launch_template_name:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DeleteLaunchTemplateResult = DeleteLaunchTemplateResult
type input = DeleteLaunchTemplateRequest.t
type output = DeleteLaunchTemplateResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error