(** "<p>Retrieves the configuration data of the specified instance. You can use this data to create a launch template.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetLaunchTemplateDataRequest :
sig
  type t = {
    dry_run: Boolean.t option ;
    instance_id: String.t }
  val make : ?dry_run:Boolean.t -> instance_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module GetLaunchTemplateDataResult = GetLaunchTemplateDataResult
type input = GetLaunchTemplateDataRequest.t
type output = GetLaunchTemplateDataResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error