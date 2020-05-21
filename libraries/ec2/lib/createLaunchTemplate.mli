(** "<p>Creates a launch template. A launch template contains the parameters to launch an instance. When you launch an instance using <a>RunInstances</a>, you can specify a launch template instead of providing the launch parameters in the request.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateLaunchTemplateRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    client_token: String.t option ;
    launch_template_name: String.t ;
    version_description: String.t option ;
    launch_template_data: RequestLaunchTemplateData.t ;
    tag_specifications: TagSpecificationList.t }
  val make :
    ?dry_run:Boolean.t ->
      ?client_token:String.t ->
        launch_template_name:String.t ->
          ?version_description:String.t ->
            launch_template_data:RequestLaunchTemplateData.t ->
              ?tag_specifications:TagSpecificationList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateLaunchTemplateResult = CreateLaunchTemplateResult
type input = CreateLaunchTemplateRequest.t
type output = CreateLaunchTemplateResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error