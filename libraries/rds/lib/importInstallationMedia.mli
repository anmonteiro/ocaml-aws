(** "<p>Imports the installation media for a DB engine that requires an on-premises customer provided license, such as SQL Server.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ImportInstallationMediaMessage :
sig
  type t =
    {
    custom_availability_zone_id: String.t ;
    engine: String.t ;
    engine_version: String.t ;
    engine_installation_media_path: String.t ;
    o_s_installation_media_path: String.t }
  val make :
    custom_availability_zone_id:String.t ->
      engine:String.t ->
        engine_version:String.t ->
          engine_installation_media_path:String.t ->
            o_s_installation_media_path:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module InstallationMedia = InstallationMedia
type input = ImportInstallationMediaMessage.t
type output = InstallationMedia.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error