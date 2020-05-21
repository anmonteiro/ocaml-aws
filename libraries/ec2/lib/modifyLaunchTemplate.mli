(** "<p>Modifies a launch template. You can specify which version of the launch template to set as the default version. When launching an instance, the default version applies when a launch template version is not specified.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyLaunchTemplateRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    client_token: String.t option ;
    launch_template_id: String.t option ;
    launch_template_name: String.t option ;
    default_version: String.t option }
  val make :
    ?dry_run:Boolean.t ->
      ?client_token:String.t ->
        ?launch_template_id:String.t ->
          ?launch_template_name:String.t ->
            ?default_version:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyLaunchTemplateResult = ModifyLaunchTemplateResult
type input = ModifyLaunchTemplateRequest.t
type output = ModifyLaunchTemplateResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error