(** "<p>Describes the available installation media for a DB engine that requires an on-premises customer provided license, such as Microsoft SQL Server.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeInstallationMediaMessage :
sig
  type t =
    {
    installation_media_id: String.t option ;
    filters: FilterList.t ;
    max_records: Integer.t option ;
    marker: String.t option }
  val make :
    ?installation_media_id:String.t ->
      ?filters:FilterList.t ->
        ?max_records:Integer.t -> ?marker:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module InstallationMediaMessage = InstallationMediaMessage
type input = DescribeInstallationMediaMessage.t
type output = InstallationMediaMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error