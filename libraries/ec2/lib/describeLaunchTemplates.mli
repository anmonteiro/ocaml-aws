(** "<p>Describes one or more launch templates.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeLaunchTemplatesRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    launch_template_ids: ValueStringList.t ;
    launch_template_names: LaunchTemplateNameStringList.t ;
    filters: FilterList.t ;
    next_token: String.t option ;
    max_results: Integer.t option }
  val make :
    ?dry_run:Boolean.t ->
      ?launch_template_ids:ValueStringList.t ->
        ?launch_template_names:LaunchTemplateNameStringList.t ->
          ?filters:FilterList.t ->
            ?next_token:String.t -> ?max_results:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeLaunchTemplatesResult = DescribeLaunchTemplatesResult
type input = DescribeLaunchTemplatesRequest.t
type output = DescribeLaunchTemplatesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error