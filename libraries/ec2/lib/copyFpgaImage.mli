(** "<p>Copies the specified Amazon FPGA Image (AFI) to the current Region.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CopyFpgaImageRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    source_fpga_image_id: String.t ;
    description: String.t option ;
    name: String.t option ;
    source_region: String.t ;
    client_token: String.t option }
  val make :
    ?dry_run:Boolean.t ->
      source_fpga_image_id:String.t ->
        ?description:String.t ->
          ?name:String.t ->
            source_region:String.t -> ?client_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CopyFpgaImageResult = CopyFpgaImageResult
type input = CopyFpgaImageRequest.t
type output = CopyFpgaImageResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error