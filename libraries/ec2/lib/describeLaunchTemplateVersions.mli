(** "<p>Describes one or more versions of a specified launch template. You can describe all versions, individual versions, or a range of versions.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeLaunchTemplateVersionsRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    launch_template_id: String.t option ;
    launch_template_name: String.t option ;
    versions: VersionStringList.t ;
    min_version: String.t option ;
    max_version: String.t option ;
    next_token: String.t option ;
    max_results: Integer.t option ;
    filters: FilterList.t }
  val make :
    ?dry_run:Boolean.t ->
      ?launch_template_id:String.t ->
        ?launch_template_name:String.t ->
          ?versions:VersionStringList.t ->
            ?min_version:String.t ->
              ?max_version:String.t ->
                ?next_token:String.t ->
                  ?max_results:Integer.t ->
                    ?filters:FilterList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeLaunchTemplateVersionsResult =
DescribeLaunchTemplateVersionsResult
type input = DescribeLaunchTemplateVersionsRequest.t
type output = DescribeLaunchTemplateVersionsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error