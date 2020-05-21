(** "<p>Deletes the installation medium for a DB engine that requires an on-premises customer provided license, such as Microsoft SQL Server.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteInstallationMediaMessage :
sig
  type t = {
    installation_media_id: String.t }
  val make : installation_media_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module InstallationMedia = InstallationMedia
type input = DeleteInstallationMediaMessage.t
type output = InstallationMedia.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error