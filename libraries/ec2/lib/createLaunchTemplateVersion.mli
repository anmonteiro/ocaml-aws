(** "<p>Creates a new version for a launch template. You can specify an existing version of launch template from which to base the new version.</p> <p>Launch template versions are numbered in the order in which they are created. You cannot specify, change, or replace the numbering of launch template versions.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateLaunchTemplateVersionRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    client_token: String.t option ;
    launch_template_id: String.t option ;
    launch_template_name: String.t option ;
    source_version: String.t option ;
    version_description: String.t option ;
    launch_template_data: RequestLaunchTemplateData.t }
  val make :
    ?dry_run:Boolean.t ->
      ?client_token:String.t ->
        ?launch_template_id:String.t ->
          ?launch_template_name:String.t ->
            ?source_version:String.t ->
              ?version_description:String.t ->
                launch_template_data:RequestLaunchTemplateData.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateLaunchTemplateVersionResult = CreateLaunchTemplateVersionResult
type input = CreateLaunchTemplateVersionRequest.t
type output = CreateLaunchTemplateVersionResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error