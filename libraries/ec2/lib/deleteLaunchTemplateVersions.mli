(** "<p>Deletes one or more versions of a launch template. You cannot delete the default version of a launch template; you must first assign a different version as the default. If the default version is the only version for the launch template, you must delete the entire launch template using <a>DeleteLaunchTemplate</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteLaunchTemplateVersionsRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    launch_template_id: String.t option ;
    launch_template_name: String.t option ;
    versions: VersionStringList.t }
  val make :
    ?dry_run:Boolean.t ->
      ?launch_template_id:String.t ->
        ?launch_template_name:String.t ->
          versions:VersionStringList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DeleteLaunchTemplateVersionsResult =
DeleteLaunchTemplateVersionsResult
type input = DeleteLaunchTemplateVersionsRequest.t
type output = DeleteLaunchTemplateVersionsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error